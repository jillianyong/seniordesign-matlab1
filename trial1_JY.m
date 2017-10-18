% Gets the import options for the spreadsheet
x = detectImportOptions('liver_fat_with_covariates.csv');
% Imports the spreadsheet as a table
T = readtable('liver_fat_with_covariates.csv',x);
% Converts the table into cell format
liver_fat_with_covariates = table2cell(T);

% Read all Excel files
filename = 'liver_fat_with_covariates.csv';

% Create Drop Down Menu
figure = uifigure;
ax = uiaxes('Parent',figure,'Position',[10 10 400 400]);

% Creating a dropdown menu
ddmenu = uidropdown(figure,...
    'Position',[430 210 100 22],...
    'Items',{'Waist Circumference', 'Mean Liver Fat p', 'Total Fat',...
    'Age', 'Weight', 'Height', 'BMI', 'Sex', 'Race', 'Diabetes'},...
    'Value','BMI',...
    'ValueChangedFcn',@(ddmenu,event) selection(ddmenu));

% Create ValueChangedFcn callback:
    function selection(ddmenu)
    x = detectImportOptions('liver_fat_with_covariates.csv');
    T = readtable('liver_fat_with_covariates.csv',x);
    choice = get(ddmenu,'Value');
    switch choice
        case {'Waist Circumference'}
            waist_cir = T.waist_cir3;
            histogram(waist_cir)
        case {'Mean Liver Fat p'}
            mean_liver_fat_p = T.mean_liver_fat_p;
            histogram(mean_liver_fat_p)
        case {'Total Fat'}
            total_fat = T.total_fat;
            histogram(total_fat)
        case {'Age'}
            age = T.age3;
            histogram(age)
        case {'Weight'}
            weight = T.weight3;
            histogram(weight)
        case {'Height'}
            height = T.height3;
            histogram(height)
        case {'BMI'}
            bmi = T.bmi3;
            histogram(bmi)
        case {'Sex'}
            sex = T.sex;
            c1 = categorical(sex);
            histogram(c1)
        case {'Race'}
            race = T.race3;
            c2 = categorical(race);
            histogram(c2)
        case {'Diabetes'}
            diabetes = T.diabetes3;
            c3 = categorical(diabetes);
            histogram(c3)
    end
    end