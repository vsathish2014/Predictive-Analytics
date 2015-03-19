% ROC Curve
clc;
clear all;

data = readtable('ROC_sample.xlsx','Sheet',1);
 data = table2cell(data ); 
 data = cell2mat(data);
yknown = data(:,1);
ypred = data(:,2);
[X,Y,T,AUC] = perfcurve(yknown,ypred,'1');