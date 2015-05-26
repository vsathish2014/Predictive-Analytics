clear all;
clc;
% Dock all the charts  as tabs
 set(0,'DefaultFigureWindowStyle','docked')
% Stat plots

  stat_results = readtable('Stat_Results.xlsx','Sheet',1); 
    stat_results = table2cell(stat_results); 
    stat_results = cell2mat(stat_results);
 stat_max = stat_results(1:60,5); 
 stat_qlimit = stat_results(1:60,6); 
 stat_firstpt = stat_results(1:60,7); 
 stat_ptsabove = stat_results(1:60,8); 
 
  
  statTitle_1 = 'Max Q-Residual '; 
   statTitle_2 = '95% Threshold for Q-Residual '; 
    statTitle_3 = 'First sample above threshold '; 
    statTitle_4 = 'No of samples above threshold ';
  
 % irisSpecies = {'Setosa', 'Virginica', 'Versicolor'}; % Use for legend
   figure (1);                                     % Label the top
   subplot(2,1,1)
    bar(stat_max(1:15));
   % Set ticks and tick labels
  % xlabel('Test cases')
   ylabel('Max Q Residual')
   title(statTitle_1)
       set(gca, 'XTick', 1:1:15,'FontSize',7 )
 
   subplot(2,1,2)
    bar(stat_qlimit(1:15));
  
     % xlabel('Test cases')
   ylabel('95% Q-Limit');
    ax = gca;
   title(statTitle_2)  
   ylim([0 10]);
        set(gca,'XTick',[1:15],'FontSize',7);
   
   figure(2)
   subplot(2,1,1)
    bar(stat_firstpt(1:15));  
     % xlabel('Test cases')
   ylabel('First sample above threshold');
    ax = gca;
   title(statTitle_3)  
    ylim([0 20]);
        set(gca,'XTick',[1:15],'FontSize',7); 
        
      subplot(2,1,2)
    bar(stat_ptsabove(1:15));  
     % xlabel('Test cases')
   ylabel('Count');
    ax = gca;
   title(statTitle_4)  
    ylim([0 20]);
        set(gca,'XTick',[1:15],'FontSize',7);      
        
        

    figure (3);                                     % Label the top
   subplot(2,1,1)
    bar(stat_max(16:30));
     set(gca, 'XTick', 1:1:15 ) % Set ticks and tick labels
   % xlabel('Test cases')
   ylabel('Max Q Residual')
   title(statTitle_1)
    set(gca,'XTick',[1:15],'FontSize',7);
    set(gca,'xticklabel',{'16','17','18','19','20','21','22','23','24','25','26','27','28','29','30'}) 
 
   subplot(2,1,2)
    bar(stat_qlimit(16:30));
  
     % xlabel('Test cases')
   ylabel('95% Q-Limit');
    ax = gca;
   title(statTitle_2)  
    ylim([0 10]);
         set(gca,'XTick',[1:15],'FontSize',7);
        set(gca,'xticklabel',{'16','17','18','19','20','21','22','23','24','25','26','27','28','29','30'})  
   
   figure(4)
   subplot(2,1,1)
    bar(stat_firstpt(16:30));  
     % xlabel('Test cases')
   ylabel('First sample above threshold');
    ax = gca;
   title(statTitle_3)  
   ylim([0 20]);
    set(gca,'XTick',[1:15],'FontSize',7); 
         set(gca,'xticklabel',{'16','17','18','19','20','21','22','23','24','25','26','27','28','29','30'}) ;
        
      subplot(2,1,2)
    bar(stat_ptsabove(16:30));  
     % xlabel('Test cases')
   ylabel('Count');
    ax = gca;
   title(statTitle_4)  
   ylim([0 20]);
       set(gca,'XTick',[1:15],'FontSize',7);    
      set(gca,'xticklabel',{'16','17','18','19','20','21','22','23','24','25','26','27','28','29','30'})    
        
        
     figure (5);                                     % Label the top
   subplot(2,1,1)
    bar(stat_max(31:45));
     set(gca, 'XTick', 1:1:15 ) % Set ticks and tick labels
   % xlabel('Test cases')
   ylabel('Max Q Residual')
   title(statTitle_1)
     set(gca,'XTick',[1:15],'FontSize',7);
    set(gca,'xticklabel',{'31','32','33','34','35','36','37','38','39','40','41','42','43','44','45'}) 
 
   subplot(2,1,2)
    bar(stat_qlimit(31:45));
  
     % xlabel('Test cases')
   ylabel('95% Q-Limit');
    ax = gca;
   title(statTitle_2)     
    ylim([0 10]);
   set(gca,'XTick',[1:15],'FontSize',7);
     set(gca,'xticklabel',{'31','32','33','34','35','36','37','38','39','40','41','42','43','44','45'})  
    
   figure(6)
   subplot(2,1,1)
    bar(stat_firstpt(31:45));  
     % xlabel('Test cases')
   ylabel('First sample above threshold');
    ax = gca;
   title(statTitle_3)  
   ylim([0 20]);
       set(gca,'XTick',[1:15],'FontSize',7);
        set(gca,'xticklabel',{'31','32','33','34','35','36','37','38','39','40','41','42','43','44','45'}) 
        
      subplot(2,1,2)
    bar(stat_ptsabove(31:45));  
     % xlabel('Test cases')
   ylabel('Count');
    ax = gca;
   title(statTitle_4)  
    ylim([0 20]);
     set(gca,'XTick',[1:15],'FontSize',7);     
      set(gca,'xticklabel',{'31','32','33','34','35','36','37','38','39','40','41','42','43','44','45'})   
              
  
      
      
   figure (7);                                     % Label the top
   subplot(2,1,1)
    bar(stat_max(46:60));
     set(gca, 'XTick', 1:1:15 ) % Set ticks and tick labels
   % xlabel('Test cases')
   ylabel('Max Q Residual')
   title(statTitle_1)
     set(gca,'XTick',[1:15],'FontSize',7);
      set(gca,'xticklabel',{'46','47','48','49','50','51','52','53','54','55','56','57','58','59','60'})  % Set ticks and tick labels
 
   subplot(2,1,2)
    bar(stat_qlimit(46:60));
  
     % xlabel('Test cases')
   ylabel('95% Q-Limit ');
    ax = gca;
   title(statTitle_2)  
   ylim([0 10]);
     set(gca,'XTick',[1:15],'FontSize',7);
      set(gca,'xticklabel',{'46','47','48','49','50','51','52','53','54','55','56','57','58','59','60'})  % Set ticks and tick labels
   
   figure(8)
   subplot(2,1,1)
    bar(stat_firstpt(46:60));  
     % xlabel('Test cases')
   ylabel('First sample above threshold');
    ax = gca;
   title(statTitle_3)  ;
   ylim([0 20]);
        set(gca,'XTick',[1:15],'FontSize',7);
      set(gca,'xticklabel',{'46','47','48','49','50','51','52','53','54','55','56','57','58','59','60'})  % Set ticks and tick labels
        
      subplot(2,1,2)
    bar(stat_ptsabove(46:60));  
     % xlabel('Test cases')
   ylabel('Count');
    ax = gca;
   title(statTitle_4)  
   ylim([0 20]);
         set(gca,'XTick',[1:15],'FontSize',7);    
      set(gca,'xticklabel',{'46','47','48','49','50','51','52','53','54','55','56','57','58','59','60'})  % Set ticks and tick labels
              
    

        
   % Saving all the figures into a file   
  h = get(0,'children');
    for i=1:length(h)
        saveas(h(i), ['figure' num2str(i)], 'fig');
    end 
    daytime = clock;
    savdir = 'C:\Users\INSAV3\Predictive Analytics\Figures\ETFA\';
    s1 = 'Stat_plots';
     s2= strcat(num2str(daytime(1)),num2str(daytime(2)),num2str(daytime(3)));
    s3= '.fig'
    s = strcat(savdir,s1,'_',s2,s3);
    
  savefig(h,s)
   
     set(0,'DefaultFigureWindowStyle','normal') ;
 
   
   
  