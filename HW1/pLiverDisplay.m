%% Copyright
% Pfizer Inc.
% All Rights Reserved.

%%
function pLiverDisplay(action, varargin)
%pLiverDisplay   
% 
%   Display and process ultrasound images
%
% Function Subroutines:
%   Initialize          Set up controls and axes.  Call other functions 
%                         
%   LoadImages          Load a new image from the New Image Popup menu.

%   DispIm, DrawROI, ApplyROI, StoreData, SaveData

if nargin<1,
   action='Initialize';
end;

feval(action,varargin{:});
return;

%%%
%%%  Sub-function - Initialize
%%%

function Initialize()
GuiViewFig = figure( ...
   'Name','pLiverDisplay - Pfizer Pfreeware', ...
   'NumberTitle','off', 'HandleVisibility', 'on', ...
   'tag', 'pLiverDisplay', 'Position', [100 200 800 600], ...
   'Visible','on', 'Resize', 'on',...
   'BusyAction','Queue','Interruptible','off', ...
   'Color', [.8 .8 .8], 'Pointer', 'arrow',...
   'DoubleBuffer', 'on','IntegerHandle', 'off', ...
   'Colormap', gray(256));     

f = uimenu('Label','Load');  
f1 = uimenu('Label','Load DICOM','parent',f,'Callback','pLiverDisplay(''LoadImages'',1)' );
f2 = uimenu('Label','Load 2nd DICOM','parent',f,'Callback','pLiverDisplay(''LoadImages'',2)' );

ud.Computer = computer;

Std.Interruptible = 'off';  Std1.BusyAction = 'queue';   

% Defaults for image axes
Ax1 = Std;
Ax1.Units = 'normalized';  %Ax1.Units = 'Pixels';
Ax1.Parent = GuiViewFig; Ax1.ydir = 'reverse';
Ax1.XLim = [.5 128.5]; Ax1.YLim = [.5 128.5];
Ax1.CLim = [0 1];  Ax1.XTick = []; Ax1.YTick = [];

% Ax2 = Std;
% Ax2.Units = 'normalized';  % Ax2.Units = 'Pixels';
% Ax2.Parent = GuiViewFig; Ax2.ydir = 'reverse';
% Ax2.XLim = [.5 128.5]; Ax2.YLim = [.5 128.5];
% Ax2.CLim = [0 1];  Ax2.XTick = []; Ax2.YTick = [];

%================================
% Original Image 
ud.hAx1 = axes(Ax1,'Position', [.02 .12 .75 .75]);   % [10 100 256 256]

% ud.hAx2 = axes(Ax2,'Position', [.53 .2 .45 .45]);   % [296 100 256 256]
%===============================
% Frames
uicontrol('Style', 'frame', 'Units', 'normalized',...
    'Position',[.06 .88 .30 .11],'BackgroundColor', [0 1 0]);
ud.hframe = uicontrol('Style', 'text', 'Units', 'normalized',...
    'HorizontalAlignment','left',...
    'Position',[.065 .885 .29 .1],'BackgroundColor', [1 1 1]);
% uicontrol('Style', 'frame', 'Units', 'normalized',...
%     'Position',[.41 .77 .58 .22],'BackgroundColor', [0 1 0]);
% ud.hframe2 = uicontrol('Style', 'text', 'Units', 'normalized',...
%     'HorizontalAlignment','left',...
%     'Position',[.415 .775 .57 .21],'BackgroundColor', [1 1 1]);

%==========================
% Slider 1
uicontrol('Style','text','Units','normalized',...
    'Position',[.16 .01 .10 .03],...
    'BackgroundColor',[1 .8 1],'String','Frame');
uicontrol('style','text','Units','normalized',...
    'Position',[.02 .05 .02 .04],...
    'BackgroundColor',[1 .5 .8],'String','1');
ud.h_fmax1=uicontrol('style','text','Units','normalized',...
    'Position',[.75 .05 .02 .04 ],...
    'BackgroundColor',[1 .5 .8],'String','4');
ud.frame_num1=uicontrol('Style','text','Units','normalized',...
    'Position',[.26 .01 .03 .03],'HorizontalAlignment','left',...
    'String','1','BackgroundColor','w');
ud.h_im_slider1=uicontrol('Style','slider','Units','normalized',...
    'Position',[.04 .05 .71 .04],'Value',1,'Max',4,'Min',1,...
    'SliderStep',[.33 .1],'Callback','pLiverDisplay(''DispIm'',1)');


%====================================
% Buttons

uicontrol('Style','Pushbutton','Units','normalized',...
    'Position',[.56 .94 .1 .04], 'BackgroundColor',[.8 .6 .9],...
    'String','Brighten', 'Callback','pLiverDisplay(''BrightenIm'')');
uicontrol('Style','Pushbutton','Units','normalized',...
    'Position',[.56 .88 .1 .04], 'BackgroundColor',[.6 .4 .7],...
    'String','Darken', 'Callback','pLiverDisplay(''DarkenIm'')');
ud.hROI=uicontrol('Style','Pushbutton','Units','normalized',...
    'Position',[.68 .9 .1 .04], 'BackgroundColor',[.5 .5 .8],...
    'String','ROI ', 'Callback','pLiverDisplay(''DrawROI'')');

uicontrol('Style','Pushbutton','Units','normalized',...
    'ForegroundColor',[1 1 1],...
    'Position',[.88 .9 .07 .05], 'BackgroundColor',[.3 .3 .3],...
    'String','Close', 'Callback','close');

ud.DAT=[]; ud.newSubjNum=0;
set(GuiViewFig, 'UserData', ud,'Visible','on');


return

%%%
%%%  Sub-Function - LoadImages
%%%
function LoadImages(s)
ud = get(gcbf, 'UserData'); str=[];
if ~isfield(ud,'pname'),
  ud.pname='N:\DGAT_USdata\ST1\SE1\';   end;

    [fname,upname]=uigetfile([ud.pname '*.*'],'Dicom');
    ud.pname=upname;
    str=[str  ' ' upname char(10)];

    D1=dir(upname);   Nfi=length(D1)-2;    %Nfi = # files in directory
    setptr(gcf, 'watch'); % pause(1)
    for  f1=1:Nfi,  %
        fname=[upname '\' D1(2+f1).name]; % Check first file for either of 2 series
        info = dicominfo(fname);
        X=dicomread(info);   ud.img1(:,:,f1)=X;
    end % for f1
    axes(ud.hAx1); imagesc(ud.img1(:,:,1)),
   
    set(ud.frame_num1,'string',int2str(1));
    set(ud.h_fmax1,'string',int2str(Nfi));
    set(ud.h_im_slider1,'val',1,'Max',Nfi,'SliderStep',[1/(Nfi-1) .1]);

colormap(gray(255))
ud.PFtot=[];  ud.PixTot=0; ud.PerFat=[]; % Initialize total pix stats
set(ud.hframe,'String',str);  setptr(gcf, 'arrow');
set(gcbf, 'UserData', ud);


%%%
%%%  Sub-Function - DispIm
%%%
function DispIm(s)
ud = get(gcf, 'UserData');
if s==1,
  fnum=round(get(ud.h_im_slider1,'val'));
  set(ud.frame_num1,'string',int2str(fnum));
  axes(ud.hAx1); imagesc(ud.img1(:,:,fnum)), axis off
else
  fnum=round(get(ud.h_im_slider2,'val'));
  set(ud.frame_num2,'string',int2str(fnum));
  axes(ud.hAx2); imagesc(ud.img2(:,:,fnum)), axis off
end
set(gcf, 'UserData', ud); 

%%%
%%%  Sub-Function - BrightenIm
%%%
function BrightenIm
ud = get(gcf, 'UserData');
 axes(ud.hAx1); brighten(.2)
 
%%%
%%%  Sub-Function - DarkenIm
%%%
function DarkenIm
ud = get(gcf, 'UserData');
 axes(ud.hAx1); brighten(-.2)


%%%
%%%  Sub-Function - DrawROI
%%%
% Draw ROI and compute %fat at each pixel. Save mean, std, median and
% #pixels
function DrawROI
ud = get(gcf, 'UserData'); % Get slice numbers

fnum=round(get(ud.h_im_slider1,'val')); 
X1=ud.img1(:,:,fnum); 
Button='No';
while strcmp(Button,'No'),
    axes(ud.hAx1); imagesc(X1), axis off
    set(ud.hframe,'str','Draw ROI on liver');
    [BW,xi,yi]=roipoly; totBW=sum(BW(:)); % Draw ROI and compute # pixels
    ud.BW=BW; ud.xi=xi; ud.yi=yi;
    ind=find(BW); Xs1=mean(double(X1(ind)));% Compute stats on pixels in ROI
    xi=round(xi); yi=round(yi); hold on, plot(xi,yi,'r'), hold off
    set(ud.hframe,'str','Draw ROI on kidney');
    [BW,xi,yi]=roipoly; totBW=sum(BW(:)); % Draw ROI and compute # pixels
    ud.BW=BW; ud.xi=xi; ud.yi=yi;
    ind=find(BW); Xs2=mean(double(X1(ind)));% Compute stats on pixels in ROI
    xi=round(xi); yi=round(yi); hold on, plot(xi,yi,'w'), hold off
    
    LKr=Xs1/Xs2;  % Compute %Fat at each pixel
    set(ud.hframe,'String',[' Liver/Kidney = ' num2str(LKr,4)]);
    Button=questdlg('Save Data?','Stats','Yes','No','Yes');
    if strcmp(Button,'Yes'), 
        ud.PFtot=[ud.PFtot ; LKr]; 
        set(gcf, 'UserData', ud);
     end
end % while

%%%
%%%  Sub-Function - DataSummary
%%%
function DataSummary
ud = get(gcbf, 'UserData');  % Compute average of all stored data (from different slices).
mf=mean(ud.PFtot); sf=std(ud.PFtot);
set(ud.hframe,'String',[' Fat = ' num2str(mf,4) '+/-' num2str(sf,4) '%']);


%%%
%%%  Sub-Function - StoreData
%%%
function StoreData
ud = get(gcf, 'UserData');  % n=size(ud.DAT,1);
Ns=ud.SubNum; % Subject number
Nv=ud.visit; Nr=ud.roiNum;  % Visit number and ROI number
n=(Ns-1)*5+Nr+1;  % Row number  (each subject has 5 rows - 1 for each ROI, plus combined)
%ud.Sname fields: name date time scan1 scan2
ud.Sname(n).name=ud.name;  ud.Sname(n).visit=Nv;
ud.Sname(n).date(Nv)=ud.date; 
ud.Sname(n).scan1(Nv)=round(get(ud.h_im_slider1,'val'));
ud.DAT(n,Nv*4-3+(1:4))=[ ud.nROIpix ud.MeanF ud.StdF ud.MedF];
ud.roi(n,Nv).xi=ud.xi; ud.roi(n,Nv).yi=ud.yi; % xy-Coordinates of ROI
if Nr==4, % If last ROI, compute total stats from all pixels
    n=(Ns-1)*5+1; % Row number (row before other ROIs)
    ud.Sname(n).name=ud.name;  ud.Sname(n).visit=Nv;
    ud.Sname(n).date(Nv)=ud.date; 
    ud.Sname(n).scan1(Nv)=0;     ud.Sname(n).scan2(Nv)=0;
    PFtot=ud.PFtot;  
    MeanF=mean(PFtot); StdF=std(PFtot); MedF=median(PFtot); 
    ud.DAT(n,Nv*4-3+(1:4))=[ud.PixTot MeanF StdF MedF];
    ud.roi(n,Nv).xi=0; ud.roi(n,Nv).yi=0; % xy-Coordinates of ROI
end % if

set(gcf, 'UserData', ud);


