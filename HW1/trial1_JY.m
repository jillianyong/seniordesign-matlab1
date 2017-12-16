%% Copyright 2017
% Rita Chen richen@bu.edu
% Max Christ mmchrist@bu.edu
% Jillian Yong jeyong@bu.edu
% All Rights Reserved

%%
function trial1_JY
% Gets the import options for the spreadsheet
x = detectImportOptions('liver_fat_with_covariates.csv');
% Imports the spreadsheet as a table
global T
T = readtable('liver_fat_with_covariates.csv',x);
% Converts the table into cell format
liver_fat_with_covariates = table2cell(T);

% Read all Excel files
filename = 'liver_fat_with_covariates.csv';

% Create Drop Down Menu
% global figure
figure = uifigure;
global ax
ax = uiaxes('Parent',figure,'Position',[10 10 400 400]);
% waist_cir = T.waist_cir3;
% histogram(waist_cir)

% Creating a dropdown menu
set(figure, 'visible','on')
ddmenu = uidropdown(figure,...
    'Position',[430 210 100 22],...
    'Items',{'Waist Circumference', 'Mean Liver Fat p', 'Total Fat',...
    'Age', 'Weight', 'Height', 'BMI', 'Sex', 'Race', 'Diabetes'},...
    'Value','BMI',...
    'ValueChangedFcn',@(ddmenu,event) selection(ddmenu));

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
            %hold on
            %plot(ax,meanwaistcir,ylim,'r--','LineWidth',2)
            %hold off
            medianwaistcir = median(waist_cir);
            %fivepwaistcir = prctile(waist_cir,5);
            %ninefivepwaistcir = prctile(waist_cir,95);
        case {'Mean Liver Fat p'}
            mean_liver_fat_p = T.mean_liver_fat_p;
            histogram(ax,mean_liver_fat_p)
            mean_liver_fat_p(isnan(mean_liver_fat_p)) = [];
            meanlivfatp = mean(mean_liver_fat_p);
            medianlivfatp = median(mean_liver_fat_p);
            %fiveplivfatp = prctile(mean_liver_fat_p,5);
            %ninefiveplivfatp = prctile(mean_liver_fat_p,95);
        case {'Total Fat'}
            total_fat = T.total_fat;
            histogram(ax,total_fat)
            total_fat(isnan(total_fat)) = [];
            meantotfat = mean(total_fat);
            mediantotfat = median(total_fat);
            %fiveptotfat = prctile(total_fat,5);
            %ninefiveptotfat = prctile(total_fat,95);
        case {'Age'}
            age = T.age3;
            histogram(ax,age)
            age(isnan(age)) = [];
            meanage = mean(age);
            %hold on
            %plot(ax,meanage,ylim,'r--','LineWidth',2)
            %hold off
            medianage = median(age);
            %fivepage = prctile(age,5);
            %ninefivepage = prctile(age,95);
        case {'Weight'}
            weight = T.weight3;
            histogram(ax,weight)
            weight(isnan(weight)) = [];
            meanweight = mean(weight);
            medianweight = median(weight);
            %fivepweight = prctile(weight,5);
            %ninefivepweight = prctile(weight,95);
        case {'Height'}
            height = T.height3;
            histogram(ax,height)
            height(isnan(height)) = [];
            meanheight = mean(height);
            medianheight = median(height);
            %fivepheight = prctile(height,5);
            %ninefivepheight = prctile(height,95);
        case {'BMI'}
            bmi = T.bmi3;
            histogram(ax,bmi)
            bmi(isnan(bmi)) = [];
            meanbmi = mean(bmi);
            medianbmi = median(bmi);
            %fivepbmi = prctile(bmi,5);
            %ninefivepbmi = prctile(bmi,95);
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