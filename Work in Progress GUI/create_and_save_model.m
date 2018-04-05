% Imports table and saves matfile containing model variable

%Import Table
load('LiverTable.mat','T');

%Create Model
%mdl = fitlm(T,'liver_fat_transform ~ waist_cir3 + bmi3 + ActivityIndex + weight3')


waist_cir3 = T.waist_cir3;
bmi3 = T.bmi3;
total_fat_index = T.total_fat_index;
weight3 = T.weight3;
mean_liver_fat_p = T.mean_liver_fat_p;
VAT_index = T.VAT_index;
SAT_index = T.SAT_index;
treemodelT = table(waist_cir3, bmi3, total_fat_index, VAT_index, SAT_index, weight3, mean_liver_fat_p);
mdl = TreeBagger(500,treemodelT,'mean_liver_fat_p','Method','regression','OOBPredictorImportance','on');
imp = mdl.OOBPermutedPredictorDeltaError;

bar(imp)
title('Curvature Test');
ylabel('Predictor importance estimates');
xlabel('Predictors');

h = gca;
h.XTickLabel = {'Waist Circumference', 'BMI', 'Total Fat Index','VAT Index', 'SAT Index', 'Weight'};
h.XTickLabelRotation = 45;
h.TickLabelInterpreter = 'none';
h.FontSize = 15;
h.FontWeight = 'bold';

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