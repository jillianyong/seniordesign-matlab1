% Script to save the table to a matfile
x = detectImportOptions('BCP_Activity6021.xlsx');
T1 = readtable('BCP_Activity6021.xlsx',x);
x2 = detectImportOptions('studentvars_labeled.xlsx');
T2 = readtable('studentvars_labeled.xlsx',x2);
T = [T1 T2]; 
save('LiverTable.mat','T');