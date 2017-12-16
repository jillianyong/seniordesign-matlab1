%% Copyright 2017
% Rita Chen richen@bu.edu
% Max Christ mmchrist@bu.edu
% Jillian Yong jeyong@bu.edu
% All Rights Reserved

%%
function HW2_HealthyGender
global T;
global male_ind;
global female_ind;
global T2;
global T1;


x = detectImportOptions('BCP_Activity6021.xlsx');
T = readtable('BCP_Activity6021.xlsx',x);
healthy_ind = (T.healthy_icd_and_self_reported_fi == 1);
T = T(healthy_ind,:);
male_ind = (strcmp(T.sex, 'Male'));
T1 = T(male_ind,:); 
female_ind = (strcmp(T.sex, 'Female'));
T2 = T(female_ind,:); 


%Create GUI background
f1 = figure('Name','HW2','NumberTitle','off');
 global uif;
 global ddmenu;
 global ddmenu1;
 global b1;
 global b2;
 global txt;
 global ax;
 global histy;
 global texty;


% Buttons
b1 = uicontrol( 'Parent',f1,'visible', ...
    'off', 'Style','Pushbutton','Units','normalized',...
    'Position',[.2 .5 .2 .1], 'BackgroundColor',[.8 .6 .9],...
    'String','Male','FontSize', 18,'Callback',@hist1);
b2 = uicontrol('Parent',f1,'visible', ...
    'off','Style','Pushbutton','Units','normalized',...
    'Position',[.6 .5 .2 .1], 'BackgroundColor',[.6 .4 .7],...
    'String','Female','FontSize', 18, 'Callback',@hist2);

% Add a text uicontrol for user instructions
txt = uicontrol('Parent',f1,'visible', ...
    'off','Style','text',...
      'Units','normalized',...
      'Position',[.08 .7 .9 .08],...
      'FontSize', 18,...
      'String','Please select a button to display different figures.');

% Creating a dropdown menu
 set([ b1, b2 txt], 'visible','on');
 
 
uif = uifigure('visible','off','name','HW2');
ax = uiaxes('Parent',uif,'Position',[10 10 400 400],'visible','off');


% Creating a dropdown menu
ddmenu = uidropdown(uif,...
    'Position',[410 210 140 22],...
    'Items',{'Waist Circumference', 'Mean Liver Fat p', 'Total Fat Index',...
    'Age', 'Weight', 'Height', 'BMI', 'Sex', 'Race', 'Diabetes'},...
    'Value','BMI',...
    'ValueChangedFcn',@(ddmenu,event) selection(ddmenu),'visible', 'off');

ddmenu1 = uidropdown(uif,...
    'Position',[410 210 140 22],...
    'Items',{'Waist Circumference', 'Mean Liver Fat p', 'Total Fat Index',...
    'Age', 'Weight', 'Height', 'BMI', 'Sex', 'Race', 'Diabetes'},...
    'Value','BMI',...
    'ValueChangedFcn',@(ddmenu1,event) selection1(ddmenu1),'visible', 'off');

function hist1(hObject,eventdata)
    set([f1,b1,b2,txt],'visible','off');
    set([uif,ddmenu],'visible','on');
end

% Create ValueChangedFcn callback:
function selection(ddmenu, eventdata, handles)
    choice = get(ddmenu,'Value');
    switch choice
        case {'Waist Circumference'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            waist_cir = T1.waist_cir3;
            histy = histogram(ax,waist_cir);
            waist_cir(isnan(waist_cir)) = [];
            meanwaistcir = mean(waist_cir);
            medianwaistcir = median(waist_cir);
            fivepwaistcir = prctile(waist_cir,5);
            ninefivepwaistcir = prctile(waist_cir,95);
            circstr1 = sprintf("Mean: %.2f",meanwaistcir); 
            circstr2 = sprintf("Median: %.2f",medianwaistcir);
            circstr3 = sprintf("5th Percentile: %.2f",fivepwaistcir);
            circstr4 = sprintf("95th Percentile: %.2f",ninefivepwaistcir);
            circstr = {circstr1,circstr2,circstr3,circstr4};
            texty = text(ax,110,70,circstr);
            xlabel(ax,'Waist Circumference (cm)');
            ylabel(ax,'Frequency');
        case {'Mean Liver Fat p'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            mean_liver_fat_p = T1.mean_liver_fat_p;
            histy = histogram(ax,mean_liver_fat_p);
            mean_liver_fat_p(isnan(mean_liver_fat_p)) = [];
            meanlivfatp = mean(mean_liver_fat_p);
            medianlivfatp = median(mean_liver_fat_p);
            fiveplivfatp = prctile(mean_liver_fat_p,5);
            ninefiveplivfatp = prctile(mean_liver_fat_p,95);
            circstr1 = sprintf("Mean: %.2f",meanlivfatp); 
            circstr2 = sprintf("Median: %.2f",medianlivfatp);
            circstr3 = sprintf("5th Percentile: %.2f",fiveplivfatp);
            circstr4 = sprintf("95th Percentile: %.2f",ninefiveplivfatp);
            circstr = {circstr1,circstr2,circstr3,circstr4};
            texty = text(ax,20,140,circstr);
            xlabel(ax,'Mean Liver Fat p (%)');
            ylabel(ax,'Frequency');
        case {'Total Fat Index'}            
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            total_fat = T1.total_fat_index;
            histy = histogram(ax,total_fat);
            total_fat(isnan(total_fat)) = [];
            meantotfat = mean(total_fat);
            mediantotfat = median(total_fat);
            fiveptotfat = prctile(total_fat,5);
            ninefiveptotfat = prctile(total_fat,95);
            circstr1 = sprintf("Mean: %.2f",meantotfat); 
            circstr2 = sprintf("Median: %.2f",mediantotfat);
            circstr3 = sprintf("5th Percentile: %.2f",fiveptotfat);
            circstr4 = sprintf("95th Percentile: %.2f",ninefiveptotfat);
            circstr = {circstr1,circstr2,circstr3,circstr4};
            texty = text(ax,6,70,circstr);
            xlabel(ax,'Total Fat Index');
            ylabel(ax,'Frequency');
        case {'Age'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            age = T1.age3;
            histy = histogram(ax,age);
            age(isnan(age)) = [];
            meanage = mean(age);
            medianage = median(age);
            fivepage = prctile(age,5);
            ninefivepage = prctile(age,95);
            circstr1 = sprintf("Mean: %.2f",meanage); 
            circstr2 = sprintf("Median: %.2f",medianage);
            circstr3 = sprintf("5th Percentile: %.2f",fivepage);
            circstr4 = sprintf("95th Percentile: %.2f",ninefivepage);
            circstr = {circstr1,circstr2,circstr3,circstr4};
            texty = text(ax,68,62,circstr);
            xlabel(ax,'Age (year)');
            ylabel(ax,'Frequency');
        case {'Weight'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            weight = T1.weight3;
            histy = histogram(ax,weight);
            weight(isnan(weight)) = [];
            meanweight = mean(weight);
            medianweight = median(weight);
            fivepweight = prctile(weight,5);
            ninefivepweight = prctile(weight,95);
            circstr1 = sprintf("Mean: %.2f",meanweight); 
            circstr2 = sprintf("Median: %.2f",medianweight);
            circstr3 = sprintf("5th Percentile: %.2f",fivepweight);
            circstr4 = sprintf("95th Percentile: %.2f",ninefivepweight);
            circstr = {circstr1,circstr2,circstr3,circstr4};
            texty = text(ax,100,60,circstr); 
            xlabel(ax,'Weight (kg)');
            ylabel(ax,'Frequency');
        case {'Height'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            height = T1.height3;
            histy = histogram(ax,height);
            height(isnan(height)) = [];
            meanheight = mean(height);
            medianheight = median(height);
            fivepheight = prctile(height,5);
            ninefivepheight = prctile(height,95);
            circstr1 = sprintf("Mean: %.2f",meanheight); 
            circstr2 = sprintf("Median: %.2f",medianheight);
            circstr3 = sprintf("5th Percentile: %.2f",fivepheight);
            circstr4 = sprintf("95th Percentile: %.2f",ninefivepheight);
            circstr = {circstr1,circstr2,circstr3,circstr4};
            texty = text(ax,153,70,circstr);
            xlabel(ax,'Height (cm)');
            ylabel(ax,'Frequency');
        case {'BMI'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            bmi = T1.bmi3;
            histy = histogram(ax,bmi);
            bmi(isnan(bmi)) = [];
            meanbmi = mean(bmi);
            medianbmi = median(bmi);
            fivepbmi = prctile(bmi,5);
            ninefivepbmi = prctile(bmi,95);
            circstr1 = sprintf("Mean: %.2f",meanbmi); 
            circstr2 = sprintf("Median: %.2f",medianbmi);
            circstr3 = sprintf("5th Percentile: %.2f",fivepbmi);
            circstr4 = sprintf("95th Percentile: %.2f",ninefivepbmi);
            circstr = {circstr1,circstr2,circstr3,circstr4};
            texty = text(ax,33,80,circstr);
            xlabel(ax,'BMI (kg/m^2)');
            ylabel(ax,'Frequency');
        case {'Sex'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            sex = T1.sex;
            c1 = categorical(sex);
            histy = histogram(ax,c1);
            xlabel(ax,'Sex');
            ylabel(ax,'Frequency');
        case {'Race'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            race = T1.race3;
            c2 = categorical(race);
            histy = histogram(ax,c2);
            xlabel(ax,'Race');
            ylabel(ax,'Frequency');
        case {'Diabetes'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            diabetes = T1.diabetes3;
            c3 = categorical(diabetes);
            histy = histogram(ax,c3);
            xlabel(ax,'Diabetes');
            ylabel(ax,'Frequency');
    end
end


function hist2(hObject,eventdata)
    set([f1,b1,b2,txt],'visible','off');
    set([uif,ddmenu1],'visible','on');
end

% Create ValueChangedFcn callback:
function selection1(ddmenu1, eventdata, handles)
    choice = get(ddmenu1,'Value');
    switch choice
        case {'Waist Circumference'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            waist_cir = T2.waist_cir3;
            histy = histogram(ax,waist_cir);
            waist_cir(isnan(waist_cir)) = [];
            meanwaistcir = mean(waist_cir);
            medianwaistcir = median(waist_cir);
            fivepwaistcir = prctile(waist_cir,5);
            ninefivepwaistcir = prctile(waist_cir,95);
            circstr1 = sprintf("Mean: %.2f",meanwaistcir); 
            circstr2 = sprintf("Median: %.2f",medianwaistcir);
            circstr3 = sprintf("5th Percentile: %.2f",fivepwaistcir);
            circstr4 = sprintf("95th Percentile: %.2f",ninefivepwaistcir);
            circstr = {circstr1,circstr2,circstr3,circstr4};
            texty = text(ax,90,80,circstr);
            xlabel(ax,'Waist Circumference (cm)');
            ylabel(ax,'Frequency');
        case {'Mean Liver Fat p'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            mean_liver_fat_p = T2.mean_liver_fat_p;
            histy = histogram(ax,mean_liver_fat_p);
            mean_liver_fat_p(isnan(mean_liver_fat_p)) = [];
            meanlivfatp = mean(mean_liver_fat_p);
            medianlivfatp = median(mean_liver_fat_p);
            fiveplivfatp = prctile(mean_liver_fat_p,5);
            ninefiveplivfatp = prctile(mean_liver_fat_p,95);
            circstr1 = sprintf("Mean: %.2f",meanlivfatp); 
            circstr2 = sprintf("Median: %.2f",medianlivfatp);
            circstr3 = sprintf("5th Percentile: %.2f",fiveplivfatp);
            circstr4 = sprintf("95th Percentile: %.2f",ninefiveplivfatp);
            circstr = {circstr1,circstr2,circstr3,circstr4};
            texty = text(ax,10,150,circstr);
            xlabel(ax,'Mean Liver Fat p (%)');
            ylabel(ax,'Frequency');
        case {'Total Fat Index'}            
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            total_fat = T2.total_fat_index;
            histy = histogram(ax,total_fat);
            total_fat(isnan(total_fat)) = [];
            meantotfat = mean(total_fat);
            mediantotfat = median(total_fat);
            fiveptotfat = prctile(total_fat,5);
            ninefiveptotfat = prctile(total_fat,95);
            circstr1 = sprintf("Mean: %.2f",meantotfat); 
            circstr2 = sprintf("Median: %.2f",mediantotfat);
            circstr3 = sprintf("5th Percentile: %.2f",fiveptotfat);
            circstr4 = sprintf("95th Percentile: %.2f",ninefiveptotfat);
            circstr = {circstr1,circstr2,circstr3,circstr4};
            texty = text(ax,6,50,circstr);
            xlabel(ax,'Total Fat Index');
            ylabel(ax,'Frequency');
        case {'Age'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            age = T2.age3;
            histy = histogram(ax,age);
            age(isnan(age)) = [];
            meanage = mean(age);
            medianage = median(age);
            fivepage = prctile(age,5);
            ninefivepage = prctile(age,95);
            circstr1 = sprintf("Mean: %.2f",meanage); 
            circstr2 = sprintf("Median: %.2f",medianage);
            circstr3 = sprintf("5th Percentile: %.2f",fivepage);
            circstr4 = sprintf("95th Percentile: %.2f",ninefivepage);
            circstr = {circstr1,circstr2,circstr3,circstr4};
            texty = text(ax,67,60,circstr); 
            xlabel(ax,'Age (year)');
            ylabel(ax,'Frequency');
        case {'Weight'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            weight = T2.weight3;
            histy = histogram(ax,weight);
            weight(isnan(weight)) = [];
            meanweight = mean(weight);
            medianweight = median(weight);
            fivepweight = prctile(weight,5);
            ninefivepweight = prctile(weight,95);
            circstr1 = sprintf("Mean: %.2f",meanweight); 
            circstr2 = sprintf("Median: %.2f",medianweight);
            circstr3 = sprintf("5th Percentile: %.2f",fivepweight);
            circstr4 = sprintf("95th Percentile: %.2f",ninefivepweight);
            circstr = {circstr1,circstr2,circstr3,circstr4};
            texty = text(ax,80,60,circstr); 
            xlabel(ax,'Weight (kg)');
            ylabel(ax,'Frequency');
        case {'Height'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            height = T2.height3;
            histy = histogram(ax,height);
            height(isnan(height)) = [];
            meanheight = mean(height);
            medianheight = median(height);
            fivepheight = prctile(height,5);
            ninefivepheight = prctile(height,95);
            circstr1 = sprintf("Mean: %.2f",meanheight); 
            circstr2 = sprintf("Median: %.2f",medianheight);
            circstr3 = sprintf("5th Percentile: %.2f",fivepheight);
            circstr4 = sprintf("95th Percentile: %.2f",ninefivepheight);
            circstr = {circstr1,circstr2,circstr3,circstr4};
            texty = text(ax,140,70,circstr);
            xlabel(ax,'Height (cm)');
            ylabel(ax,'Frequency');
        case {'BMI'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            bmi = T2.bmi3;
            histy = histogram(ax,bmi);
            bmi(isnan(bmi)) = [];
            meanbmi = mean(bmi);
            medianbmi = median(bmi);
            fivepbmi = prctile(bmi,5);
            ninefivepbmi = prctile(bmi,95);
            circstr1 = sprintf("Mean: %.2f",meanbmi); 
            circstr2 = sprintf("Median: %.2f",medianbmi);
            circstr3 = sprintf("5th Percentile: %.2f",fivepbmi);
            circstr4 = sprintf("95th Percentile: %.2f",ninefivepbmi);
            circstr = {circstr1,circstr2,circstr3,circstr4};
            texty = text(ax,33,80,circstr);
            xlabel(ax,'BMI (kg/m^2)');
            ylabel(ax,'Frequency');
        case {'Sex'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            sex = T2.sex;
            c1 = categorical(sex);
            histy = histogram(ax,c1);
            xlabel(ax,'Sex');
            ylabel(ax,'Frequency');
        case {'Race'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            race = T2.race3;
            c2 = categorical(race);
            histy = histogram(ax,c2);
            xlabel(ax,'Race');
            ylabel(ax,'Frequency');
        case {'Diabetes'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            diabetes = T2.diabetes3;
            c3 = categorical(diabetes);
            histy = histogram(ax,c3);
            xlabel(ax,'Diabetes');
            ylabel(ax,'Frequency');
    end
end


end
