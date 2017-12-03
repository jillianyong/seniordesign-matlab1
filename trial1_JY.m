%Rita Test if this works
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
        case {'Mean Liver Fat p'}
            mean_liver_fat_p = T.mean_liver_fat_p;
            histogram(ax,mean_liver_fat_p)
        case {'Total Fat'}
            total_fat = T.total_fat;
            histogram(ax,total_fat)
        case {'Age'}
            age = T.age3;
            histogram(ax,age)
        case {'Weight'}
            weight = T.weight3;
            histogram(ax,weight)
        case {'Height'}
            height = T.height3;
            histogram(ax,height)
        case {'BMI'}
            bmi = T.bmi3;
            histogram(ax,bmi)
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