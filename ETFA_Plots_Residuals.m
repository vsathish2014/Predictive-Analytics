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
 
 OTM_F_Residual_r = reshape(Residual_data(:,1:12),240,1);
 OTM_N_Residual_r = reshape(Residual_data(:,13:24 ),240,1);
 OTO_F_Residual_r = reshape(Residual_data(:,25:30),120,1) ;
 OTO_N_Residual_r = reshape(Residual_data(:,31:36),120,1) ;
 
 statTitle_3 = 'Q-Residual statistics '; 
  
 
figure(1);
subplot(2,2,1)
 y = [mean(mean(OTM_F_Residual)) mean(mean(OTM_N_Residual)) ;
     mean(mean(OTO_F_Residual)) mean(mean(OTO_N_Residual))];
   bar_handle =bar(y,'group');
   ylim([0 2.5*10^5]);
  set(bar_handle(1),'FaceColor',[1 0 0])
set(bar_handle(2),'FaceColor',[0 0 1]) 
   ylabel('Average','FontSize',12)
   title(statTitle_3,'FontSize',14)
    set(gca,'XTick',[1:2],'FontSize',7);
    set(gca,'xticklabel',{'OTM-Failure OTM-Normal','OTO-Failure OTO-Normal'},'FontSize',10);
 subplot(2,2,2)
y = [mean(std(OTM_F_Residual)) mean(std(OTM_N_Residual)) 
     mean(std(OTO_F_Residual)) mean(std(OTO_N_Residual))];
   bar_handle =bar(y,'group');
  set(bar_handle(1),'FaceColor',[1 0 0])
set(bar_handle(2),'FaceColor',[0 0 1]) 
   ylabel('Std devation ','FontSize',12)
   title(statTitle_3,'FontSize',14)
   ylim([0 2.5*10^5]);
    set(gca,'XTick',[1:2],'FontSize',7);
    set(gca,'xticklabel',{'OTM-Failure OTM-Normal','OTO-Failure OTO-Normal'},'FontSize',10);
 
  subplot(2,2,3)
y = [mean(max(OTM_F_Residual)) mean(max(OTM_N_Residual)) 
     mean(max(OTO_F_Residual)) mean(max(OTO_N_Residual))];
   bar_handle =bar(y,'group');
  set(bar_handle(1),'FaceColor',[1 0 0])
set(bar_handle(2),'FaceColor',[0 0 1]) 
   ylabel('Maximum','FontSize',12)
   title(statTitle_3,'FontSize',14)
   ylim([0 2.5*10^5]);
    set(gca,'XTick',[1:2],'FontSize',7);
    set(gca,'xticklabel',{'OTM-Failure OTM-Normal','OTO-Failure OTO-Normal'},'FontSize',10);   
 
  
  subplot(2,2,4)
y = [mean(min(OTM_F_Residual)) mean(min(OTM_N_Residual)) 
     mean(min(OTO_F_Residual)) mean(min(OTO_N_Residual))];
   bar_handle =bar(y,'group');
  set(bar_handle(1),'FaceColor',[1 0 0])
set(bar_handle(2),'FaceColor',[0 0 1]) 
 
ylim([0 2.5*10^5]);
   ylabel('Minimum','FontSize',12)
   title(statTitle_3,'FontSize',14)
    set(gca,'XTick',[1:2],'FontSize',7);
    set(gca,'xticklabel',{'OTM-Failure OTM-Normal','OTO-Failure OTO-Normal'},'FontSize',10); 
  set(gcf,'color','w'); 
  
% Std error plot
figure (2);
subplot(2,1,1);
mean_mean = cat(2,mean(mean(OTM_F_Residual)),mean(mean(OTM_N_Residual)),mean(mean(OTO_F_Residual)),mean(mean(OTO_N_Residual)))
stderror_mean = cat(2,std(mean(OTM_F_Residual))/sqrt(length(mean(OTM_F_Residual))),...
                      std(mean(OTM_N_Residual))/sqrt(length(mean(OTM_N_Residual))),...
                      std(mean(OTO_F_Residual))/sqrt(length(mean(OTO_F_Residual))),...
                      std(mean(OTO_N_Residual))/sqrt(length(mean(OTO_N_Residual))))

  errorbar(mean_mean,stderror_mean,'rx'); 
  ylim([0 4*10^5]);
  ylabel('Q-Residual','FontSize',10);
   title('Std Error Plot - Avg Q Residuals','FontSize', 12);
    set(gca,'XTick',[1:4],'FontSize',7);
  set(gca,'xticklabel',{'OTM-Failure', 'OTM-Normal','OTO-Failure', 'OTO-Normal'},'FontSize',10);

 
 subplot(2,1,2);
mean_max = cat(2,mean(max(OTM_F_Residual)),mean(max(OTM_N_Residual)),mean(max(OTO_F_Residual)),...
                 mean(max(OTO_N_Residual)))
stderror_max = cat(2,std(max(OTM_F_Residual))/sqrt(length(max(OTM_F_Residual))),...
                      std(max(OTM_N_Residual))/sqrt(length(max(OTM_N_Residual))),...
                      std(max(OTO_F_Residual))/sqrt(length(max(OTO_F_Residual))),...
                      std(max(OTO_N_Residual))/sqrt(length(max(OTO_N_Residual))))

  errorbar(mean_max,stderror_max,'rx'); 
   ylabel('Q-Residual','FontSize',10);
   title('Std Error Plot - Max Q Residuals','FontSize', 12);
  set(gca,'XTick',[1:4],'FontSize',7);
  set(gca,'xticklabel',{'OTM-Failure', 'OTM-Normal','OTO-Failure', 'OTO-Normal'},'FontSize',10);
   set(gcf,'color','w'); 
% Anova - Analysis of Variance;-
% Test 1 - OTM_F VS OTM_N
% Test 2 = OTO_F Vs OTO_N
% Test 3 = OTM_F Vs OTO_F
% Test 4 = OTM_N Vs OTO_N

figure(3);
test1_data = readtable('Analysis.xlsx','Sheet',4);
test1_d = table2cell(test1_data);
test1_d1 = cell2mat(test1_d(:,1));
test1_d2 = test1_d(:,2);
anova_test1 = anova1(test1_d1,test1_d2);
title('Anova- OTM F Vs OTM N','FontSize',12);
 set(gcf,'color','w');
 
figure(4)
test2_data = readtable('Analysis.xlsx','Sheet',5);
test2_d = table2cell(test2_data);
test2_d1 = cell2mat(test2_d(:,1));
test2_d2 = test2_d(:,2);
anova_test2 = anova1(test2_d1,test2_d2);
title('Anova- OTO F Vs OTO N','FontSize',12);
 set(gcf,'color','w'); 

figure(5)
test3_data = readtable('Analysis.xlsx','Sheet',6);
test3_d = table2cell(test3_data);
test3_d1 = cell2mat(test3_d(:,1));
test3_d2 = test3_d(:,2);
anova_test3 = anova1(test3_d1,test3_d2);
title('Anova- OTM F Vs OTO F','FontSize',12);
 set(gcf,'color','w'); 


figure(6)
test4_data = readtable('Analysis.xlsx','Sheet',7);
test4_d = table2cell(test4_data);
test4_d1 = cell2mat(test4_d(:,1));
test4_d2 = test4_d(:,2);
anova_test4 = anova1(test4_d1,test4_d2);
title('Anova- OTM N Vs OTO N','FontSize',12);
 set(gcf,'color','w'); 
 
% Anoval N
figure(6)
test5_data = readtable('Analysis.xlsx','Sheet',8);
test5_d = table2cell(test5_data);
test5_d1 = cell2mat(test5_d(:,3));
test5_d2 = test5_d(:,4);
test5_d3 = test5_d(:,5);
test5_d4 = test5_d(:,6);
[p10 table10 stats10] = anovan(test5_d1,{test5_d2,test5_d3,test5_d4},'model','interaction','varnames',{'Failure','OTM/OTO','SignalType'});
title('Anova- OTM N Vs OTO N','FontSize',12);
 set(gcf,'color','w'); 
 
         
%    % Saving all the figures into a file   
  h = get(0,'children');
    for i=1:length(h)
        saveas(h(i), ['figure' num2str(i)], 'fig');
    end 
    daytime = clock;
    savdir = 'C:\Users\INSAV3\Predictive Analytics\Figures\ETFA\';
    s1 = 'Residual_plots';
     s2= strcat(num2str(daytime(1)),num2str(daytime(2)),num2str(daytime(3)));
    s3= '.fig'
    s = strcat(savdir,s1,'_',s2,s3);
    
  savefig(h,s)
   
     set(0,'DefaultFigureWindowStyle','normal') ;
 
%    
%    
%   