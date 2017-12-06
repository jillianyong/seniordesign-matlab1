function HW2_HealthyGenderAge
global T;
global male_ind;
global female_ind;
global T2;
global T1;
global T3;
global T4;
global T6;
global T5;

x = detectImportOptions('BCP_Activity6021.xlsx');
T = readtable('BCP_Activity6021.xlsx',x);
healthy_ind = (T.healthy_icd_and_self_reported_fi == 1);
T = T(healthy_ind,:);
male_ind = (strcmp(T.sex, 'Male'));
T1 = T(male_ind,:); 
male_over69 = (T1.age3 >= 69);
male_under69 = (T1.age3 <69);
T3 = T1(male_over69,:);
T4 = T1(male_under69,:);
female_ind = (strcmp(T.sex, 'Female'));
T2 = T(female_ind,:); 
female_over69 = (T2.age3 >= 69);
female_under69 = (T2.age3 <69);
T5 = T2(female_over69,:);
T6 = T2(female_under69,:);


%Create GUI background
f1 = figure('Name','HW2','NumberTitle','off');
 global uif;
 global ddmenu; 
 global ddmenu1;
 global ddmenu2;
 global ddmenu3;
 global b1;
 global b2;
 global b3;
 global b4;
 global txt;
 global ax;
 global histy;
 global texty;


% Buttons
b1 = uicontrol( 'Parent',f1,'visible', ...
    'off', 'Style','Pushbutton','Units','normalized',...
    'Position',[.2 .5 .3 .1], 'BackgroundColor',[.8 .6 .9],...
    'String','Male Aged >=  69','FontSize', 18,'Callback',@hist1);
b2 = uicontrol('Parent',f1,'visible', ...
    'off','Style','Pushbutton','Units','normalized',...
    'Position',[.6 .5 .3 .1], 'BackgroundColor',[.6 .4 .7],...
    'String','Male Aged < 69','FontSize', 18, 'Callback',@hist2);
b3 = uicontrol( 'Parent',f1,'visible', ...
    'off', 'Style','Pushbutton','Units','normalized',...
    'Position',[.2 .3 .3 .1], 'BackgroundColor',[.6 .6 .9],...
    'String','Female Aged >=  69','FontSize', 18,'Callback',@hist3);
b4 = uicontrol('Parent',f1,'visible', ...
    'off','Style','Pushbutton','Units','normalized',...
    'Position',[.6 .3 .3 .1], 'BackgroundColor',[.4 .4 .7],...
    'String','Female Aged < 69','FontSize', 18, 'Callback',@hist4);

% Add a text uicontrol for user instructions
txt = uicontrol('Parent',f1,'visible', ...
    'off','Style','text',...
      'Units','normalized',...
      'Position',[.1 .7 .9 .08],...
      'FontSize', 18,...
      'String','Please select a button to display different figures.');

% Creating a dropdown menu
 set([ b1, b2, b3, b4 txt], 'visible','on');
 
 
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

ddmenu2 = uidropdown(uif,...
    'Position',[410 210 140 22],...
    'Items',{'Waist Circumference', 'Mean Liver Fat p', 'Total Fat Index',...
    'Age', 'Weight', 'Height', 'BMI', 'Sex', 'Race', 'Diabetes'},...
    'Value','BMI',...
    'ValueChangedFcn',@(ddmenu2,event) selection2(ddmenu2),'visible', 'off');

ddmenu3 = uidropdown(uif,...
    'Position',[410 210 140 22],...
    'Items',{'Waist Circumference', 'Mean Liver Fat p', 'Total Fat Index',...
    'Age', 'Weight', 'Height', 'BMI', 'Sex', 'Race', 'Diabetes'},...
    'Value','BMI',...
    'ValueChangedFcn',@(ddmenu3,event) selection3(ddmenu3),'visible', 'off');

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
            waist_cir = T3.waist_cir3;
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
            texty = text(ax,94,4,circstr);
            xlabel(ax,'Waist Circumference (cm)');
            ylabel(ax,'Frequency');
        case {'Mean Liver Fat p'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            mean_liver_fat_p = T3.mean_liver_fat_p;
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
            texty = text(ax,5,10,circstr);
            xlabel(ax,'Mean Liver Fat p (%)');
            ylabel(ax,'Frequency');
        case {'Total Fat Index'}            
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            total_fat = T3.total_fat_index;
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
            texty = text(ax,4.5,10,circstr);
            xlabel(ax,'Total Fat Index');
            ylabel(ax,'Frequency');
        case {'Age'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            age = T3.age3;
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
            texty = text(ax,73,9,circstr); 
            xlabel(ax,'Age (year)');
            ylabel(ax,'Frequency');
            xlim([69 78]);
        case {'Weight'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            weight = T3.weight3;
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
            texty = text(ax,50,9,circstr); 
            xlabel(ax,'Weight (kg)');
            ylabel(ax,'Frequency');
        case {'Height'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            height = T3.height3;
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
            texty = text(ax,160,9,circstr);
            xlabel(ax,'Height (cm)');
            ylabel(ax,'Frequency');
        case {'BMI'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            bmi = T3.bmi3;
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
            texty = text(ax,18,9,circstr);
            xlabel(ax,'BMI (kg/m^2)');
            ylabel(ax,'Frequency');
        case {'Sex'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            sex = T3.sex;
            c1 = categorical(sex);
            histy = histogram(ax,c1);
            xlabel(ax,'Sex');
            ylabel(ax,'Frequency');
        case {'Race'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            race = T3.race3;
            c2 = categorical(race);
            histy = histogram(ax,c2);
            xlabel(ax,'Race');
            ylabel(ax,'Frequency');
        case {'Diabetes'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            diabetes = T3.diabetes3;
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
            waist_cir = T4.waist_cir3;
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
            mean_liver_fat_p = T4.mean_liver_fat_p;
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
            texty = text(ax,20,100,circstr);
            xlabel(ax,'Mean Liver Fat p (%)');
            ylabel(ax,'Frequency');
        case {'Total Fat Index'}            
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            total_fat = T4.total_fat_index;
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
            texty = text(ax,5,50,circstr);
            xlabel(ax,'Total Fat Index');
            ylabel(ax,'Frequency');
        case {'Age'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            age = T4.age3;
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
            texty = text(ax,45,50,circstr); 
            xlabel(ax,'Age (year)');
            ylabel(ax,'Frequency');
        case {'Weight'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            weight = T4.weight3;
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
            texty = text(ax,100,50,circstr); 
            xlabel(ax,'Weight (kg)');
            ylabel(ax,'Frequency');
        case {'Height'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            height = T4.height3;
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
            texty = text(ax,153,60,circstr);
            xlabel(ax,'Height (cm)');
            ylabel(ax,'Frequency');
        case {'BMI'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            bmi = T4.bmi3;
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
            sex = T4.sex;
            c1 = categorical(sex);
            histy = histogram(ax,c1);
            xlabel(ax,'Sex');
            ylabel(ax,'Frequency');
        case {'Race'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            race = T4.race3;
            c2 = categorical(race);
            histy = histogram(ax,c2);
            xlabel(ax,'Race');
            ylabel(ax,'Frequency');
        case {'Diabetes'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            diabetes = T4.diabetes3;
            c3 = categorical(diabetes);
            histy = histogram(ax,c3);
            xlabel(ax,'Diabetes');
            ylabel(ax,'Frequency');
    end
end

function hist3(hObject,eventdata)
    set([f1,b1,b2,txt],'visible','off');
    set([uif,ddmenu2],'visible','on');
end

% Create ValueChangedFcn callback:
function selection2(ddmenu2, eventdata, handles)
    choice = get(ddmenu2,'Value');
    switch choice
        case {'Waist Circumference'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            waist_cir = T5.waist_cir3;
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
            texty = text(ax,90,4,circstr);
            xlabel(ax,'Waist Circumference (cm)');
            ylabel(ax,'Frequency');
        case {'Mean Liver Fat p'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            mean_liver_fat_p = T5.mean_liver_fat_p;
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
            texty = text(ax,6,20,circstr);
            xlabel(ax,'Mean Liver Fat p (%)');
            ylabel(ax,'Frequency');
        case {'Total Fat Index'}            
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            total_fat = T5.total_fat_index;
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
            texty = text(ax,5,10,circstr);
            xlabel(ax,'Total Fat Index');
            ylabel(ax,'Frequency');
        case {'Age'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            age = T5.age3;
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
            texty = text(ax,73,14,circstr); 
            xlabel(ax,'Age (year)');
            ylabel(ax,'Frequency');
            xlim([69 78]);
        case {'Weight'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            weight = T5.weight3;
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
            texty = text(ax,80,14,circstr); 
            xlabel(ax,'Weight (kg)');
            ylabel(ax,'Frequency');
        case {'Height'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            height = T5.height3;
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
            texty = text(ax,166,14,circstr);
            xlabel(ax,'Height (cm)');
            ylabel(ax,'Frequency');
        case {'BMI'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            bmi = T5.bmi3;
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
            texty = text(ax,28,12,circstr);
            xlabel(ax,'BMI (kg/m^2)');
            ylabel(ax,'Frequency');
        case {'Sex'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            sex = T5.sex;
            c1 = categorical(sex);
            histy = histogram(ax,c1);
            xlabel(ax,'Sex');
            ylabel(ax,'Frequency');
        case {'Race'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            race = T5.race3;
            c2 = categorical(race);
            histy = histogram(ax,c2);
            xlabel(ax,'Race');
            ylabel(ax,'Frequency');
        case {'Diabetes'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            diabetes = T5.diabetes3;
            c3 = categorical(diabetes);
            histy = histogram(ax,c3);
            xlabel(ax,'Diabetes');
            ylabel(ax,'Frequency');
    end
end


function hist4(hObject,eventdata)
    set([f1,b1,b2,txt],'visible','off');
    set([uif,ddmenu3],'visible','on');
end

% Create ValueChangedFcn callback:
function selection3(ddmenu3, eventdata, handles)
    choice = get(ddmenu3,'Value');
    switch choice
        case {'Waist Circumference'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            waist_cir = T6.waist_cir3;
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
            texty = text(ax,100,80,circstr);
            xlabel(ax,'Waist Circumference (cm)');
            ylabel(ax,'Frequency');
        case {'Mean Liver Fat p'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            mean_liver_fat_p = T6.mean_liver_fat_p;
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
            texty = text(ax,15,180,circstr);
            xlabel(ax,'Mean Liver Fat p (%)');
            ylabel(ax,'Frequency');
        case {'Total Fat Index'}            
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            total_fat = T6.total_fat_index;
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
            texty = text(ax,6,90,circstr);
            xlabel(ax,'Total Fat Index');
            ylabel(ax,'Frequency');
        case {'Age'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            age = T6.age3;
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
            texty = text(ax,45,60,circstr); 
            xlabel(ax,'Age (year)');
            ylabel(ax,'Frequency');
        case {'Weight'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            weight = T6.weight3;
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
            texty = text(ax,90,70,circstr); 
            xlabel(ax,'Weight (kg)');
            ylabel(ax,'Frequency');
        case {'Height'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            height = T6.height3;
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
            texty = text(ax,170,80,circstr);
            xlabel(ax,'Height (cm)');
            ylabel(ax,'Frequency');
        case {'BMI'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            bmi = T6.bmi3;
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
            sex = T6.sex;
            c1 = categorical(sex);
            histy = histogram(ax,c1);
            xlabel(ax,'Sex');
            ylabel(ax,'Frequency');
        case {'Race'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            race = T6.race3;
            c2 = categorical(race);
            histy = histogram(ax,c2);
            xlabel(ax,'Race');
            ylabel(ax,'Frequency');
        case {'Diabetes'}
            ax.NextPlot = 'replace';
            cla(ax);
            set(ax,'visible','on');
            diabetes = T6.diabetes3;
            c3 = categorical(diabetes);
            histy = histogram(ax,c3);
            xlabel(ax,'Diabetes');
            ylabel(ax,'Frequency');
    end
end


end
