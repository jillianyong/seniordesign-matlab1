clear
%New Script to plot errors
%Loads saved random forest model
load('liverfatmodel.mat','mdl');
load('LiverTable.mat','T');


%Prompt Test Subject for input

waist_cir3 = T.waist_cir3;
bmi3 = T.bmi3;
weight3 = T.weight3;
total_fat_index = T.total_fat_index;
VAT_index = T.VAT_index;
SAT_index = T.SAT_index;
newT = table(waist_cir3, bmi3, total_fat_index, weight3, VAT_index,SAT_index);
[predlivfat, stdlivfat] = predict(mdl, newT);
reallivfat = T.mean_liver_fat_p;

hasnafld = reallivfat > 6;
predhasnafld = predlivfat > 6;

falseposliv = zeros(1,length(predhasnafld));
falsenegliv = zeros(1,length(predhasnafld));
for i = 1:length(predhasnafld)
    if hasnafld(i) == 1 && predhasnafld(i) == 0
        falsenegliv(i) = 1;
        falseposliv(i) = 0;
    elseif hasnafld(i) == 0 && predhasnafld(i) ==1
        falseposliv(i) = 1;
        falsenegliv(i) = 0;
    else
        falseposliv(i) = 0;
        falsenegliv(i) = 0;
    end
end

falseposliv = (sum(falseposliv)/length(predhasnafld))*100;
falsenegliv = (sum(falsenegliv)/length(predhasnafld))*100;
percentcorrect = (sum(hasnafld == predhasnafld)/length(predhasnafld))*100;

liv_rp = [reallivfat'; predlivfat'];
liv_rp = liv_rp(:, ~any(isnan(liv_rp)));

predcorr = corr(liv_rp(1,:)',liv_rp(2,:)');

fprintf('False positive percentage is %d \n',falseposliv)
fprintf('False negative percentage is %d \n',falsenegliv)
fprintf('Correct classification percentage is %d \n',percentcorrect)
fprintf('Correlation coefficient is %d \n',predcorr)

figure
plot(reallivfat,predlivfat,'bo')
%hold on
%plot(reallivfat,'ro')
title('Comparison of Predicted Liver Fat vs Real Liver Fat')
%legend('Predicted Liver Fat','Real Liver Fat')
xlabel('Actual Liver Fat %')
ylabel('Predicted Liver Fat %')
xlim([0 35])
ylim([0 35])
set(gca,'FontSize',14)