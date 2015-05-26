clear all;
clc;
% Dock all the charts  as tabs
 set(0,'DefaultFigureWindowStyle','docked')
% Analysis Plots

 
 Residual_data = readtable('Analysis.xlsx','Sheet',3); 
 Residual_data = table2cell(Residual_data); 
 Residual_data = cell2mat(Residual_data);
 
 
%OTM_F_Residual = reshape(Residual_data(:,1:12),240,1);
OTM_F_Residual =  Residual_data(:,1:12);
 OTM_N_Residual = Residual_data(:,13:24 );
 OTO_F_Residual =  Residual_data(:,25:30) ;
 OTO_N_Residual = Residual_data(:,31:36) ;
 
 % Mean of residuals
 mean_OTM_F_Res = mean(OTM_F_Residual)';
 mean_OTM_N_Res = mean(OTM_N_Residual)';
 mean_OTO_F_Res = mean(OTO_F_Residual)';
 mean_OTO_N_Res = mean(OTO_N_Residual)';
 mean_Res = cat(1,mean_OTM_F_Res,mean_OTM_N_Res,mean_OTO_F_Res,mean_OTO_N_Res);
 
 % Max of residuals
  max_OTM_F_Res = max(OTM_F_Residual)';
 max_OTM_N_Res = max(OTM_N_Residual)';
 max_OTO_F_Res = max(OTO_F_Residual)';
 max_OTO_N_Res = max(OTO_N_Residual)';
 max_Res = cat(1,max_OTM_F_Res,max_OTM_N_Res,max_OTO_F_Res,max_OTO_N_Res);
 
 
 
 
 OTM_F_Residual_r = reshape(Residual_data(:,1:12),240,1);
 OTM_N_Residual_r = reshape(Residual_data(:,13:24 ),240,1);
 OTO_F_Residual_r = reshape(Residual_data(:,25:30),120,1) ;
 OTO_N_Residual_r = reshape(Residual_data(:,31:36),120,1) ;
 
 statTitle_3 = 'Q-Residual statistics '; 
  
 
figure(1);
subplot(1,2,1)
 y = [mean(mean(OTM_F_Residual)) mean(mean(OTM_N_Residual)) 
     mean(mean(OTO_F_Residual)) mean(mean(OTO_N_Residual))];
     stderror_mean = [std(mean(OTM_F_Residual))/sqrt(length(mean(OTM_F_Residual))) std(mean(OTM_N_Residual))/sqrt(length(mean(OTM_N_Residual))) 
                  std(mean(OTO_F_Residual))/sqrt(length(mean(OTO_F_Residual)))  std(mean(OTO_N_Residual))/sqrt(length(mean(OTO_N_Residual)))];
  % bar_handle =bar(y,'group');
  bar_handle = barwitherr(stderror_mean,y,'group');
    ylim([0 4*10^5]);
  set(bar_handle(1),'FaceColor',[1 0 0])
set(bar_handle(2),'FaceColor',[0 0 1]) 
   ylabel('Average Q Residual','FontSize',12)
  % title(statTitle_3,'FontSize',14)
    set(gca,'XTick',[1:2],'FontSize',7);
    set(gca,'xticklabel',{'OTM-Failure OTM-Normal','OTO-Failure OTO-Normal'},'FontSize',10);
    set(gcf,'color','w');
  
  subplot(1,2,2)
y = [mean(max(OTM_F_Residual)) mean(max(OTM_N_Residual)) 
     mean(max(OTO_F_Residual)) mean(max(OTO_N_Residual))];
stderror_max = [ std(max(OTM_F_Residual))/sqrt(length(max(OTM_F_Residual)))  std(max(OTM_N_Residual))/sqrt(length(max(OTM_N_Residual)))
                 std(max(OTO_F_Residual))/sqrt(length(max(OTO_F_Residual)))  std(max(OTO_N_Residual))/sqrt(length(max(OTO_N_Residual)))]; 
 
   bar_handle =barwitherr(stderror_max,y,'group');
  set(bar_handle(1),'FaceColor',[1 0 0])
set(bar_handle(2),'FaceColor',[0 0 1]) 
   ylabel('Maximum Q Residual','FontSize',12)
  % title(statTitle_3,'FontSize',14)
   %ylim([0 2.5*10^5]);
    set(gca,'XTick',[1:2],'FontSize',7);
    set(gca,'xticklabel',{'OTM-Failure OTM-Normal','OTO-Failure OTO-Normal'},'FontSize',10);   
  set(gcf,'color','w');


  
 figure(2);
%subplot(1,2,1)
 y = [mean(var(OTM_F_Residual)) mean(var(OTM_N_Residual)) 
     mean(var(OTO_F_Residual)) mean(var(OTO_N_Residual))];
     stderror_var = [std(var(OTM_F_Residual))/sqrt(length(var(OTM_F_Residual))) std(var(OTM_N_Residual))/sqrt(length(var(OTM_N_Residual))) 
                  std(var(OTO_F_Residual))/sqrt(length(var(OTO_F_Residual)))  std(var(OTO_N_Residual))/sqrt(length(var(OTO_N_Residual)))];
  % bar_handle =bar(y,'group');
  bar_handle = barwitherr(stderror_var,y,'group');
 %   ylim([0 4*10^5]);
  set(bar_handle(1),'FaceColor',[1 0 0])
set(bar_handle(2),'FaceColor',[0 0 1]) 
   ylabel('Variance Q Residual','FontSize',12)
  % title(statTitle_3,'FontSize',14)
    set(gca,'XTick',[1:2],'FontSize',7);
    set(gca,'xticklabel',{'OTM-Failure OTM-Normal','OTO-Failure OTO-Normal'},'FontSize',10);
    set(gcf,'color','w'); 
  
figure(3);
%subplot(1,2,1)
 y = [mean(std(OTM_F_Residual)) mean(std(OTM_N_Residual)) 
     mean(std(OTO_F_Residual)) mean(std(OTO_N_Residual))];
     stderror_std = [std(std(OTM_F_Residual))/sqrt(length(std(OTM_F_Residual))) std(std(OTM_N_Residual))/sqrt(length(std(OTM_N_Residual))) 
                  std(std(OTO_F_Residual))/sqrt(length(std(OTO_F_Residual)))  std(std(OTO_N_Residual))/sqrt(length(std(OTO_N_Residual)))];
  % bar_handle =bar(y,'group');
  bar_handle = barwitherr(stderror_std,y,'group');
 %   ylim([0 4*10^5]);
  set(bar_handle(1),'FaceColor',[1 0 0])
set(bar_handle(2),'FaceColor',[0 0 1]) 
   ylabel('Std Deviation Q Residual','FontSize',12)
  % title(statTitle_3,'FontSize',14)
    set(gca,'XTick',[1:2],'FontSize',7);
    set(gca,'xticklabel',{'OTM-Failure OTM-Normal','OTO-Failure OTO-Normal'},'FontSize',10);
    set(gcf,'color','w'); 
    
    
  
% Anova - Analysis of Variance;-
% mtest 1 - OTM_F VS OTM_N
% mtest 2 = OTO_F Vs OTO_N
% mtest 3 = OTM_F Vs OTO_F
% mtest 4 = OTM_N Vs OTO_N

% Analysis of Variance - Mean
test_data = readtable('Analysis.xlsx','Sheet',9);
% test 1 - OTM_F VS OTM_N
test_d = table2cell(test_data);
test1_d1 = cell2mat(test_d(1:24,1));
test1_d2 = test_d(1:24,2);
anova_test1 = anova1(test1_d1,test1_d2);
title('Anova- OTM F Vs OTM N','FontSize',12);
 set(gcf,'color','w');
 
 % test 2 = OTO_F Vs OTO_N
 
test2_d1 = cell2mat(test_d(25:36,1));
test2_d2 = test_d(25:36,2);
anova_test2 = anova1(test2_d1,test2_d2);
title('Anova- OTO F Vs OTO N','FontSize',12);
 set(gcf,'color','w');
 
% test 3 = OTM_F Vs OTO_F

test3_d1 = cat(1,cell2mat(test_d(1:12,1)),cell2mat(test_d(25:30,1)));
test3_d2 = cat(1,test_d(1:12,3), test_d(25:30,3));
anova_test3 = anova1(test3_d1,test3_d2);
title('Anova- OTM F Vs OTO F','FontSize',12);
 set(gcf,'color','w');


% test 4 = OTM_N Vs OTO_N 
 test4_d1 = cat(1,cell2mat(test_d(13:24,1)),cell2mat(test_d(31:36,1)));
test4_d2 = cat(1,test_d(13:24,3), test_d(31:36,3));
anova_test4 = anova1(test4_d1,test4_d2);
title('Anova- OTM N Vs OTO N ','FontSize',12);
 set(gcf,'color','w');
 
 
 
% Analysis of Variance - Max Residual
mtest_data = readtable('Analysis.xlsx','Sheet',10);
% mtest 1 - OTM_F VS OTM_N
mtest_d = table2cell(mtest_data);
mtest1_d1 = cell2mat(mtest_d(1:24,1));
mtest1_d2 = mtest_d(1:24,2);
anova_mtest1 = anova1(mtest1_d1,mtest1_d2);
title('Anova Max Residual- OTM F Vs OTM N','FontSize',12);
 set(gcf,'color','w');
 
 % mtest 2 = OTO_F Vs OTO_N
 
mtest2_d1 = cell2mat(mtest_d(25:36,1));
mtest2_d2 = mtest_d(25:36,2);
anova_mtest2 = anova1(mtest2_d1,mtest2_d2);
title('Anova Max Residual- OTO F Vs OTO N','FontSize',12);
 set(gcf,'color','w');
 
% mtest 3 = OTM_F Vs OTO_F

mtest3_d1 = cat(1,cell2mat(mtest_d(1:12,1)),cell2mat(mtest_d(25:30,1)));
mtest3_d2 = cat(1,mtest_d(1:12,3), mtest_d(25:30,3));
anova_mtest3 = anova1(mtest3_d1,mtest3_d2);
title('Anova Max Residual: OTM F Vs OTO F','FontSize',12);
 set(gcf,'color','w');


% mtest 4 = OTM_N Vs OTO_N 
 mtest4_d1 = cat(1,cell2mat(mtest_d(13:24,1)),cell2mat(mtest_d(31:36,1)));
mtest4_d2 = cat(1,mtest_d(13:24,3), mtest_d(31:36,3));
anova_mtest4 = anova1(mtest4_d1,mtest4_d2);
title('Anova Max Residual: OTM N Vs OTO N ','FontSize',12);
 set(gcf,'color','w');
  
 
% figure(4)
% mtest2_data = readtable('Analysis.xlsx','Sheet',5);
% mtest2_d = table2cell(mtest2_data);
% mtest2_d1 = cell2mat(mtest2_d(:,1));
% mtest2_d2 = mtest2_d(:,2);
% anova_mtest2 = anova1(mtest2_d1,mtest2_d2);
% title('Anova- OTO F Vs OTO N','FontSize',12);
%  set(gcf,'color','w'); 
% 
% figure(5)
% mtest3_data = readtable('Analysis.xlsx','Sheet',6);
% mtest3_d = table2cell(mtest3_data);
% mtest3_d1 = cell2mat(mtest3_d(:,1));
% mtest3_d2 = mtest3_d(:,2);
% anova_mtest3 = anova1(mtest3_d1,mtest3_d2);
% title('Anova- OTM F Vs OTO F','FontSize',12);
%  set(gcf,'color','w'); 
% 
% 
% figure(6)
% mtest4_data = readtable('Analysis.xlsx','Sheet',7);
% mtest4_d = table2cell(mtest4_data);
% mtest4_d1 = cell2mat(mtest4_d(:,1));
% mtest4_d2 = mtest4_d(:,2);
% anova_mtest4 = anova1(mtest4_d1,mtest4_d2);
% title('Anova- OTM N Vs OTO N','FontSize',12);
%  set(gcf,'color','w'); 
%  
% % Anoval N
% figure(6)
% mtest5_data = readtable('Analysis.xlsx','Sheet',8);
% mtest5_d = table2cell(mtest5_data);
% mtest5_d1 = cell2mat(mtest5_d(:,3));
% mtest5_d2 = mtest5_d(:,4);
% mtest5_d3 = mtest5_d(:,5);
% mtest5_d4 = mtest5_d(:,6);
% [p10 table10 stats10] = anovan(mtest5_d1,{mtest5_d2,mtest5_d3,mtest5_d4},'model','interaction','varnames',{'Failure','OTM/OTO','SignalType'});
% title('Anova- OTM N Vs OTO N','FontSize',12);
%  set(gcf,'color','w'); 
%  
%          
%    % Saving all the figures into a file   
  h = get(0,'children');
    for i=1:length(h)
        saveas(h(i), ['figure' num2str(i)], 'fig');
    end 
    daytime = clock;
    savdir = 'C:\Users\INSAV3\Predictive Analytics\Figures\ETFA\';
    s1 = 'Residual_plots_final';
     s2= strcat(num2str(daytime(1)),num2str(daytime(2)),num2str(daytime(3)));
    s3= '.fig'
    s = strcat(savdir,s1,'_',s2,s3);
    
  savefig(h,s)
   
     set(0,'DefaultFigureWindowStyle','normal') ;
 
% %    
% %    
% %   