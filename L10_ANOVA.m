clear all;
clc;
close all;

% data =readtable('SISL10h_14112014.xlsx','sheet',6);
% 
% data = table2cell(data);
% CT =data(:,1);
% MDN =data(:,2);
% MDFN =data(:,3);
% 
% L10h_1 = cell2mat(data(:,4));
% p = anovan(L10h_1,{CT MDN MDFN})


% data2 =readtable('SISL10h_19112014.xlsx','sheet',1);
% data2 = table2cell(data2);
% CT =data2(:,8);
% Axis =  cell2mat(data2(:,9));
% MDN =data2(:,10);
% MDFN =data2(:,11);
% 
% L10h = cell2mat(data2(:,12));
% p = anovan(L10h,{CT Axis MDN MDFN},'varnames',{'Controller Type'; 'Axis'; 'Meachanical Device Name'; 'Mechanical Device Family Name'});
% % 
% % 

data2 =readtable('SISL10h_19112014.xlsx','sheet',3);
data2 = table2cell(data2);
CT =data2(:,8);
Axis =  cell2mat(data2(:,9));
MDN =data2(:,10);
 

L10h = cell2mat(data2(:,12));
p = anovan(L10h,{CT Axis MDN  },'varnames',{'Controller Type'; 'Axis'; 'Meachanical Device Name' });





% % data1 =readtable('SISL10h_14112014.xlsx','sheet',7);
% % 
% % data1 = table2cell(data1);
% % X1 =cell2mat(data1(:,1));
% % X2=cell2mat(data1(:,2));
% %  
% % 
% % Y = cell2mat(data1(:,3));
% % p = anovan(Y,{X1 X2})
