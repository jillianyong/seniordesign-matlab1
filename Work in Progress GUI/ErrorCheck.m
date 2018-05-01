clear
%New Script to plot errors
%Loads saved random forest model
load('liverfatmodel.mat','mdl');
load('LiverTable.mat','T');

predlivfat = zeros(1,25);
reallivfat = zeros(1,25);

%Prompt Test Subject for input
for i = 1:25
    waist_cir3 = T.waist_cir3(i);
    bmi3 = T.bmi3(i);
    weight3 = T.weight3(i);
    total_fat_index = T.total_fat_index(i);
    VAT_index = T.VAT_index(i);
    SAT_index = T.SAT_index(i);
    newT = table(waist_cir3, bmi3, total_fat_index, weight3, VAT_index,SAT_index);
    [predlivfat(1,i), stdlivfat] = predict(mdl, newT);
    reallivfat(1,i) = T.mean_liver_fat_p(i);
%     disp(predlivfat(1,i))
end

figure
plot(predlivfat,'bo')
hold on
plot(reallivfat,'ro')
title('Comparison of Predicted Liver Fat vs Real Liver Fat')
legend('Predicted Liver Fat','Real Liver Fat')
xlabel('Trial Number')
ylabel('Mean Liver Fat %')
set(gca,'FontSize',14)