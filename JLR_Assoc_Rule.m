clc;
clear;
close all;
% Dock all the charts  as tabs
 set(0,'DefaultFigureWindowStyle','docked')
 
 
%Read distrubitions      
        data =readtable('JLR_SeqClustering_all_50056.xlsx','Sheet',4,'Range','B1:AP23');
      
     
 data= table2cell(data); 
 data = cell2mat(data);
 data_l = data(1,:);
 data1 = data(2:end,:);
 
%  data = num2cell(data);
%  data(cellfun(@isnan,data))={0};
 
 minSup = 0.1;
minConf = 0.5;
nRules = 200;
sortFlag = 1;
fname = 'JLRRules';
for s = 1: size(data_l,2)
    labels{s} = ['E' num2str(data_l(1,s))];
end

[Rules FreqItemsets] = findRules(data1, minSup, minConf, nRules, sortFlag, labels, fname);
disp(['See the file named ' fname '.txt for the association rules']);
 