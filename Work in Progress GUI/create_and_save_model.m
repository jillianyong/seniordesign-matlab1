% Imports table and saves matfile containing model variable

%Import Table
x = detectImportOptions('BCP_Activity6021.xlsx');
T = readtable('BCP_Activity6021.xlsx',x);
%Create Model
mdl = fitlm(T,'mean_liver_fat_p~waist_cir3+bmi3+diabetes_type+ActivityIndex+VAT_index+age3')
%Save model
save('liverfatmodel.mat','mdl');






% %Imaginary Test Subject
% waist_cir3 = 90;
% bmi3 = 30;
% diabetes_type = 2;
% total_fat_index = 4;
% ActivityIndex = -1;
% newT = table(waist_cir3, bmi3, diabetes_type, total_fat_index, ActivityIndex);

% %Prediction of liver fat and confidence interval
% [livfat, conint] = predict(mdl, newT)