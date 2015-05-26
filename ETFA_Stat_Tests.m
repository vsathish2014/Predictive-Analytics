% Statistical Tests

clear all, 
clc;

% Load file
Results_data = readtable('TestCase_Results_m.xlsx','Sheet',1); 
Results_data = table2cell(Results_data(:,1:11)); 
Results_data = cell2mat(Results_data);

% sort based on Training Type and then robot condition
Results_data = sortrows(Results_data,[1,3]);

% Mapping
 
ColTrgType = 1;
ColSigType = 2;
ColRobCond = 3;
ColTrgSource =4;
ColTestSource = 5;
ColAvgQ = 6;
ColMaxQ = 7;
ColStdQ = 8;
ColsTFD = 9;
ColsNSA = 10;
ColsTFD_R = 11;


% Analysis of Variance - Q Avg
 
% test 1 - OTM_F VS OTM_N
 
%test1_d1 = cell2mat(test_d(1:24,1));
test1_d1 = Results_data(1:24,6);
test1_d2 =  Results_data(1:24,3) ;
[p1 table1 stats1] = anova1(test1_d1,test1_d2,'display','off');
title('Avg Q- OTM F Vs OTM N','FontSize',12);
 set(gcf,'color','w');
 
 % test 2 = OTO_F Vs OTO_N
 
test2_d1 = Results_data(25:36,6);
test2_d2 = Results_data(25:36,3);
[p2 table2 stats2] = anova1(test2_d1,test2_d2,'display','off');
title('Anova- Avg Q OTO F Vs OTO N','FontSize',12);
 set(gcf,'color','w');
 
% test 3 = OTM_F Vs OTO_F

test3_d1 = cat(1, Results_data(1:12,6),Results_data(25:30,6));
test3_d2 = cat(1,Results_data(1:12,1), Results_data(25:30,1));
[p3 table3 stats3] = anova1(test3_d1,test3_d2,'display','off');
title('Anova- Avg Q OTM F Vs OTO F','FontSize',12);
 set(gcf,'color','w');


% test 4 = OTM_N Vs OTO_N 
 test4_d1 = cat(1, Results_data(13:24,6),Results_data(31:36,6));
test4_d2 = cat(1,Results_data(13:24,1), Results_data(31:36,1));
[p4 table4 stats4] = anova1(test4_d1,test4_d2,'display','off');
title('Anova- OTM N Vs OTO N ','FontSize',12);
 set(gcf,'color','w');
 
 
%% Analysis of Variance - Q Max
 
% test 1 - OTM_F VS OTM_N
 
%test1_d1 = cell2mat(test_d(1:24,1));
test1_d1 = Results_data(1:24,7);
test1_d2 =  Results_data(1:24,3) ;
[p5 table5 stats5] = anova1(test1_d1,test1_d2,'display','off');
title('Anova Max Q- OTM F Vs OTM N','FontSize',12);
 set(gcf,'color','w');
 
 % test 2 = OTO_F Vs OTO_N
 
test2_d1 = Results_data(25:36,7);
test2_d2 = Results_data(25:36,3);
[p6 table6 stats6] = anova1(test2_d1,test2_d2,'display','off');
title('Anova Max Q OTO F Vs OTO N','FontSize',12);
 set(gcf,'color','w');
 
% test 3 = OTM_F Vs OTO_F

test3_d1 = cat(1, Results_data(1:12,7),Results_data(25:30,7));
test3_d2 = cat(1,Results_data(1:12,1), Results_data(25:30,1));
[p7 table7 stats7] = anova1(test3_d1,test3_d2,'display','off');
title('Anova Max Q OTM F Vs OTO F','FontSize',12);
 set(gcf,'color','w');


% test 4 = OTM_N Vs OTO_N 
 test4_d1 = cat(1, Results_data(13:24,7),Results_data(31:36,7));
test4_d2 = cat(1,Results_data(13:24,1), Results_data(31:36,1));
[p8 table8 stats8] = anova1(test4_d1,test4_d2,'display','off');
title('Anova Max Q OTM N Vs OTO N ','FontSize',12);
 set(gcf,'color','w');
 
 
%%
%%Analysis of Variance - Std Q
 
% test 1 - OTM_F VS OTM_N
 
%test1_d1 = cell2mat(test_d(1:24,1));
test1_d1 = Results_data(1:24,8);
test1_d2 =  Results_data(1:24,3) ;
[p9 table9 stats9] = anova1(test1_d1,test1_d2,'display','off');
title('Anova Std Q- OTM F Vs OTM N','FontSize',12);
 set(gcf,'color','w');
 
 % test 2 = OTO_F Vs OTO_N
 
test2_d1 = Results_data(25:36,8);
test2_d2 = Results_data(25:36,3);
[p10 table10 stats10] = anova1(test2_d1,test2_d2,'display','off');
title('Anova Std Q OTO F Vs OTO N','FontSize',12);
 set(gcf,'color','w');
 
% test 3 = OTM_F Vs OTO_F

test3_d1 = cat(1, Results_data(1:12,8),Results_data(25:30,8));
test3_d2 = cat(1,Results_data(1:12,1), Results_data(25:30,1));
[p11 table11 stats11] = anova1(test3_d1,test3_d2,'display','off');
title('Anova Max Q OTM F Vs OTO F','FontSize',12);
 set(gcf,'color','w');


% test 4 = OTM_N Vs OTO_N 
 test4_d1 = cat(1, Results_data(13:24,8),Results_data(31:36,8));
test4_d2 = cat(1,Results_data(13:24,1), Results_data(31:36,1));
[p12 table12 stats12] = anova1(test4_d1,test4_d2,'display','off');
title('Anova Max Q OTM N Vs OTO N ','FontSize',12);
 set(gcf,'color','w');
 
 %%
%%Analysis of Variance - TFA - Time at First pt above
 
% test 1 - OTM_F VS OTM_N
 
%test1_d1 = cell2mat(test_d(1:24,1));
test1_d1 = Results_data(1:24,9);
test1_d2 =  Results_data(1:24,3) ;
[p13 table13 stats13] = anova1(test1_d1,test1_d2,'display','off');
title('Anova TFA- OTM F Vs OTM N','FontSize',12);
 set(gcf,'color','w');
 
 % test 2 = OTO_F Vs OTO_N
 
test2_d1 = Results_data(25:36,9);
test2_d2 = Results_data(25:36,3);
[p14 table14 stats14] = anova1(test2_d1,test2_d2,'display','off');
title('Anova TFA OTO F Vs OTO N','FontSize',12);
 set(gcf,'color','w');
 
% test 3 = OTM_F Vs OTO_F

test3_d1 = cat(1, Results_data(1:12,9),Results_data(25:30,9));
test3_d2 = cat(1,Results_data(1:12,1), Results_data(25:30,1));
[p15 table15 stats15] = anova1(test3_d1,test3_d2);
title('Anova TFA OTM F Vs OTO F','FontSize',12);
 set(gcf,'color','w');


% test 4 = OTM_N Vs OTO_N 
 test4_d1 = cat(1, Results_data(13:24,9),Results_data(31:36,9));
test4_d2 = cat(1,Results_data(13:24,1), Results_data(31:36,1));
[p16 table16 stats16] = anova1(test4_d1,test4_d2,'display','off');
title('Anova TFA OTM N Vs OTO N ','FontSize',12);
 set(gcf,'color','w');
 
  %%
%%Analysis of Variance - NSA - No. of samples above threshold
 
% test 1 - OTM_F VS OTM_N
 
%test1_d1 = cell2mat(test_d(1:24,1));
test1_d1 = Results_data(1:24,10);
test1_d2 =  Results_data(1:24,3) ;
[p17 table17 stats17] = anova1(test1_d1,test1_d2,'display','off');
title('Anova NSA- OTM F Vs OTM N','FontSize',12);
 set(gcf,'color','w');
 
 % test 2 = OTO_F Vs OTO_N
 
test2_d1 = Results_data(25:36,10);
test2_d2 = Results_data(25:36,3);
[p18 table18 stats18] = anova1(test2_d1,test2_d2,'display','off');
title('Anova NSA OTO F Vs OTO N','FontSize',12);
 set(gcf,'color','w');
 
% test 3 = OTM_F Vs OTO_F

test3_d1 = cat(1, Results_data(1:12,10),Results_data(25:30,10));
test3_d2 = cat(1,Results_data(1:12,1), Results_data(25:30,1));
[p19 table19 stats19] = anova1(test3_d1,test3_d2,'display','off');
title('Anova NSA OTM F Vs OTO F','FontSize',12);
 set(gcf,'color','w');


% test 4 = OTM_N Vs OTO_N 
 test4_d1 = cat(1, Results_data(13:24,10),Results_data(31:36,10));
test4_d2 = cat(1,Results_data(13:24,1), Results_data(31:36,1));
[p20 table20 stats20] = anova1(test4_d1,test4_d2,'display','off');
title('Anova NSA OTM N Vs OTO N ','FontSize',12);
 set(gcf,'color','w');
 
 %%Analysis of Variance - R_TFA - 
 
% test 1 - OTM_F VS OTM_N
 
%test1_d1 = cell2mat(test_d(1:24,1));
test1_d1 = Results_data(1:24,11);
test1_d2 =  Results_data(1:24,3) ;
[p21 table21 stats21] = anova1(test1_d1,test1_d2,'display','off');
title('Anova R-TFA- OTM F Vs OTM N','FontSize',12);
 set(gcf,'color','w');
 
 % test 2 = OTO_F Vs OTO_N
 
test2_d1 = Results_data(25:36,11);
test2_d2 = Results_data(25:36,3);
[p22 table22 stats22] = anova1(test2_d1,test2_d2,'display','off');
title('Anova R_TFA OTO F Vs OTO N','FontSize',12);
 set(gcf,'color','w');
 
% test 3 = OTM_F Vs OTO_F

test3_d1 = cat(1, Results_data(1:12,11),Results_data(25:30,11));
test3_d2 = cat(1,Results_data(1:12,1), Results_data(25:30,1));
[p23 table23 stats23] = anova1(test3_d1,test3_d2,'display','off');
title('Anova R_TFA OTM F Vs OTO F','FontSize',12);
 set(gcf,'color','w');


% test 4 = OTM_N Vs OTO_N 
 test4_d1 = cat(1, Results_data(13:24,11),Results_data(31:36,11));
test4_d2 = cat(1,Results_data(13:24,1), Results_data(31:36,1));
[p24 table24 stats24] = anova1(test4_d1,test4_d2,'display','off');
title('Anova RTFA OTM N Vs OTO N ','FontSize',12);
 set(gcf,'color','w');
 
 
 %%
 %% anovan
 
 [p25 table25 stats25] = anovan(Results_data(:,6),{Results_data(:,1),Results_data(:,2),Results_data(:,3),Results_data(:,4)},...
  'varnames',{'training type','signal type','Robot Condition','Training source' },'display','off');

[p26 table26 stats26] = anovan(Results_data(:,7),{Results_data(:,1),Results_data(:,2),Results_data(:,3),Results_data(:,4)},...
  'varnames',{'training type','signal type','Robot Condition','Training source' },'display','off');
 
[p27 table27 stats27] = anovan(Results_data(:,8),{Results_data(:,1),Results_data(:,2),Results_data(:,3),Results_data(:,4)},...
  'varnames',{'training type','signal type','Robot Condition','Training source' },'display','off');
 
[p28 table28 stats28] = anovan(Results_data(:,9),{Results_data(:,1),Results_data(:,2),Results_data(:,3),Results_data(:,4)},...
  'varnames',{'training type','signal type','Robot Condition','Training source' },'display','off');

[p29 table29 stats29] = anovan(Results_data(:,10),{Results_data(:,1),Results_data(:,2),Results_data(:,3),Results_data(:,4)},...
  'varnames',{'training type','signal type','Robot Condition','Training source' },'display','off');

[p30 table30 stats30] = anovan(Results_data(:,11),{Results_data(:,1),Results_data(:,2),Results_data(:,3),Results_data(:,4)},...
  'varnames',{'training type','signal type','Robot Condition','Training source' },'display','off');