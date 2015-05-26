% Statistical Tests

clear all, 
clc;

% Load file
Results_data = readtable('TestCase_Results_m.xlsx','Sheet',1); 
Results_data = table2cell(Results_data(:,1:12)); 
Results_data = cell2mat(Results_data);

% sort based on Training Type and then robot condition, then signal Type
Results_data = sortrows(Results_data,[1,2,3]);

% Mapping
 
ColTrgType = 1;
ColSigType = 2;
ColRobCond = 3;
ColFailType = 4;
ColTrgSource =5;
ColTestSource = 6;
ColAvgQ = 7;
ColMaxQ = 8;
ColStdQ = 9;
ColsTFD = 10;
ColsNSA = 11;
ColsTFD_R = 12;

 
%  
%  
%  %%
%  %% anovan
%  

for i = 1:6
 [p(:,i) table(:,:,i) stats(:,:,i)] = anovan(Results_data(:,i+6),{Results_data(:,1),Results_data(:,2),Results_data(:,3)},...
  'model','full','varnames',{'training type','signal type','Robot Condition' },'display','off');
 
 %results(:,:,i) = multcompare(stats(:,:,i),'Dimension',[1 2 3]);
end
 
figure(1)
          results1 = multcompare(stats(:,:,1),'Dimension',[1 2]);
figure(2)        
          results2 = multcompare(stats(:,:,1),'Dimension',[1 3]);
figure(3)         
           results3 = multcompare(stats(:,:,1),'Dimension',[2 3]); 
figure(4) 
           
          results4 = multcompare(stats(:,:,5),'Dimension',[1 2]);
 figure(5)        
          results5 = multcompare(stats(:,:,5),'Dimension',[1 3]);
 figure(6)         
           results6 = multcompare(stats(:,:,5),'Dimension',[2 3]); 
 figure(7)  
           
           results7 = multcompare(stats(:,:,6),'Dimension',[1 2]);
  figure(8)        
          results8= multcompare(stats(:,:,6),'Dimension',[1 3]);
     figure(9)     
           results9 = multcompare(stats(:,:,6),'Dimension',[2 3]); 
  
           

%p_n = cat(2,p5,p6,p7,p8,p9,p10);

% ColHeader_anova1 = {'Test',	'Signal Type',	'Avg_Q',	'Max_Q',	'Std Deviation',...	
%     'Normalized q-Residual', 'FirstPoint',	'No of Points above threshold'};
% stat_print = fullfile('C:\Users\INSAV3\Predictive Analytics\DataSets\ETFA-Data\Results','TestCase_Results.xlsx');
%  
% xlswrite(stat_print, ColHeader_anova1,'anova1','A1');       
% xlswrite(stat_print, p,'anova1','C2'); 
% 
% ColHeader_anovan = {'Attribute', 	'Avg_Q',	'Max_Q',	'Std Deviation',...	
%     'Normalized q-Residual','FirstPoint',	'No of Points above threshold'};
% 
% % Write test data set -  distinct measures
% xlswrite(stat_print, ColHeader_anovan,'anovan','A1');       
% xlswrite(stat_print, p_n,'anovan','B2'); 

