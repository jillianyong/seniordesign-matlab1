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

mdl = fitlm(T,'mean_liver_fat_p~sex+waist_cir3+bmi3+diabetes_type+total_fat_index+Activity')
mdl1 = fitlm(T1,'mean_liver_fat_p~sex+waist_cir3+bmi3+diabetes_type+total_fat_index+Activity')
mdl2 = fitlm(T2,'mean_liver_fat_p~sex+waist_cir3+bmi3+diabetes_type+total_fat_index+Activity')
mdl3 = fitlm(T3,'mean_liver_fat_p~sex+waist_cir3+bmi3+diabetes_type+total_fat_index+Activity')
