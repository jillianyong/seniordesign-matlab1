% Script to save the table to a matfile
x = detectImportOptions('BCP_Activity6021.xlsx');
T = readtable('BCP_Activity6021.xlsx',x);
save('LiverTable.mat','T');