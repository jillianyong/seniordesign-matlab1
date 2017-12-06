%% Copyright 2017
% Rita Chen richen@bu.edu
% Max Christ mmchrist@bu.edu
% Jillian Yong jeyong@bu.edu
% All Rights Reserved

%%
%Create title page

function HW2


% Create Drop Down Menu
% global figure
GuiViewFig = uifigure;
global ax;


ax = uiaxes('Parent',GuiViewFig,'Position',[10 10 400 400],'visible', ...
    'off');

% Create GUI background
% GuiViewFig = figure( ...
%    'Name','HW2', ...
%    'NumberTitle','off', 'HandleVisibility', 'on', ...
%    'tag', 'pLiverDisplay', 'Position', [100 200 800 600], ...
%    'Visible','on', 'Resize', 'on',...
%    'BusyAction','Queue','Interruptible','off', ...
%    'Color', [.8 .8 .8], 'Pointer', 'arrow',...
%    'DoubleBuffer', 'on','IntegerHandle', 'off', ...
%    'Colormap', gray(256));

 global ddmenu;
 global b1;
 global b2;
 global txt;
 
 
% ax = uiaxes('Parent',GuiViewFig,'Position',[10 10 400 400]);

% Buttons
b1 = uicontrol( 'visible', ...
    'off', 'Style','Pushbutton','Units','normalized',...
    'Position',[.2 .5 .2 .1], 'BackgroundColor',[.8 .6 .9],...
    'String','Scatter Plot','FontSize', 18,'Callback',@scat);
b2 = uicontrol('visible', ...
    'off','Style','Pushbutton','Units','normalized',...
    'Position',[.6 .5 .2 .1], 'BackgroundColor',[.6 .4 .7],...
    'String','Histogram','FontSize', 18, 'Callback',@scat);

% Add a text uicontrol for user instructions
txt = uicontrol('visible', ...
    'off','Style','text',...
      'Units','normalized',...
      'Position',[.2 .7 .6 .05],...
      'BackgroundColor',[.8 .8 .8],...
      'FontSize', 18,...
      'String','Please select a button to display different figures.');
 


% Creating a dropdown menu
%%set(figure, 'visible','on')
ddmenu = uidropdown(GuiViewFig,...
    'Position',[430 210 100 22],...
    'Items',{'Waist Circumference', 'Mean Liver Fat p', 'Total Fat',...
    'Age', 'Weight', 'Height', 'BMI', 'Sex', 'Race', 'Diabetes'},...
    'Value','BMI',...
    'ValueChangedFcn',@(ddmenu,event) selection(ddmenu),'visible', 'off');

% Creating a dropdown menu
set([GuiViewFig, b1, b2 txt], 'visible','on');


function scat(hObject,eventdata)
    set([b1,b2,txt],'visible','off');
    set([ax,ddmenu],'visible','on');
end


% Create ValueChangedFcn callback:
    function selection(ddmenu, eventdata, handles)
    x = detectImportOptions('liver_fat_with_covariates.csv');
    T = readtable('liver_fat_with_covariates.csv',x);
    choice = get(ddmenu,'Value');
    switch choice
        case {'Waist Circumference'}
            waist_cir = T.waist_cir3;
            histogram(ax,waist_cir)
            waist_cir(isnan(waist_cir)) = [];
            meanwaistcir = mean(waist_cir);
            medianwaistcir = median(waist_cir);
            fivepwaistcir = prctile(waist_cir,5);
            ninefivepwaistcir = prctile(waist_cir,95);
        case {'Mean Liver Fat p'}
            mean_liver_fat_p = T.mean_liver_fat_p;
            histogram(ax,mean_liver_fat_p)
            mean_liver_fat_p(isnan(mean_liver_fat_p)) = [];
            meanlivfatp = mean(mean_liver_fat_p);
            medianlivfatp = median(mean_liver_fat_p);
            fiveplivfatp = prctile(mean_liver_fat_p,5);
            ninefiveplivfatp = prctile(mean_liver_fat_p,95);
        case {'Total Fat'}
            total_fat = T.total_fat;
            histogram(ax,total_fat)
            total_fat(isnan(total_fat)) = [];
            meantotfat = mean(total_fat);
            mediantotfat = median(total_fat);
            fiveptotfat = prctile(total_fat,5);
            ninefiveptotfat = prctile(total_fat,95);
        case {'Age'}
            age = T.age3;
            histogram(ax,age)
            age(isnan(age)) = [];
            meanage = mean(age);
            medianage = median(age);
            fivepage = prctile(age,5);
            ninefivepage = prctile(age,95);
        case {'Weight'}
            weight = T.weight3;
            histogram(ax,weight)
            weight(isnan(weight)) = [];
            meanweight = mean(weight);
            medianweight = median(weight);
            fivepweight = prctile(weight,5);
            ninefivepweight = prctile(weight,95);
        case {'Height'}
            height = T.height3;
            histogram(ax,height)
            height(isnan(height)) = [];
            meanheight = mean(height);
            medianheight = median(height);
            fivepheight = prctile(height,5);
            ninefivepheight = prctile(height,95);
        case {'BMI'}
            bmi = T.bmi3;
            histogram(ax,bmi)
            bmi(isnan(bmi)) = [];
            meanbmi = mean(bmi);
            medianbmi = median(bmi);
            fivepbmi = prctile(bmi,5);
            ninefivepbmi = prctile(bmi,95);
        case {'Sex'}
            sex = T.sex;
            c1 = categorical(sex);
            histogram(ax,c1)
        case {'Race'}
            race = T.race3;
            c2 = categorical(race);
            histogram(ax,c2)
        case {'Diabetes'}
            diabetes = T.diabetes3;
            c3 = categorical(diabetes);
            histogram(ax,c3)
    end
    end
end  
