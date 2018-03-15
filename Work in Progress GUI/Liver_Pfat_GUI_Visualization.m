function Liver_Pfat_GUI_Without_sprintf
% Global Variables for Imported Data
global T;
global Thist;
global mTscat;
global fTscat;
global nmTscat;
global nfTscat;
global choice2;
global choice3;
global scatvar1label;
global scatvar2label;

% Import Data
load('LiverTable.mat','T');
Thist = T;
mTscat = T;
fTscat = T;
nmTscat = mTscat;
nfTscat = fTscat;

% Create global variables
 global uif;
 global helpfig;
 global ddmenu;
 global ddmenu2;
 global ddmenu3;
 global b3;
 global b4;
 global ax;
 global ax2;
 global histy;
 global m_scatter_x;
 global m_scatter_y;
 global f_scatter_x;
 global f_scatter_y;
 global xaxis_label;
 global yaxis_label;
 global label1;
 global label2;
 global titleall;
 global title1;
 global title2;
 global bg1;
 global bg2;
 global bg3;
 global bg4;
 global bg5;
 global bg6;
 global bg7;
 global tb1;
 global tb2;
 global tb3;
 global tb4;
 global tb5;
 global tb6;
 global tb7;
 global tb8;
 global tb9;
 global tb10;
 global tb11;
 global tb12;
 global tb13;
 global tb14;
 global tb15;
 global tb16;
 global tb17;
 global tb18;
 global tbover;
 global rb1;
 global rb2;
 global rb3;
 global rb4;
 global histmf;
 global histage;
 global histhealth;
 global scatage;
 global scathealth;
 global scatmf;
 global label3;
 global label4;
 global label5;
 global label6;
 global pan1;
 global pan2;
 global pan3;
 global pan4;
 global pan5;

% Initiate Toggle Switches 
histmf = 'All';
histage = 'All';
histhealth = 'All'; 

scatage = 'All';
scathealth = 'All';
scatmf = 'All';

scatvar1label = 'All';
scatvar2label = 'All';

% Create Window and Axes
uif = uifigure('visible','off','name','Pfabulous Pfun with Liver Pfat: A Story of Correlations and Distributions of Relevant Variables', 'Position',[20 20 1000 1000]);
ax = uiaxes('Parent',uif,'Position',[10 10 400 400],'visible','off'); % Axis for Histogram 
ax2 = uiaxes('Parent',uif,'Position',[550 10 400 400],'visible','off'); % Axis for Scatter Plot

titleall = uilabel('Text','Correlations and Distributions of Variables Related to NAFLD','Parent',uif,...
            'Position',[100 700 1000 40],'FontSize',30); % Title for all
title1 = uilabel('Text','Histogram','Parent',uif,...
            'Position',[50 650 150 40],'FontSize',24); % Title for Scatter Plot
title2 = uilabel('Text','Scatter Plot','Parent',uif,...
            'Position',[600 650 150 40],'FontSize',24); % Title for Histogram

pan1 = uipanel('Parent',uif,'Title','Relevant Statistics','FontWeight','bold',...
             'BackgroundColor','white',...
             'Position',[50 420 150 100],'Units','pixels','visible','off');

pan2 = uipanel('Parent',uif,'Title','Relevant Statistics','FontWeight','bold',...
             'BackgroundColor','white',...
             'Position',[600 420 230 60],'Units','pixels','visible','off');

pan3 = uilabel('Parent',uif,'text','Please select a filter:','FontWeight','bold',... %for Histogram
             'Position',[50 585 150 50],'visible','off');
         
pan4 = uilabel('Parent',uif,'text','Please select a filter:','FontWeight','bold',... %for Scatter Plot
             'Position',[600 555 150 50],'visible','off');
         
b3 = uibutton(uif,'push',...
               'Text', 'Plot', 'visible','off','Position',[600, 610, 40, 20], ...
               'ButtonPushedFcn', @(b3,event) plotButtonPushed(b3,ax2)); % Push button for Scatter Plot 

b4 = uibutton(uif,'push',...
               'Text', 'Help', 'visible','off','Position',[930, 730, 40, 20], ...
               'ButtonPushedFcn', @(b4,event) OpenHelpMenu(b4)); % Push button for Scatter Plot 
           
bg1 = uibuttongroup(uif,'Position',[50 540 80 80],'visible', 'off','SelectionChangedFcn',@bg1fn); % Toggle switches Position for Histogram
bg2 = uibuttongroup(uif,'Position',[130 540 80 60],'visible', 'off','SelectionChangedFcn',@bg2fn); % Toggle switches Position for Histogram
bg3 = uibuttongroup(uif,'Position',[210 540 80 60],'visible', 'off','SelectionChangedFcn',@bg3fn); % Toggle switches Position for Histogram
bg4 = uibuttongroup(uif,'Position',[600 525 80 60],'visible', 'off','SelectionChangedFcn',@bg4fn); % Toggle switches Position for Scatter Plot
bg5 = uibuttongroup(uif,'Position',[680 525 80 60],'visible', 'off','SelectionChangedFcn',@bg5fn); % Toggle switches Position for Scatter Plot
bg6 = uibuttongroup(uif,'Position',[760 525 80 60],'visible', 'off','SelectionChangedFcn',@bg6fn); % Toggle switches Position for Scatter Plot
bg7 = uibuttongroup(uif,'Position',[600 485 250 37],'visible', 'off','Title', 'Choose variable to distinguish:','FontWeight','bold','BackgroundColor','white','SelectionChangedFcn',@bg7fn); % Radio buttons for Scatter Plot

% Individual Toggle switches Position for Histogram
tb1 = uitogglebutton(bg1,'Position',[0 60 80 20],'Text','All');
tbover = uitogglebutton(bg1,'Position',[0 40 80 20],'Text','Overlay');
tb2 = uitogglebutton(bg1,'Position',[0 20 80 20],'Text','Male');
tb3 = uitogglebutton(bg1,'Position',[0 0 80 20],'Text','Female');

% Individual Toggle switches Position for Histogram
tb4 = uitogglebutton(bg2,'Position',[0 40 80 20],'Text','All');
tb5 = uitogglebutton(bg2,'Position',[0 20 80 20],'Text','Healthy');
tb6 = uitogglebutton(bg2,'Position',[0 0 80 20],'Text','Unhealthy');

% Individual Toggle switches Position for Histogram
tb7 = uitogglebutton(bg3,'Position',[0 40 80 20],'Text','All');
tb8 = uitogglebutton(bg3,'Position',[0 20 80 20],'Text','<69');
tb9 = uitogglebutton(bg3,'Position',[0 0 80 20],'Text','>=69');

% Individual Toggle switches Position for Scatter Plot
tb10 = uitogglebutton(bg4,'Position',[0 40 80 20],'Text','All');
tb11 = uitogglebutton(bg4,'Position',[0 20 80 20],'Text','Male');
tb12 = uitogglebutton(bg4,'Position',[0 0 80 20],'Text','Female');

% Individual Toggle switches Position for Scatter Plot
tb13 = uitogglebutton(bg5,'Position',[0 40 80 20],'Text','All');
tb14 = uitogglebutton(bg5,'Position',[0 20 80 20],'Text','Healthy');
tb15 = uitogglebutton(bg5,'Position',[0 0 80 20],'Text','Unhealthy');

% Individual Toggle switches Position for Scatter Plot
tb16 = uitogglebutton(bg6,'Position',[0 40 80 20],'Text','All');
tb17 = uitogglebutton(bg6,'Position',[0 20 80 20],'Text','<69');
tb18 = uitogglebutton(bg6,'Position',[0 0 80 20],'Text','>=69');

%Radio button for Color Coding
rb1 = uiradiobutton(bg7, 'Position',[0 1 40 15],'Text','All');
rb2 = uiradiobutton(bg7,'Position',[40 1 60 15],'Text','Gender');
rb3 = uiradiobutton(bg7,'Position',[110 1 80 15],'Text','Healthiness');
rb4 = uiradiobutton(bg7,'Position',[200 1 80 15],'Text','Age');

% Creating a dropdown menu for Histogram
ddmenu = uidropdown(uif,...
    'Position',[50 635 100 20],...
    'Items',{'Waist Circumference', 'Mean Liver Fat p', 'Total Fat Index',...
    'Age', 'Weight', 'Height', 'BMI','Activity Index', 'Sex', 'Race', 'Diabetes'},...
    'Value','BMI',...
    'ValueChangedFcn',@(ddmenu,event) selection(ddmenu),'visible', 'off');

% Creating a dropdown menu for Scatter Plot
ddmenu2 = uidropdown(uif,...
    'Position',[600 635 120 20],...
    'Items',{'Select X Variable:','Waist Circumference', 'Mean Liver Fat p', 'Total Fat Index',...
    'Age', 'Weight', 'Height', 'BMI', 'Activity Index'},...
    'Value','Select X Variable:',...
    'ValueChangedFcn',@(ddmenu2,event) selection2(ddmenu2),'visible', 'off');

% Creating a dropdown menu for Scatter Plot
ddmenu3 = uidropdown(uif,...
    'Position',[740 635 120 20],...
    'Items',{'Select Y Variable:','Waist Circumference', 'Mean Liver Fat p', 'Total Fat Index',...
    'Age', 'Weight', 'Height', 'BMI','Activity Index'},...
    'Value','Select Y Variable:',...
    'ValueChangedFcn',@(ddmenu3,event) selection3(ddmenu3),'visible', 'off');

set([ uif, ddmenu2, ddmenu3, b3, b4, ddmenu, bg1, bg2, bg3, bg4, bg5, bg6, bg7, pan1, pan2, pan3, pan4], 'visible','on');

% Create ValueChangedFcn callback for Histogram:
function selection(ddmenu, eventdata, handles)
    choice = get(ddmenu,'Value');
    switch histmf
        case {'Male'}
            histind = (strcmp(Thist.sex, 'Male'));
            Thist = Thist(histind,:);
        case {'Female'}
            histind = (strcmp(Thist.sex, 'Female'));
            Thist = Thist(histind,:);
        case {'Overlay'}
            
        case {'All'}
    end
    
    switch histhealth
        case {'Healthy'}
            histind = (Thist.healthy_icd_and_self_reported_fi == 1);
            Thist = Thist(histind,:);
        case {'Unhealthy'}
            histind = (Thist.healthy_icd_and_self_reported_fi == 0);
            Thist = Thist(histind,:);
        case {'All'}
    end
    
    switch histage
        case {'<69'}
            histind = (Thist.age3 < 69);
            Thist = Thist(histind,:);
        case {'>=69'}
            histind = (Thist.age3 >= 69);
            Thist = Thist(histind,:);
        case {'All'}
    end

    % Switching between different variables for Histogram
    switch choice
        case {'Waist Circumference'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            if (ishandle(label3))
            set(label3, 'visible','off');
            end
            if (ishandle(label4))
            set(label4, 'visible','off');
            end
            if (ishandle(label5))
            set(label5, 'visible','off');
            end
            if (ishandle(label6))
            set(label6, 'visible','off');
            end
            waist_cir = Thist.waist_cir3;
            if(strcmp(histmf, 'Overlay'))
                histind = (strcmp(Thist.sex, 'Male'));
                mThist = Thist(histind,:);
                mwaist_cir = mThist.waist_cir3;
                mhisty = histogram(ax,mwaist_cir,'facealpha',0.5,'facecolor','b');
                hold(ax,'on')
                histind = (strcmp(Thist.sex, 'Female'));
                fThist = Thist(histind,:);
                fwaist_cir = fThist.waist_cir3;
                fhisty = histogram(ax,fwaist_cir,'facealpha',0.5,'facecolor','r');
                legend(ax,'Male','Female')
            else
                histy = histogram(ax,waist_cir);
            end
            ax.XLim = [50 150]; 
            ax.YLim = [0 550];
            waist_cir(isnan(waist_cir)) = [];
            meanwaistcir = num2str(round(mean(waist_cir),2));
            medianwaistcir = num2str(round(median(waist_cir),2));
            fivepwaistcir = num2str(round(prctile(waist_cir,5),2));
            ninefivepwaistcir = num2str(round(prctile(waist_cir,95),2));
            meantxt = 'Mean:';
            mediantxt = 'Median:';
            fivetxt = '5th Percentile:';
            ninefivetxt =  '95th Percentile:';
            circstr1 = strcat(meantxt,meanwaistcir);
            circstr2 = strcat(mediantxt,medianwaistcir);
            circstr3 = strcat(fivetxt,fivepwaistcir);
            circstr4 = strcat(ninefivetxt,ninefivepwaistcir);
            label3 = uilabel('Text',circstr1,'Parent',pan1,...
            'Position',[10 60 180 20]);
            label4 = uilabel('Text',circstr2,'Parent',pan1,...
            'Position',[10 40 180 20]);
            label5 = uilabel('Text',circstr3,'Parent',pan1,...
            'Position',[10 20 180 20]);
            label6 = uilabel('Text',circstr4,'Parent',pan1,...
            'Position',[10 0 180 20]);
            xlabel(ax,'Waist Circumference (cm)');
            ylabel(ax,'Frequency');
            
        case {'Mean Liver Fat p'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            if (ishandle(label3))
            set(label3, 'visible','off');
            end
            if (ishandle(label4))
            set(label4, 'visible','off');
            end
            if (ishandle(label5))
            set(label5, 'visible','off');
            end
            if (ishandle(label6))
            set(label6, 'visible','off');
            end             
            mean_liver_fat_p = Thist.mean_liver_fat_p;
            if(strcmp(histmf, 'Overlay'))
                histind = (strcmp(Thist.sex, 'Male'));
                mThist = Thist(histind,:);
                mmean_liver_fat_p = mThist.mean_liver_fat_p;
                mhisty = histogram(ax,mmean_liver_fat_p,'facealpha',0.5,'facecolor','b');
                hold(ax,'on')
                histind = (strcmp(Thist.sex, 'Female'));
                fThist = Thist(histind,:);
                fmean_liver_fat_p = fThist.mean_liver_fat_p;
                fhisty = histogram(ax,fmean_liver_fat_p,'facealpha',0.5,'facecolor','r');
                legend(ax,'Male','Female')
            else
                histy = histogram(ax,mean_liver_fat_p);
            end
            ax.XLim = [0 35];
            ax.YLim = [0 2400];
            mean_liver_fat_p(isnan(mean_liver_fat_p)) = [];
            meantxt = 'Mean:';
            mediantxt = 'Median:';
            fivetxt = '5th Percentile:';
            ninefivetxt =  '95th Percentile:';
            meanlivfatp = num2str(round(mean(mean_liver_fat_p),2));
            medianlivfatp = num2str(round(median(mean_liver_fat_p),2));
            fiveplivfatp = num2str(round(prctile(mean_liver_fat_p,5),2));
            ninefiveplivfatp = num2str(round(prctile(mean_liver_fat_p,95),2));
            circstr1 = strcat(meantxt,meanlivfatp);
            circstr2 = strcat(mediantxt,medianlivfatp);
            circstr3 = strcat(fivetxt,fiveplivfatp);
            circstr4 = strcat(ninefivetxt,ninefiveplivfatp);            
            label3 = uilabel('Text',circstr1,'Parent',pan1,...
            'Position',[10 60 180 20]);
            label4 = uilabel('Text',circstr2,'Parent',pan1,...
            'Position',[10 40 180 20]);
            label5 = uilabel('Text',circstr3,'Parent',pan1,...
            'Position',[10 20 180 20]);
            label6 = uilabel('Text',circstr4,'Parent',pan1,...
            'Position',[10 0 180 20]);
            xlabel(ax,'Mean Liver Fat p (%)');
            ylabel(ax,'Frequency');     
            
        case {'Total Fat Index'}            
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            if (ishandle(label3))
            set(label3, 'visible','off');
            end
            if (ishandle(label4))
            set(label4, 'visible','off');
            end
            if (ishandle(label5))
            set(label5, 'visible','off');
            end
            if (ishandle(label6))
            set(label6, 'visible','off');
            end            
            total_fat = Thist.total_fat_index;
            if(strcmp(histmf, 'Overlay'))
                histind = (strcmp(Thist.sex, 'Male'));
                mThist = Thist(histind,:);
                mtotal_fat = mThist.total_fat_index;
                mhisty = histogram(ax,mtotal_fat,'facealpha',0.5,'facecolor','b');
                hold(ax,'on')
                histind = (strcmp(Thist.sex, 'Female'));
                fThist = Thist(histind,:);
                ftotal_fat = fThist.total_fat_index;
                fhisty = histogram(ax,ftotal_fat,'facealpha',0.5,'facecolor','r');
                legend(ax,'Male','Female')
            else
                histy = histogram(ax,total_fat);
            end
            ax.XLim = [0 15];
            ax.YLim = [0 500];
            total_fat(isnan(total_fat)) = [];
            meantxt = 'Mean:';
            mediantxt = 'Median:';
            fivetxt = '5th Percentile:';
            ninefivetxt =  '95th Percentile:';
            meantotfat = num2str(round(mean(total_fat),2));
            mediantotfat = num2str(round(median(total_fat),2));
            fiveptotfat = num2str(round(prctile(total_fat,5),2));
            ninefiveptotfat = num2str(round(prctile(total_fat,95),2));
            circstr1 = strcat(meantxt,meantotfat); 
            circstr2 = strcat(mediantxt,mediantotfat);
            circstr3 = strcat(fivetxt,fiveptotfat);
            circstr4 = strcat(ninefivetxt,ninefiveptotfat);
            label3 = uilabel('Text',circstr1,'Parent',pan1,...
            'Position',[10 60 180 20]);
            label4 = uilabel('Text',circstr2,'Parent',pan1,...
            'Position',[10 40 180 20]);
            label5 = uilabel('Text',circstr3,'Parent',pan1,...
            'Position',[10 20 180 20]);
            label6 = uilabel('Text',circstr4,'Parent',pan1,...
            'Position',[10 0 180 20]);
            xlabel(ax,'Total Fat Index');
            ylabel(ax,'Frequency');    
            
        case {'Age'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            if (ishandle(label3))
            set(label3, 'visible','off');
            end
            if (ishandle(label4))
            set(label4, 'visible','off');
            end
            if (ishandle(label5))
            set(label5, 'visible','off');
            end
            if (ishandle(label6))
            set(label6, 'visible','off');
            end                
            age = Thist.age3;
            if(strcmp(histmf, 'Overlay'))
                histind = (strcmp(Thist.sex, 'Male'));
                mThist = Thist(histind,:);
                mage = mThist.age3;
                mhisty = histogram(ax,mage,'facealpha',0.5,'facecolor','b');
                hold(ax,'on')
                histind = (strcmp(Thist.sex, 'Female'));
                fThist = Thist(histind,:);
                fage = fThist.age3;
                fhisty = histogram(ax,fage,'facealpha',0.5,'facecolor','r');
                legend(ax,'Male','Female')
            else
                histy = histogram(ax,age);
            end
            ax.XLim = [40 80];
            ax.YLim = [0 550];
            age(isnan(age)) = [];
            meantxt = 'Mean:';
            mediantxt = 'Median:';
            fivetxt = '5th Percentile:';
            ninefivetxt =  '95th Percentile:'; 
            meanage = num2str(round(mean(age),2));
            medianage = num2str(round(median(age),2));
            fivepage = num2str(round(prctile(age,5),2));
            ninefivepage = num2str(round(prctile(age,95),2));
            circstr1 = strcat(meantxt,meanage); 
            circstr2 = strcat(mediantxt,medianage);
            circstr3 = strcat(fivetxt,fivepage);
            circstr4 = strcat(ninefivetxt,ninefivepage);
            label3 = uilabel('Text',circstr1,'Parent',pan1,...
            'Position',[10 60 180 20]);
            label4 = uilabel('Text',circstr2,'Parent',pan1,...
            'Position',[10 40 180 20]);
            label5 = uilabel('Text',circstr3,'Parent',pan1,...
            'Position',[10 20 180 20]);
            label6 = uilabel('Text',circstr4,'Parent',pan1,...
            'Position',[10 0 180 20]);
            xlabel(ax,'Age (year)');
            ylabel(ax,'Frequency');    
            
        case {'Weight'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            if (ishandle(label3))
            set(label3, 'visible','off');
            end
            if (ishandle(label4))
            set(label4, 'visible','off');
            end
            if (ishandle(label5))
            set(label5, 'visible','off');
            end
            if (ishandle(label6))
            set(label6, 'visible','off');
            end                
            weight = Thist.weight3;
            if(strcmp(histmf, 'Overlay'))
                histind = (strcmp(Thist.sex, 'Male'));
                mThist = Thist(histind,:);
                mweight = mThist.weight3;
                mhisty = histogram(ax,mweight,'facealpha',0.5,'facecolor','b');
                hold(ax,'on')
                histind = (strcmp(Thist.sex, 'Female'));
                fThist = Thist(histind,:);
                fweight = fThist.weight3;
                fhisty = histogram(ax,fweight,'facealpha',0.5,'facecolor','r');
                legend(ax,'Male','Female')
            else
                histy = histogram(ax,weight);
            end
            ax.XLim = [35 180];
            ax.YLim = [0 500];
            weight(isnan(weight)) = [];
            meantxt = 'Mean:';
            mediantxt = 'Median:';
            fivetxt = '5th Percentile:';
            ninefivetxt =  '95th Percentile:';
            meanweight = num2str(round(mean(weight),2));
            medianweight = num2str(round(median(weight),2));
            fivepweight = num2str(round(prctile(weight,5),2));
            ninefivepweight = num2str(round(prctile(weight,95),2));
            circstr1 = strcat(meantxt,meanweight); 
            circstr2 = strcat(mediantxt,medianweight);
            circstr3 = strcat(fivetxt,fivepweight);
            circstr4 = strcat(ninefivetxt,ninefivepweight);
            label3 = uilabel('Text',circstr1,'Parent',pan1,...
            'Position',[10 60 180 20]);
            label4 = uilabel('Text',circstr2,'Parent',pan1,...
            'Position',[10 40 180 20]);
            label5 = uilabel('Text',circstr3,'Parent',pan1,...
            'Position',[10 20 180 20]);
            label6 = uilabel('Text',circstr4,'Parent',pan1,...
            'Position',[10 0 180 20]);           
            xlabel(ax,'Weight (kg)');
            ylabel(ax,'Frequency');
            
        case {'Height'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            if (ishandle(label3))
            set(label3, 'visible','off');
            end
            if (ishandle(label4))
            set(label4, 'visible','off');
            end
            if (ishandle(label5))
            set(label5, 'visible','off');
            end
            if (ishandle(label6))
            set(label6, 'visible','off');
            end            
            height = Thist.height3;
            if(strcmp(histmf, 'Overlay'))
                histind = (strcmp(Thist.sex, 'Male'));
                mThist = Thist(histind,:);
                mheight = mThist.height3;
                mhisty = histogram(ax,mheight,'facealpha',0.5,'facecolor','b');
                hold(ax,'on')
                histind = (strcmp(Thist.sex, 'Female'));
                fThist = Thist(histind,:);
                fheight = fThist.height3;
                fhisty = histogram(ax,fheight,'facealpha',0.5,'facecolor','r');
                legend(ax,'Male','Female')
            else
                histy = histogram(ax,height);
            end
            ax.XLim = [140 200];
            ax.YLim = [0 500];
            height(isnan(height)) = [];
            meantxt = 'Mean:';
            mediantxt = 'Median:';
            fivetxt = '5th Percentile:';
            ninefivetxt =  '95th Percentile:';             
            meanheight = num2str(round(mean(height),2));
            medianheight = num2str(round(median(height),2));
            fivepheight = num2str(round(prctile(height,5),2));
            ninefivepheight = num2str(round(prctile(height,95),2));
            circstr1 = strcat(meantxt,meanheight); 
            circstr2 = strcat(mediantxt,medianheight);
            circstr3 = strcat(fivetxt,fivepheight);
            circstr4 = strcat(ninefivetxt,ninefivepheight);
            label3 = uilabel('Text',circstr1,'Parent',pan1,...
            'Position',[10 60 180 20]);
            label4 = uilabel('Text',circstr2,'Parent',pan1,...
            'Position',[10 40 180 20]);
            label5 = uilabel('Text',circstr3,'Parent',pan1,...
            'Position',[10 20 180 20]);
            label6 = uilabel('Text',circstr4,'Parent',pan1,...
            'Position',[10 0 180 20]);           
            xlabel(ax,'Height (cm)');
            ylabel(ax,'Frequency');    
            
        case {'BMI'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            if (ishandle(label3))
            set(label3, 'visible','off');
            end
            if (ishandle(label4))
            set(label4, 'visible','off');
            end
            if (ishandle(label5))
            set(label5, 'visible','off');
            end
            if (ishandle(label6))
            set(label6, 'visible','off');
            end            
            bmi = Thist.bmi3;
            if(strcmp(histmf, 'Overlay'))
                histind = (strcmp(Thist.sex, 'Male'));
                mThist = Thist(histind,:);
                mbmi = mThist.bmi3;
                mhisty = histogram(ax,mbmi,'facealpha',0.5,'facecolor','b');
                hold(ax,'on')
                histind = (strcmp(Thist.sex, 'Female'));
                fThist = Thist(histind,:);
                fbmi = fThist.bmi3;
                fhisty = histogram(ax,fbmi,'facealpha',0.5,'facecolor','r');
                legend(ax,'Male','Female')
            else
                histy = histogram(ax,bmi);
            end
            ax.XLim = [10 60]; 
            ax.YLim = [0 650];
            bmi(isnan(bmi)) = [];
            meantxt = 'Mean:';
            mediantxt = 'Median:';
            fivetxt = '5th Percentile:';
            ninefivetxt =  '95th Percentile:';            
            meanbmi = num2str(round(mean(bmi),2));
            medianbmi = num2str(round(median(bmi),2));
            fivepbmi = num2str(round(prctile(bmi,5),2));
            ninefivepbmi = num2str(round(prctile(bmi,95),2));
            circstr1 = strcat(meantxt,meanbmi); 
            circstr2 = strcat(mediantxt,medianbmi);
            circstr3 = strcat(fivetxt,fivepbmi);
            circstr4 = strcat(ninefivetxt,ninefivepbmi);
            label3 = uilabel('Text',circstr1,'Parent',pan1,...
            'Position',[10 60 180 20]);
            label4 = uilabel('Text',circstr2,'Parent',pan1,...
            'Position',[10 40 180 20]);
            label5 = uilabel('Text',circstr3,'Parent',pan1,...
            'Position',[10 20 180 20]);
            label6 = uilabel('Text',circstr4,'Parent',pan1,...
            'Position',[10 0 180 20]);            
            xlabel(ax,'BMI (kg/m^2)');
            ylabel(ax,'Frequency');
            
        case {'Activity Index'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            if (ishandle(label3))
            set(label3, 'visible','off');
            end
            if (ishandle(label4))
            set(label4, 'visible','off');
            end
            if (ishandle(label5))
            set(label5, 'visible','off');
            end
            if (ishandle(label6))
            set(label6, 'visible','off');
            end
            ActivityIndex = Thist.ActivityIndex;
            if(strcmp(histmf, 'Overlay'))
                histind = (strcmp(Thist.sex, 'Male'));
                mThist = Thist(histind,:);
                mActivityIndex = mThist.ActivityIndex;
                mhisty = histogram(ax,mActivityIndex,'facealpha',0.5,'facecolor','b');
                hold(ax,'on')
                histind = (strcmp(Thist.sex, 'Female'));
                fThist = Thist(histind,:);
                fActivityIndex = fThist.ActivityIndex;
                fhisty = histogram(ax,fActivityIndex,'facealpha',0.5,'facecolor','r');
                legend(ax,'Male','Female')
            else
                histy = histogram(ax,ActivityIndex);
            end
            ax.XLim = [-15 15]; 
            ax.YLim = [0 350];
            ActivityIndex(isnan(ActivityIndex)) = [];
            meanActivityIndex = num2str(round(mean(ActivityIndex),2));
            medianActivityIndex = num2str(round(median(ActivityIndex),2));
            fivepActivityIndex = num2str(round(prctile(ActivityIndex,5),2));
            ninefivepActivityIndex = num2str(round(prctile(ActivityIndex,95),2));
            meantxt = 'Mean:';
            mediantxt = 'Median:';
            fivetxt = '5th Percentile:';
            ninefivetxt =  '95th Percentile:';
            circstr1 = strcat(meantxt,meanActivityIndex);
            circstr2 = strcat(mediantxt,medianActivityIndex);
            circstr3 = strcat(fivetxt,fivepActivityIndex);
            circstr4 = strcat(ninefivetxt,ninefivepActivityIndex);
            label3 = uilabel('Text',circstr1,'Parent',pan1,...
            'Position',[10 60 180 20]);
            label4 = uilabel('Text',circstr2,'Parent',pan1,...
            'Position',[10 40 180 20]);
            label5 = uilabel('Text',circstr3,'Parent',pan1,...
            'Position',[10 20 180 20]);
            label6 = uilabel('Text',circstr4,'Parent',pan1,...
            'Position',[10 0 180 20]);
            xlabel(ax,'Activity Index');
            ylabel(ax,'Frequency');
            
        case {'Sex'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            if (ishandle(label3))
            set(label3, 'visible','off');
            end
            if (ishandle(label4))
            set(label4, 'visible','off');
            end
            if (ishandle(label5))
            set(label5, 'visible','off');
            end
            if (ishandle(label6))
            set(label6, 'visible','off');
            end                
            sex = Thist.sex;
            if(strcmp(histmf, 'Overlay'))
                histind = (strcmp(Thist.sex, 'Male'));
                mThist = Thist(histind,:);
                msex = mThist.sex;
                c1 = categorical(msex);
                mhisty = histogram(ax,c1,'facealpha',0.5,'facecolor','b');
                hold(ax,'on')
                histind = (strcmp(Thist.sex, 'Female'));
                fThist = Thist(histind,:);
                fsex = fThist.sex;
                c2 = categorical(fsex);
                fhisty = histogram(ax,c2,'facealpha',0.5,'facecolor','r');
                legend(ax,'Male','Female')
            else
                c1 = categorical(sex);
                histy = histogram(ax,c1);
            end
            xlabel(ax,'Sex');
            ylabel(ax,'Frequency');
            
        case {'Race'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            if (ishandle(label3))
            set(label3, 'visible','off');
            end
            if (ishandle(label4))
            set(label4, 'visible','off');
            end
            if (ishandle(label5))
            set(label5, 'visible','off');
            end
            if (ishandle(label6))
            set(label6, 'visible','off');
            end                
            race = Thist.race3;
            if(strcmp(histmf, 'Overlay'))
                histind = (strcmp(Thist.sex, 'Male'));
                mThist = Thist(histind,:);
                mrace = mThist.race3;
                c1 = categorical(mrace);
                mhisty = histogram(ax,c1,'facealpha',0.5,'facecolor','b');
                hold(ax,'on')
                histind = (strcmp(Thist.sex, 'Female'));
                fThist = Thist(histind,:);
                frace = fThist.race3;
                c2 = categorical(frace);
                fhisty = histogram(ax,c2,'facealpha',0.5,'facecolor','r');
                legend(ax,'Male','Female')
            else
                c2 = categorical(race);
                histy = histogram(ax,c2);
            end
            xlabel(ax,'Race');
            ylabel(ax,'Frequency');
            
        case {'Diabetes'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            if (ishandle(label3))
            set(label3, 'visible','off');
            end
            if (ishandle(label4))
            set(label4, 'visible','off');
            end
            if (ishandle(label5))
            set(label5, 'visible','off');
            end
            if (ishandle(label6))
            set(label6, 'visible','off');
            end                
            diabetes = Thist.diabetes3;
            if(strcmp(histmf, 'Overlay'))
                histind = (strcmp(Thist.sex, 'Male'));
                mThist = Thist(histind,:);
                mdiabetes = mThist.diabetes3;
                c1 = categorical(mdiabetes);
                mhisty = histogram(ax,c1,'facealpha',0.5,'facecolor','b');
                hold(ax,'on')
                histind = (strcmp(Thist.sex, 'Female'));
                fThist = Thist(histind,:);
                fdiabetes = fThist.diabetes3;
                c2 = categorical(fdiabetes);
                fhisty = histogram(ax,c2,'facealpha',0.5,'facecolor','r');
                legend(ax,'Male','Female')
            else
                c3 = categorical(diabetes);
                histy = histogram(ax,c3);
            end
            xlabel(ax,'Diabetes');
            ylabel(ax,'Frequency');
    end
    Thist = T;
end

% Create ValueChangedFcn callback for Scatter Plot:
function selection2(ddmenu2, eventdata, handles)
    choice2 = get(ddmenu2,'Value');

    switch scathealth
        case {'Healthy'}
            histind = (nmTscat.healthy_icd_and_self_reported_fi == 1);
            nmTscat = nmTscat(histind,:);
            histind = (nfTscat.healthy_icd_and_self_reported_fi == 1);
            nfTscat = nfTscat(histind,:);
        case {'Unhealthy'}
            histind = (nmTscat.healthy_icd_and_self_reported_fi == 0);
            nmTscat = nmTscat(histind,:);
            histind = (nfTscat.healthy_icd_and_self_reported_fi == 0);
            nfTscat = nfTscat(histind,:);
        case {'All'}
    end
    
    switch scatage
        case {'<69'}
            histind = (nmTscat.age3 < 69);
            nmTscat = nmTscat(histind,:);
            histind = (nfTscat.age3 < 69);
            nfTscat = nfTscat(histind,:);
        case {'>=69'}
            histind = (nmTscat.age3 >= 69);
            nmTscat = nmTscat(histind,:);
            histind = (nfTscat.age3 >= 69);
            nfTscat = nfTscat(histind,:);
        case {'All'}
    end
    
    switch scatmf
        case {'Male'}
            histind = (strcmp(nmTscat.sex, 'Male'));
            nmTscat = nmTscat(histind,:);
            histind = (strcmp(nfTscat.sex, 'Male'));
            nfTscat = nfTscat(histind,:);
        case {'Female'}
            histind = (strcmp(nmTscat.sex, 'Female'));
            nmTscat = nmTscat(histind,:);
            histind = (strcmp(nfTscat.sex, 'Female'));
            nfTscat = nfTscat(histind,:);
        case {'All'}
    end
    
    % Switching between different variables for Scatter Plot    
    switch choice2
        case {'Select X Variable:'}
        case {'Waist Circumference'}
            m_scatter_x = nmTscat.waist_cir3;
            f_scatter_x = nfTscat.waist_cir3;
            xaxis_label = 'Waist Circumference (cm)';
        case {'Mean Liver Fat p'}
            m_scatter_x = nmTscat.mean_liver_fat_p;
            f_scatter_x = nfTscat.mean_liver_fat_p;
            xaxis_label = 'Mean Liver Fat p (%)';
        case {'Total Fat Index'}
            m_scatter_x = nmTscat.total_fat_index;
            f_scatter_x = nfTscat.total_fat_index;
            xaxis_label = 'Total Fat Index';
        case {'Age'}
            m_scatter_x = nmTscat.age3;
            f_scatter_x = nfTscat.age3;
            xaxis_label = 'Age (year)';
        case {'Weight'}
            m_scatter_x = nmTscat.weight3;
            f_scatter_x = nfTscat.weight3; 
            xaxis_label = 'Weight (kg)';
        case {'Height'}
            m_scatter_x = nmTscat.height3;
            f_scatter_x = nfTscat.height3;
            xaxis_label = 'Height (cm)';
        case {'BMI'}
            m_scatter_x = nmTscat.bmi3;
            f_scatter_x = nfTscat.bmi3;
            xaxis_label = 'BMI (kg/m^2)';
        case{'Activity Index'}
            m_scatter_x = nmTscat.ActivityIndex;
            f_scatter_x = nfTscat.ActivityIndex;
            xaxis_label = 'Activity Index'; 
    end
    nmTscat = mTscat;
    nfTscat = fTscat;
end


% Create ValueChangedFcn callback for Scatter Plot:
function selection3(ddmenu3, eventdata, handles)
    choice3 = get(ddmenu3,'Value');

    switch scathealth
        case {'Healthy'}
            histind = (nmTscat.healthy_icd_and_self_reported_fi == 1);
            nmTscat = nmTscat(histind,:);
            histind = (nfTscat.healthy_icd_and_self_reported_fi == 1);
            nfTscat = nfTscat(histind,:);
        case {'Unhealthy'}
            histind = (nmTscat.healthy_icd_and_self_reported_fi == 0);
            nmTscat = nmTscat(histind,:);
            histind = (nfTscat.healthy_icd_and_self_reported_fi == 0);
            nfTscat = nfTscat(histind,:);
        case {'All'}
    end
    
    switch scatage
        case {'<69'}
            histind = (nmTscat.age3 < 69);
            nmTscat = nmTscat(histind,:);
            histind = (nfTscat.age3 < 69);
            nfTscat = nfTscat(histind,:);
        case {'>=69'}
            histind = (nmTscat.age3 >= 69);
            nmTscat = nmTscat(histind,:);
            histind = (nfTscat.age3 >= 69);
            nfTscat = nfTscat(histind,:);
        case {'All'}
    end
    
    switch scatmf
        case {'Male'}
            histind = (strcmp(nmTscat.sex, 'Male'));
            nmTscat = nmTscat(histind,:);
            histind = (strcmp(nfTscat.sex, 'Male'));
            nfTscat = nfTscat(histind,:);
        case {'Female'}
            histind = (strcmp(nmTscat.sex, 'Female'));
            nmTscat = nmTscat(histind,:);
            histind = (strcmp(nfTscat.sex, 'Female'));
            nfTscat = nfTscat(histind,:);
        case {'All'}
    end

    % Switching between different variables for Scatter Plot     
    switch choice3
        case {'Select Y Variable:'}
        case {'Waist Circumference'}
            m_scatter_y = nmTscat.waist_cir3;
            f_scatter_y = nfTscat.waist_cir3;
            yaxis_label = 'Waist Circumference (cm)';
        case {'Mean Liver Fat p'}
            m_scatter_y = nmTscat.mean_liver_fat_p;
            f_scatter_y = nfTscat.mean_liver_fat_p;
            yaxis_label = 'Mean Liver Fat p (%)';
        case {'Total Fat Index'}
            m_scatter_y = nmTscat.total_fat_index;
            f_scatter_y = nfTscat.total_fat_index;
            yaxis_label = 'Total Fat Index';
        case {'Age'}
            m_scatter_y = nmTscat.age3;
            f_scatter_y = nfTscat.age3;
            yaxis_label = 'Age (year)';
        case {'Weight'}
            m_scatter_y = nmTscat.weight3;
            f_scatter_y = nfTscat.weight3;
            yaxis_label = 'Weight (kg)';
        case {'Height'}
            m_scatter_y = nmTscat.height3;
            f_scatter_y = nfTscat.height3;
            yaxis_label = 'Height (cm)';
        case {'BMI'}
            m_scatter_y = nmTscat.bmi3;
            f_scatter_y = nfTscat.bmi3;
            yaxis_label = 'BMI (kg/m^2)';
         case{'Activity Index'}
            m_scatter_y = nmTscat.ActivityIndex;
            f_scatter_y = nfTscat.ActivityIndex;
            yaxis_label = 'Activity Index'; 
    end
    nmTscat = mTscat;
    nfTscat = fTscat;

end

% Create the function for the Help menu callback
function OpenHelpMenu(b4)
    helpfig = uifigure('visible','off','name','Help Menu', 'Position',[100 100 500 250]);
    pan5 = uilabel('Parent', helpfig,'text','is mayonnaise an instrument?? but really help instructions will go here later','FontWeight','bold',...
             'Position',[30 100 450 50],'visible','off');
    set(helpfig, 'visible', 'on')
    set(pan5, 'visible', 'on')
end
    
% Create the function for the ButtonPushedFcn callback (Scatter Plot):
function plotButtonPushed(b3,ax2)
    if(~strcmp(choice2, 'Select X Variable:') && ~strcmp(choice3, 'Select Y Variable:'))
        if(~strcmp(choice2, 'Select X Variable:'))
            selection2(ddmenu2);
        end
        
        if(~strcmp(choice3, 'Select Y Variable:'))
            selection3(ddmenu3);
        end
        
        ax2.NextPlot = 'replace';
        cla(ax2);    
        set(ax2,'visible','on');
        if (ishandle(label1))
        set(label1, 'visible','off');
        end
        if (ishandle(label2))
        set(label2, 'visible','off');
        end
        
        m_xy = [m_scatter_x'; m_scatter_y'];
        m_xy1 = m_xy(:, ~any(isnan(m_xy)));
        m_x = m_xy1(1,:);
        m_y = m_xy1(2,:);
        
        if(~strcmp(scatvar1label, 'All'))
            f_xy = [f_scatter_x'; f_scatter_y'];
            f_xy1 = f_xy(:, ~any(isnan(f_xy)));
            f_x = f_xy1(1,:);
            f_y = f_xy1(2,:);
        end
        corval = ' Correlation Value: ';
        cortxt1 = strcat(scatvar1label,corval);
        cortxt2 = strcat(scatvar2label,corval);
        m_r = num2str(corr2(m_x, m_y));
        m_r_str = strcat(cortxt1,' ', m_r);
        
        if(~strcmp(scatvar1label, 'All'))
            f_r = num2str(corr2(f_x, f_y));
            f_r_str = strcat(cortxt2, ' ', f_r);
        end
        label1 = uilabel('Text',m_r_str,'Parent',pan2,...
            'Position',[10 20 210 20]);
        
        if(~strcmp(scatvar1label, 'All'))
            label2 = uilabel('Text',f_r_str,'Parent',pan2,...
                'Position',[10 0 210 20]);
        end
        scatter(ax2,m_scatter_x, m_scatter_y,'b');
        hold(ax2,'on')
        if(~strcmp(scatvar1label, 'All'))
            scatter(ax2,f_scatter_x, f_scatter_y,'r');
        end
        xlabel(ax2,xaxis_label);
        ylabel(ax2,yaxis_label);
        if(~strcmp(scatvar1label, 'All'))
            legend(ax2, scatvar1label,scatvar2label);
        else
            legend(ax2, scatvar1label);
        end
    end
    m_scatter_x = 0;
    m_scatter_y = 0;
    f_scatter_x = 0;
    f_scatter_y = 0;
    mTscat = T;
    fTscat = T;
    nmTscat = mTscat;
    nfTscat = fTscat;
end

% Reset toggle switch variables
function bg1fn(source,event)
    histmf = event.NewValue.Text;
    selection(ddmenu);
end

function bg2fn(source,event)
    histhealth = event.NewValue.Text;
    selection(ddmenu);
end

function bg3fn(source,event)
    histage = event.NewValue.Text;
    selection(ddmenu);
end

function bg4fn(source,event)
    scatradio = bg7.SelectedObject.Text;
    if(strcmp(scatradio, 'Gender'))
         male_ind = (strcmp(mTscat.sex, 'Male'));
         mTscat = mTscat(male_ind,:);
         female_ind = (strcmp(fTscat.sex, 'Female'));
         fTscat = fTscat(female_ind,:);
     elseif(strcmp(scatradio, 'Healthiness'))
         male_ind = (mTscat.healthy_icd_and_self_reported_fi == 1);
         mTscat = mTscat(male_ind,:);
         female_ind = (fTscat.healthy_icd_and_self_reported_fi == 0);
         fTscat = fTscat(female_ind,:);
     elseif(strcmp(scatradio, 'Age'))
         male_ind = (mTscat.age3 < 69);
         mTscat = mTscat(male_ind,:);
         female_ind = (fTscat.age3 >= 69);
         fTscat = fTscat(female_ind,:);
     end
    
    scatmf = event.NewValue.Text;
    if(~strcmp(choice2, 'Select X Variable:') && ~strcmp(choice3, 'Select Y Variable:'))
        selection2(ddmenu2);
        selection3(ddmenu3);
        plotButtonPushed(b3,ax2);
        
    end

end

function bg5fn(source,event)
    scatradio = bg7.SelectedObject.Text;
    if(strcmp(scatradio, 'Gender'))
         male_ind = (strcmp(mTscat.sex, 'Male'));
         mTscat = mTscat(male_ind,:);
         female_ind = (strcmp(fTscat.sex, 'Female'));
         fTscat = fTscat(female_ind,:);
     elseif(strcmp(scatradio, 'Healthiness'))
         male_ind = (mTscat.healthy_icd_and_self_reported_fi == 1);
         mTscat = mTscat(male_ind,:);
         female_ind = (fTscat.healthy_icd_and_self_reported_fi == 0);
         fTscat = fTscat(female_ind,:);
     elseif(strcmp(scatradio, 'Age'))
         male_ind = (mTscat.age3 < 69);
         mTscat = mTscat(male_ind,:);
         female_ind = (fTscat.age3 >= 69);
         fTscat = fTscat(female_ind,:);
     end
    
    scathealth = event.NewValue.Text;
    if(~strcmp(choice2, 'Select X Variable:') && ~strcmp(choice3, 'Select Y Variable:'))
        selection2(ddmenu2);
        selection3(ddmenu3);
        plotButtonPushed(b3,ax2);
        
    end

end

function bg6fn(source,event)
    scatradio = bg7.SelectedObject.Text;
    if(strcmp(scatradio, 'Gender'))
         male_ind = (strcmp(mTscat.sex, 'Male'));
         mTscat = mTscat(male_ind,:);
         female_ind = (strcmp(fTscat.sex, 'Female'));
         fTscat = fTscat(female_ind,:);
     elseif(strcmp(scatradio, 'Healthiness'))
         male_ind = (mTscat.healthy_icd_and_self_reported_fi == 1);
         mTscat = mTscat(male_ind,:);
         female_ind = (fTscat.healthy_icd_and_self_reported_fi == 0);
         fTscat = fTscat(female_ind,:);
     elseif(strcmp(scatradio, 'Age'))
         male_ind = (mTscat.age3 < 69);
         mTscat = mTscat(male_ind,:);
         female_ind = (fTscat.age3 >= 69);
         fTscat = fTscat(female_ind,:);
     end
    
    scatage = event.NewValue.Text;
    if(~strcmp(choice2, 'Select X Variable:') && ~strcmp(choice3, 'Select Y Variable:'))
        selection2(ddmenu2);
        selection3(ddmenu3);
        plotButtonPushed(b3,ax2);
        
    end

end

function bg7fn(source,event)
     scatradio = event.NewValue.Text;
     if(strcmp(scatradio, 'Gender'))
         male_ind = (strcmp(mTscat.sex, 'Male'));
         mTscat = mTscat(male_ind,:);
         female_ind = (strcmp(fTscat.sex, 'Female'));
         fTscat = fTscat(female_ind,:);
         scatvar1label = 'Male';
         scatvar2label = 'Female';
     elseif(strcmp(scatradio, 'Healthiness'))
         male_ind = (mTscat.healthy_icd_and_self_reported_fi == 1);
         mTscat = mTscat(male_ind,:);
         female_ind = (fTscat.healthy_icd_and_self_reported_fi == 0);
         fTscat = fTscat(female_ind,:);
         scatvar1label = 'Healthy';
         scatvar2label = 'Unhealthy';
     elseif(strcmp(scatradio, 'Age'))
         male_ind = (mTscat.age3 < 69);
         mTscat = mTscat(male_ind,:);
         female_ind = (fTscat.age3 >= 69);
         fTscat = fTscat(female_ind,:);
         scatvar1label = 'Age <69';
         scatvar2label = 'Age >=69';
     elseif(strcmp(scatradio, 'All'))
         scatvar1label = 'All';
         scatvar2label = 'All';
     end
     scatmf = bg4.SelectedObject.Text;
     scathealth = bg5.SelectedObject.Text;
     scatage = bg6.SelectedObject.Text;
     if(~strcmp(choice2, 'Select X Variable:') && ~strcmp(choice3, 'Select Y Variable:'))
        selection2(ddmenu2);
        selection3(ddmenu3);
        plotButtonPushed(b3,ax2); 
     end

end
end
