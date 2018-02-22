function lmmodel

% Import Data
x = detectImportOptions('BCP_Activity6021.xlsx');
T = readtable('BCP_Activity6021.xlsx',x);
T1 = T(1:3001,:);
T2 = T(3002:6021,:);
T3 = T(1501:4521,:);

%lm = fitlm(T,'mean_liver_fat_p~age3+sex+ActivityIndex+SAT_index+VAT_index+diabetes_type');
%lm1 = fitlm(T1,'mean_liver_fat_p~age3+sex+ActivityIndex+SAT_index+VAT_index+diabetes_type');
%lm2 = fitlm(T2,'mean_liver_fat_p~age3+sex+ActivityIndex+SAT_index+VAT_index+diabetes_type');
%lm3 = fitlm(T3,'mean_liver_fat_p~age3+sex+ActivityIndex+SAT_index+VAT_index+diabetes_type');

% Eitehr Avtivity or ActivityIndex
% Prediction for Mean liver fat percentage
%mlfp = fitlm(T,'mean_liver_fat_p~age3+waist_cir3+bmi3+diabetes_type+ActivityIndex')
%mlfp1 = fitlm(T1,'mean_liver_fat_p~age3+waist_cir3+bmi3+diabetes_type+ActivityIndex')
%mlfp2 = fitlm(T2,'mean_liver_fat_p~age3+waist_cir3+bmi3+diabetes_type+ActivityIndex')
%mlfp3 = fitlm(T3,'mean_liver_fat_p~age3+waist_cir3+bmi3+diabetes_type+ActivityIndex')

% Prediction for Inverted squared liver fat 
%islf = fitlm(T,'inv_sqrt_liver_fat~age3+waist_cir3+bmi3+diabetes_type+ActivityIndex')
%islf1 = fitlm(T1,'inv_sqrt_liver_fat~age3+waist_cir3+bmi3+diabetes_type+ActivityIndex')
%islf2 = fitlm(T2,'inv_sqrt_liver_fat~age3+waist_cir3+bmi3+diabetes_type+ActivityIndex')
%islf3 = fitlm(T3,'inv_sqrt_liver_fat~age3+waist_cir3+bmi3+diabetes_type+ActivityIndex')  

% Prediction for Liver fat transform
lft = fitlm(T,'liver_fat_transform~age3+waist_cir3+bmi3+diabetes_type+ActivityIndex+VAT_index')
lft1 = fitlm(T1,'liver_fat_transform~age3+waist_cir3+bmi3+diabetes_type+ActivityIndex+VAT_index')
lft2 = fitlm(T2,'liver_fat_transform~age3+waist_cir3+bmi3+diabetes_type+ActivityIndex+VAT_index')
lft3 = fitlm(T3,'liver_fat_transform~age3+waist_cir3+bmi3+diabetes_type+ActivityIndex+VAT_index')  


