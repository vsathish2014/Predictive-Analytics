% Statistical Tests

% clear all, 
% clc;

% Load file
Results_data = readtable('TestCase_Results.xlsx','Sheet',1); 
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


%1) Analysis of Variance OTM_F Vs OTM_N
 
Results_data_1 = Results_data(find(Results_data(:,1)==1),:);

for j = 1:3
    Results_data_1 = Results_data(find(Results_data(:,1)==1),:);
    k=1;
    for i = 7:12   
     Results_data_1 = Results_data_1(find(Results_data_1(:,2)==j),:);
      p_1(j,k) = anova1(Results_data_1(:,i),Results_data_1(:,3),'off');
      k =k+1;
    end
end
%2) Analysis of Variance OTO_F Vs OTO_N
Results_data_2 = Results_data(find(Results_data(:,1)==2),:);
for j = 1:3
    Results_data_2 = Results_data(find(Results_data(:,1)==2),:);
    k=1;
    for i = 7:12   
     Results_data_2 = Results_data_2(find(Results_data_2(:,2)==j),:);
      p_2(j,k) = anova1(Results_data_2(:,i),Results_data_2(:,3),'off');
      k =k+1;
    end
end

% 3) Analysis of variance - OTM F Vs OTO F

Results_data_3 = Results_data(find(Results_data(:,3)==1),:);
for j = 1:3
    Results_data_3 = Results_data(find(Results_data(:,3)==1),:);
    k=1;
    for i = 7:12   
     Results_data_3 = Results_data_3(find(Results_data_3(:,2)==j),:);
      p_3(j,k) = anova1(Results_data_3(:,i),Results_data_3(:,1),'off');
      k =k+1;
    end
end

% 4) Analysis of variance - OTM N Vs OTO N

Results_data_4 = Results_data(find(Results_data(:,3)==2),:);
for j = 1:3
    Results_data_4 = Results_data(find(Results_data(:,3)==2),:);
    k=1;
    for i = 7:12   
     Results_data_4 = Results_data_4(find(Results_data_4(:,2)==j),:);
      p_4(j,k) = anova1(Results_data_4(:,i),Results_data_4(:,1),'off');
      k =k+1;
    end
end


%  
%  
%  %%
%  %% anovan
%  
 [p5 table5 stats5] = anovan(Results_data(:,7),{Results_data(:,1),Results_data(:,2),Results_data(:,3)},...
  'varnames',{'training type','signal type','Robot Condition' },'display','off');

[p6 table6 stats6] = anovan(Results_data(:,8),{Results_data(:,1),Results_data(:,2),Results_data(:,3)},...
  'varnames',{'training type','signal type','Robot Condition'  },'display','off');
 
[p7 table7 stats7] = anovan(Results_data(:,9),{Results_data(:,1),Results_data(:,2),Results_data(:,3) },...
  'varnames',{'training type','signal type','Robot Condition'  },'display','off');
 
[p8 table8 stats8] = anovan(Results_data(:,10),{Results_data(:,1),Results_data(:,2),Results_data(:,3) },...
  'varnames',{'training type','signal type','Robot Condition' },'display','off');

[p9 table9 stats9] = anovan(Results_data(:,11),{Results_data(:,1),Results_data(:,2),Results_data(:,3) },...
  'varnames',{'training type','signal type','Robot Condition' },'display','off');

[p10 table10 stats10] = anovan(Results_data(:,12),{Results_data(:,1),Results_data(:,2),Results_data(:,3) },...
  'varnames',{'training type','signal type','Robot Condition'  },'display','off');

p = cat(1,p_1,p_2,p_3,p_4);
p_n = cat(2,p5,p6,p7,p8,p9,p10);

ColHeader_anova1 = {'Test',	'Signal Type',	'Avg_Q',	'Max_Q',	'Std Deviation',...	
    'Normalized q-Residual', 'FirstPoint',	'No of Points above threshold'};
stat_print = fullfile('C:\Users\INSAV3\Predictive Analytics\DataSets\ETFA-Data\Results','TestCase_Results.xlsx');
 
xlswrite(stat_print, ColHeader_anova1,'anova1','A1');       
xlswrite(stat_print, p,'anova1','C2'); 

ColHeader_anovan = {'Attribute', 	'Avg_Q',	'Max_Q',	'Std Deviation',...	
    'Normalized q-Residual','FirstPoint',	'No of Points above threshold'};

% Write test data set -  distinct measures
xlswrite(stat_print, ColHeader_anovan,'anovan','A1');       
xlswrite(stat_print, p_n,'anovan','B2'); 

