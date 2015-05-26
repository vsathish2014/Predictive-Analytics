clear all;
clc;
% Dock all the charts  as tabs
 set(0,'DefaultFigureWindowStyle','docked')
% Analysis Plots

 Count_data = readtable('Analysis.xlsx','Sheet',2); 
    Count_data = table2cell(Count_data(:,2:3)); 
    Count_data = cell2mat(Count_data);

 Residual_data = readtable('Analysis.xlsx','Sheet',3); 
    Residual_data = table2cell(Residual_data); 
    Residual_data = cell2mat(Residual_data);
 
 OTM_F_Count_FDBT  = Count_data(1:12,1);
 OTM_N_Count_FDBT  = Count_data(13:24,1);
 OTO_F_Count_FDBT  = Count_data(25:30,1);
 OTO_F_Count_FDBT  = Count_data(31:36,1);
 
 OTM_F_Count_NoPtAT  = Count_data(1:12,2);
 OTM_N_Count_NoPtAT  = Count_data(13:24,2);
 OTO_F_Count_NoPtAT  = Count_data(25:30,2);
 OTO_N_Count_NoPtAT  = Count_data(31:36,2);
 
 
OTM_F_Residual = reshape(Residual_data(:,1:12),240,1);
 OTM_N_Residual =reshape(Residual_data(:,13:24),240,1);
 OTO_F_Residual = reshape(Residual_data(:,25:30),120,1);
 OTO_N_Residual = reshape(Residual_data(:,31:36),120,1);
 statTitle_3 = 'First sample above threshold '; 
 statTitle_4 = 'No of samples above threshold ';
 
figure(1);
subplot(2,2,1)
 y = [mean(OTM_F_Count_FDBT) mean(OTM_N_Count_FDBT) ;
     mean(OTO_F_Count_FDBT) mean(OTO_F_Count_FDBT)];
   bar_handle =bar(y,'group');
  set(bar_handle(1),'FaceColor',[1 0 0])
set(bar_handle(2),'FaceColor',[0 0 1]) 
   ylabel('Average','FontSize',12)
   title(statTitle_3,'FontSize',14)
    set(gca,'XTick',[1:2],'FontSize',7);
    set(gca,'xticklabel',{'OTM-Failure OTM-Normal','OTO-Failure OTO-Normal'},'FontSize',10);
 subplot(2,2,2)
 y = [std(OTM_F_Count_FDBT) std(OTM_N_Count_FDBT) ;
     std(OTO_F_Count_FDBT) std(OTO_F_Count_FDBT)];
   bar_handle =bar(y,'group');
  set(bar_handle(1),'FaceColor',[1 0 0])
set(bar_handle(2),'FaceColor',[0 0 1]) 
   ylabel('Std devation ','FontSize',12)
   title(statTitle_3,'FontSize',14)
    set(gca,'XTick',[1:2],'FontSize',7);
    set(gca,'xticklabel',{'OTM-Failure OTM-Normal','OTO-Failure OTO-Normal'},'FontSize',10);
 
  subplot(2,2,3)
 y = [max(OTM_F_Count_FDBT) max(OTM_N_Count_FDBT) ;
     max(OTO_F_Count_FDBT) max(OTO_F_Count_FDBT)];
   bar_handle =bar(y,'group');
  set(bar_handle(1),'FaceColor',[1 0 0])
set(bar_handle(2),'FaceColor',[0 0 1]) 
   ylabel('Maximum','FontSize',12)
   title(statTitle_3,'FontSize',14)
    set(gca,'XTick',[1:2],'FontSize',7);
    set(gca,'xticklabel',{'OTM-Failure OTM-Normal','OTO-Failure OTO-Normal'},'FontSize',10);   
 
  
  subplot(2,2,4)
 y = [min(OTM_F_Count_FDBT) min(OTM_N_Count_FDBT) ;
     min(OTO_F_Count_FDBT) min(OTO_F_Count_FDBT)];
   bar_handle =bar(y,'group');
  set(bar_handle(1),'FaceColor',[1 0 0])
set(bar_handle(2),'FaceColor',[0 0 1]) 
 ylim([0 12]);
   ylabel('Minimum','FontSize',12)
   title(statTitle_3,'FontSize',14)
    set(gca,'XTick',[1:2],'FontSize',7);
    set(gca,'xticklabel',{'OTM-Failure OTM-Normal','OTO-Failure OTO-Normal'},'FontSize',10); 
 
%%%%%
figure(2);
subplot(2,2,1)
 y = [mean(OTM_F_Count_NoPtAT) mean(OTM_N_Count_NoPtAT) ;
     mean(OTO_F_Count_NoPtAT) mean(OTO_N_Count_NoPtAT)];
   bar_handle =bar(y,'group');
  set(bar_handle(1),'FaceColor',[1 0 0])
set(bar_handle(2),'FaceColor',[0 0 1]) 
   ylabel('Average','FontSize',12)
   title(statTitle_4,'FontSize',14)
    set(gca,'XTick',[1:2],'FontSize',7);
    set(gca,'xticklabel',{'OTM-Failure OTM-Normal','OTO-Failure OTO-Normal'},'FontSize',10);
 subplot(2,2,2)
 y = [std(OTM_F_Count_NoPtAT) std(OTM_N_Count_NoPtAT) ;
     std(OTO_F_Count_NoPtAT) std(OTO_N_Count_NoPtAT)];
   bar_handle =bar(y,'group');
  set(bar_handle(1),'FaceColor',[1 0 0])
set(bar_handle(2),'FaceColor',[0 0 1]) 
   ylabel('Std devation ','FontSize',12)
   title(statTitle_4,'FontSize',14)
    set(gca,'XTick',[1:2],'FontSize',7);
    set(gca,'xticklabel',{'OTM-Failure OTM-Normal','OTO-Failure OTO-Normal'},'FontSize',10);
 
  subplot(2,2,3)
 y = [max(OTM_F_Count_NoPtAT) max(OTM_N_Count_NoPtAT) ;
     max(OTO_F_Count_NoPtAT) max(OTO_N_Count_NoPtAT)];
   bar_handle =bar(y,'group');
  set(bar_handle(1),'FaceColor',[1 0 0])
set(bar_handle(2),'FaceColor',[0 0 1]) 
   ylabel('Maximum','FontSize',12)
   title(statTitle_3,'FontSize',14)
    set(gca,'XTick',[1:2],'FontSize',7);
    set(gca,'xticklabel',{'OTM-Failure OTM-Normal','OTO-Failure OTO-Normal'},'FontSize',10);   
 
  
  subplot(2,2,4)
 y = [min(OTM_F_Count_NoPtAT) min(OTM_N_Count_NoPtAT) ;
     min(OTO_F_Count_NoPtAT) min(OTO_N_Count_NoPtAT)];
   bar_handle =bar(y,'group');
  set(bar_handle(1),'FaceColor',[1 0 0])
set(bar_handle(2),'FaceColor',[0 0 1]) 
 ylim([0 12]);
   ylabel('Minimum','FontSize',12)
   title(statTitle_3,'FontSize',14)
    set(gca,'XTick',[1:2],'FontSize',7);
    set(gca,'xticklabel',{'OTM-Failure OTM-Normal','OTO-Failure OTO-Normal'},'FontSize',10); 
 
 
 
%   
%   statTitle_1 = 'Max Q-Residual '; 
%    statTitle_2 = '95% Threshold for Q-Residual '; 
%     statTitle_3 = 'First sample above threshold '; 
%     statTitle_4 = 'No of samples above threshold ';
%   
%  % irisSpecies = {'Setosa', 'Virginica', 'Versicolor'}; % Use for legend
%    figure (1);                                     % Label the top
%    subplot(2,1,1)
%     bar(stat_max(1:15));
%    % Set ticks and tick labels
%   % xlabel('Test cases')
%    ylabel('Max Q Residual')
%    title(statTitle_1)
%        set(gca, 'XTick', 1:1:15,'FontSize',7 )
%  
%    subplot(2,1,2)
%     bar(stat_qlimit(1:15));
%   
%      % xlabel('Test cases')
%    ylabel('95% Q-Limit');
%     ax = gca;
%    title(statTitle_2)  
%    ylim([0 10]);
%         set(gca,'XTick',[1:15],'FontSize',7);
%    
%    figure(2)
%    subplot(2,1,1)
%     bar(stat_firstpt(1:15));  
%      % xlabel('Test cases')
%    ylabel('First sample above threshold');
%     ax = gca;
%    title(statTitle_3)  
%     ylim([0 20]);
%         set(gca,'XTick',[1:15],'FontSize',7); 
%         
%       subplot(2,1,2)
%     bar(stat_ptsabove(1:15));  
%      % xlabel('Test cases')
%    ylabel('Count');
%     ax = gca;
%    title(statTitle_4)  
%     ylim([0 20]);
%         set(gca,'XTick',[1:15],'FontSize',7);      
%         
%         
% 
%     figure (3);                                     % Label the top
%    subplot(2,1,1)
%     bar(stat_max(16:30));
%      set(gca, 'XTick', 1:1:15 ) % Set ticks and tick labels
%    % xlabel('Test cases')
%    ylabel('Max Q Residual')
%    title(statTitle_1)
%     set(gca,'XTick',[1:15],'FontSize',7);
%     set(gca,'xticklabel',{'16','17','18','19','20','21','22','23','24','25','26','27','28','29','30'}) 
%  
%    subplot(2,1,2)
%     bar(stat_qlimit(16:30));
%   
%      % xlabel('Test cases')
%    ylabel('95% Q-Limit');
%     ax = gca;
%    title(statTitle_2)  
%     ylim([0 10]);
%          set(gca,'XTick',[1:15],'FontSize',7);
%         set(gca,'xticklabel',{'16','17','18','19','20','21','22','23','24','25','26','27','28','29','30'})  
%    
%    figure(4)
%    subplot(2,1,1)
%     bar(stat_firstpt(16:30));  
%      % xlabel('Test cases')
%    ylabel('First sample above threshold');
%     ax = gca;
%    title(statTitle_3)  
%    ylim([0 20]);
%     set(gca,'XTick',[1:15],'FontSize',7); 
%          set(gca,'xticklabel',{'16','17','18','19','20','21','22','23','24','25','26','27','28','29','30'}) ;
%         
%       subplot(2,1,2)
%     bar(stat_ptsabove(16:30));  
%      % xlabel('Test cases')
%    ylabel('Count');
%     ax = gca;
%    title(statTitle_4)  
%    ylim([0 20]);
%        set(gca,'XTick',[1:15],'FontSize',7);    
%       set(gca,'xticklabel',{'16','17','18','19','20','21','22','23','24','25','26','27','28','29','30'})    
%         
%         
%      figure (5);                                     % Label the top
%    subplot(2,1,1)
%     bar(stat_max(31:45));
%      set(gca, 'XTick', 1:1:15 ) % Set ticks and tick labels
%    % xlabel('Test cases')
%    ylabel('Max Q Residual')
%    title(statTitle_1)
%      set(gca,'XTick',[1:15],'FontSize',7);
%     set(gca,'xticklabel',{'31','32','33','34','35','36','37','38','39','40','41','42','43','44','45'}) 
%  
%    subplot(2,1,2)
%     bar(stat_qlimit(31:45));
%   
%      % xlabel('Test cases')
%    ylabel('95% Q-Limit');
%     ax = gca;
%    title(statTitle_2)     
%     ylim([0 10]);
%    set(gca,'XTick',[1:15],'FontSize',7);
%      set(gca,'xticklabel',{'31','32','33','34','35','36','37','38','39','40','41','42','43','44','45'})  
%     
%    figure(6)
%    subplot(2,1,1)
%     bar(stat_firstpt(31:45));  
%      % xlabel('Test cases')
%    ylabel('First sample above threshold');
%     ax = gca;
%    title(statTitle_3)  
%    ylim([0 20]);
%        set(gca,'XTick',[1:15],'FontSize',7);
%         set(gca,'xticklabel',{'31','32','33','34','35','36','37','38','39','40','41','42','43','44','45'}) 
%         
%       subplot(2,1,2)
%     bar(stat_ptsabove(31:45));  
%      % xlabel('Test cases')
%    ylabel('Count');
%     ax = gca;
%    title(statTitle_4)  
%     ylim([0 20]);
%      set(gca,'XTick',[1:15],'FontSize',7);     
%       set(gca,'xticklabel',{'31','32','33','34','35','36','37','38','39','40','41','42','43','44','45'})   
%               
%   
%       
%       
%    figure (7);                                     % Label the top
%    subplot(2,1,1)
%     bar(stat_max(46:60));
%      set(gca, 'XTick', 1:1:15 ) % Set ticks and tick labels
%    % xlabel('Test cases')
%    ylabel('Max Q Residual')
%    title(statTitle_1)
%      set(gca,'XTick',[1:15],'FontSize',7);
%       set(gca,'xticklabel',{'46','47','48','49','50','51','52','53','54','55','56','57','58','59','60'})  % Set ticks and tick labels
%  
%    subplot(2,1,2)
%     bar(stat_qlimit(46:60));
%   
%      % xlabel('Test cases')
%    ylabel('95% Q-Limit ');
%     ax = gca;
%    title(statTitle_2)  
%    ylim([0 10]);
%      set(gca,'XTick',[1:15],'FontSize',7);
%       set(gca,'xticklabel',{'46','47','48','49','50','51','52','53','54','55','56','57','58','59','60'})  % Set ticks and tick labels
%    
%    figure(8)
%    subplot(2,1,1)
%     bar(stat_firstpt(46:60));  
%      % xlabel('Test cases')
%    ylabel('First sample above threshold');
%     ax = gca;
%    title(statTitle_3)  ;
%    ylim([0 20]);
%         set(gca,'XTick',[1:15],'FontSize',7);
%       set(gca,'xticklabel',{'46','47','48','49','50','51','52','53','54','55','56','57','58','59','60'})  % Set ticks and tick labels
%         
%       subplot(2,1,2)
%     bar(stat_ptsabove(46:60));  
%      % xlabel('Test cases')
%    ylabel('Count');
%     ax = gca;
%    title(statTitle_4)  
%    ylim([0 20]);
%          set(gca,'XTick',[1:15],'FontSize',7);    
%       set(gca,'xticklabel',{'46','47','48','49','50','51','52','53','54','55','56','57','58','59','60'})  % Set ticks and tick labels
%               
%     
% 
%         
%    % Saving all the figures into a file   
%   h = get(0,'children');
%     for i=1:length(h)
%         saveas(h(i), ['figure' num2str(i)], 'fig');
%     end 
%     daytime = clock;
%     savdir = 'C:\Users\INSAV3\Predictive Analytics\Figures\ETFA\';
%     s1 = 'Stat_plots';
%      s2= strcat(num2str(daytime(1)),num2str(daytime(2)),num2str(daytime(3)));
%     s3= '.fig'
%     s = strcat(savdir,s1,'_',s2,s3);
%     
%   savefig(h,s)
%    
%      set(0,'DefaultFigureWindowStyle','normal') ;
%  
%    
%    
%   