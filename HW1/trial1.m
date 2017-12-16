%% Copyright 2017
% Rita Chen richen@bu.edu
% Max Christ mmchrist@bu.edu
% Jillian Yong jeyong@bu.edu
% All Rights Reserved

%%
% Gets the import options for the spreadsheet
x = detectImportOptions('liver_fat_with_covariates.csv');
% Imports the spreadsheet as a table
T = readtable('liver_fat_with_covariates.csv',x);
% Converts the table into cell format
liver_fat_with_covariates = table2cell(T);

% Read all Excel files
filename = 'liver_fat_with_covariates.csv';
% file = dlmread(filename,'',1,0);


% 10 Selected Phenotypes
waist_cir = T.waist_cir3;
mean_liver_fat_p = T.mean_liver_fat_p;
total_fat = T.total_fat;
age = T.age3;
sex = T.sex;
race = T.race3;
diabetes = T.diabetes3;
weight = T.weight3;
height = T.height3;
bmi = T.bmi3;

% Create Drop Down Menu
figure = uifigure;
ax = uiaxes('Parent',fig,'Position',[10 10 400 400]);

% Create histogram
x1 = total_thigh_L;
x2 = mean_liver_fat_p; % be careful this data set has NA
x3 = total_fat;
x4 = age;
x5 = weight;
x6 = height;
x7 = bmi;

h1 = histogram(x1);
h2 = histogram(x2);
h3 = histogram(x3);
h4 = histogram(x4);
h5 = histogram(x5);
h6 = histogram(x6);
h7 = histogram(x7);

c1 = categorical(sex,[Male,Female],{'Male','Female'});
c2 = categorical(race,[British,Irish, Do not know, Any other... 
    white background, White and Black Caribbean, NA, African, Indian,...
    Other ethinic group, Prefer not to answer, Chinese, Bangladeshi,...
    Caribbean, Pakistani, Asian or Asian British, ...
    Any other Asian background, White and Asian, White, ...
    Any other mixed background, White and Black African ...
    ],{'British,Irish, Do not know', 'Any other white background',...
    'White and Black Caribbean', 'NA', 'African', 'Indian',...
    'Other ethinic group', 'Prefer not to answer', 'Chinese', 'Bangladeshi',...
    'Caribbean', 'Pakistani', 'Asian or Asian British', ...
    'Any other Asian background', 'White and Asian', 'White', ...
    'Any other mixed background', 'White and Black African'});
c3 = categorical(diabetes,[Yes, NO], {'Yes','No'});

h8 = histogram(c1,'BarWidth',0.5);
h9 = histogram(c2,'BarWidth',0.5);
h10 = histogram(c3,'BarWidth',0.5);
% nbins = h.NumBins, find the numbers of bins

ddmenu = uidropdown(figure,...
    'Position',[430 210 100 22],...
    'Items',{'Total Thight L', 'Mean Liver Fat p', 'Total Fat',...
    'Age', 'Weight', 'Height', 'BMI', 'Sex', 'Race', 'Diabetes'},...
    'Value','BMI',...
    'ValueChangedFcn',@(ddmenu,event) selection(ddmenu,h));

% Create ValueChangedFcn callback:
    function selection(ddmenu,h)
        val = ddmenu.Value;
        s = 10;
        for i = 1:s
            h(i) = val;
        end
    end



