clear all;
clc;
% Dock all the charts  as tabs
 set(0,'DefaultFigureWindowStyle','docked')
% Analysis Plots

 Count_data = readtable('Analysis_count.xlsx','Sheet',1); 
    Count_data_all = table2cell(Count_data(:,2:4)); 
    Count_data = cell2mat(Count_data_all(:,1:2));

 
 OTM_F_Count_FDBT  = Count_data(1:12,1);
 OTM_N_Count_FDBT  = Count_data(13:24,1);
 OTO_F_Count_FDBT  = Count_data(25:30,1);
 OTO_N_Count_FDBT  = Count_data(31:36,1);
 
 OTM_F_Count_NoPtAT  = Count_data(1:12,2);
 OTM_N_Count_NoPtAT  = Count_data(13:24,2);
 OTO_F_Count_NoPtAT  = Count_data(25:30,2);
 OTO_N_Count_NoPtAT  = Count_data(31:36,2);
 
 
 statTitle_3 = 'First sample above threshold '; 
 statTitle_4 = 'No of samples above threshold ';
 
figure(1);
subplot(1,2,1)
 y = [mean(OTM_F_Count_FDBT) mean(OTM_N_Count_FDBT) ;
     mean(OTO_F_Count_FDBT) mean(OTO_F_Count_FDBT)];
 stderror_count_FD = [std(OTM_F_Count_FDBT)/sqrt(length(OTM_F_Count_FDBT)) std(OTM_N_Count_FDBT)/sqrt(length(OTM_N_Count_FDBT))
                      std(OTM_N_Count_FDBT)/sqrt(length(OTM_N_Count_FDBT)) std(OTO_N_Count_FDBT)/sqrt(length(OTO_N_Count_FDBT))];
 
   bar_handle =barwitherr(stderror_count_FD,y,'group');
  set(bar_handle(1),'FaceColor',[1 0 0])
set(bar_handle(2),'FaceColor',[0 0 1]) 
   ylabel('Time(days) of first sample above threshold','FontSize',12)
  % title(statTitle_3,'FontSize',14)
   ylim([0 20]);
    set(gca,'XTick',[1:2],'FontSize',7);
    set(gca,'xticklabel',{'OTM-Failure OTM-Normal','OTO-Failure OTO-Normal'},'FontSize',10);
    

 
subplot(1,2,2)
 y = [mean(OTM_F_Count_NoPtAT) mean(OTM_N_Count_NoPtAT)  
     mean(OTO_F_Count_NoPtAT) mean(OTO_N_Count_NoPtAT)];
 stderror_count_NT = [std(OTM_F_Count_NoPtAT)/sqrt(length(OTM_F_Count_NoPtAT)) std(OTM_N_Count_NoPtAT)/sqrt(length(OTM_N_Count_NoPtAT)) 
                      std(OTM_N_Count_NoPtAT)/sqrt(length(OTM_N_Count_NoPtAT)) std(OTO_N_Count_NoPtAT)/sqrt(length(OTO_N_Count_NoPtAT))];
 
   bar_handle =barwitherr(stderror_count_NT,y,'group');
   
  set(bar_handle(1),'FaceColor',[1 0 0])
set(bar_handle(2),'FaceColor',[0 0 1]) 
   ylabel('Number of Samples above threshold','FontSize',12)
  % title(statTitle_4,'FontSize',14)
   ylim([0 20]);
    set(gca,'XTick',[1:2],'FontSize',7);
    set(gca,'xticklabel',{'OTM-Failure OTM-Normal','OTO-Failure OTO-Normal'},'FontSize',10);
     
 set(gcf,'color','w'); 
 
 
 % Anova - Analysis of Variance;-
% Test 1 - OTM_F VS OTM_N
% Test 2 = OTO_F Vs OTO_N
% Test 3 = OTM_F Vs OTO_F
% Test 4 = OTM_N Vs OTO_N


figure(4); 
test1_data = readtable('Analysis_count.xlsx','Sheet',2);
test1_d = table2cell(test1_data);
test1_d1 = cell2mat(test1_d(:,2));
test1_d2 = test1_d(:,4);
[p1 table1 stats1] = anova1(test1_d1,test1_d2);
title('Anova- First Day Beyond Threshold: OTM F Vs OTM N','FontSize',12);
 set(gcf,'color','w');

figure(5);
test2_data = readtable('Analysis_count.xlsx','Sheet',3);
test2_d = table2cell(test2_data);
test2_d1 = cell2mat(test2_d(:,2));
test2_d2 = test2_d(:,4);
[p2 table2 stats2] = anova1(test2_d1,test2_d2);
title('Anova- First Day Beyond Threshold: OTO F Vs OTO N','FontSize',12);
 set(gcf,'color','w');
 
 
  figure(6);
test3_data = readtable('Analysis_count.xlsx','Sheet',4);
test3_d = table2cell(test3_data);
test3_d1 = cell2mat(test3_d(:,2));
test3_d2 = test3_d(:,4);
[p3 table3 stats3] = anova1(test3_d1,test3_d2);
title('Anova- First Day Beyond Threshold: OTM F Vs OTO F','FontSize',12);
 set(gcf,'color','w');
 
figure(7);
test4_data = readtable('Analysis_count.xlsx','Sheet',5);
test4_d = table2cell(test4_data);
test4_d1 = cell2mat(test4_d(:,2));
test4_d2 = test4_d(:,4);
[p4 table4 stats4] = anova1(test4_d1,test4_d2);
title('Anova- First Day Beyond Threshold: OTM N Vs OTO N','FontSize',12);
 set(gcf,'color','w');
 
 
 % Number of samples above threshold
 figure(8); 
test1_data = readtable('Analysis_count.xlsx','Sheet',2);
test1_d = table2cell(test1_data);
test1_d1 = cell2mat(test1_d(:,3));
test1_d2 = test1_d(:,4);
[p5 table5 stats5] = anova1(test1_d1,test1_d2);
title('Anova- Number of samples above threshold: OTM F Vs OTM N','FontSize',12);
 set(gcf,'color','w');

figure(9);
test2_data = readtable('Analysis_count.xlsx','Sheet',3);
test2_d = table2cell(test2_data);
test2_d1 = cell2mat(test2_d(:,3));
test2_d2 = test2_d(:,4);
[p6 table6 stats6] = anova1(test2_d1,test2_d2);
title('Anova- Number of samples above threshold: OTO F Vs OTO N','FontSize',12);
 set(gcf,'color','w');
 
 
  figure(10);
test3_data = readtable('Analysis_count.xlsx','Sheet',4);
test3_d = table2cell(test3_data);
test3_d1 = cell2mat(test3_d(:,3));
test3_d2 = test3_d(:,4);
[p7 table7 stats7] = anova1(test3_d1,test3_d2);
title('Anova- Number of samples above threshold: OTM F Vs OTO F','FontSize',12);
 set(gcf,'color','w');
 
figure(11);
test4_data = readtable('Analysis_count.xlsx','Sheet',5);
test4_d = table2cell(test4_data);
test4_d1 = cell2mat(test4_d(:,3));
test4_d2 = test4_d(:,4);
[p8 table8 stats8] = anova1(test4_d1,test4_d2);
title('Anova- Number of samples above threshold: OTM N Vs OTO N','FontSize',12);
 set(gcf,'color','w');
 
% ANOVAN

figure(12);
test5_data = readtable('Analysis_count.xlsx','Sheet',1);
test5_d = table2cell(test5_data);
test5_d1 = cell2mat(test5_d(:,2));
test5_d2 = test5_d(:,4);
test5_d3 = test5_d(:,5);
test5_d4 = test5_d(:,6);
[p9 table9 stats9] = anovan(test5_d1,{test5_d2,test5_d3,test5_d4},'model','interaction','varnames',{'Failure','OTM/OTO','SignalType'});
title('Anova n- Number of samples above threshold ','FontSize',12);
 set(gcf,'color','w');
 
figure(13);
test5_data = readtable('Analysis_count.xlsx','Sheet',1);
test5_d = table2cell(test5_data);
test5_d1 = cell2mat(test5_d(:,3));
test5_d2 = test5_d(:,4);
test5_d3 = test5_d(:,5);
test5_d4 = test5_d(:,6);
[p10 table10 stats10] = anovan(test5_d1,{test5_d2,test5_d3,test5_d4},'model','interaction','varnames',{'Failure','OTM/OTO','SignalType'});
title('Anova n- Number of samples above threshold ','FontSize',12);
 set(gcf,'color','w');
 
     
%    % Saving all the figures into a file   

 %    % Saving all the figures into a file   
  h = get(0,'children');
    for i=1:length(h)
        saveas(h(i), ['figure' num2str(i)], 'fig');
    end 
    daytime = clock;
    savdir = 'C:\Users\INSAV3\Predictive Analytics\Figures\ETFA\';
    s1 = 'Count_plots_final';
     s2= strcat(num2str(daytime(1)),num2str(daytime(2)),num2str(daytime(3)));
    s3= '.fig'
    s = strcat(savdir,s1,'_',s2,s3);
    
  savefig(h,s)
   
     set(0,'DefaultFigureWindowStyle','normal') ;
 
   
   
   
%   