clear all;
clc;
% Error Plots

  pred_results = readtable('Pred_residuals.xlsx','Sheet',1); 
    pred_results = table2cell(pred_results); 
    pred_results = cell2mat(pred_results);
 pred_results_y = pred_results(1:20,:);   
 pred_results_y_r = pred_results(1:20,:);  
 pred_results_mean = mean(pred_results_y);
 pred_results_std = std(pred_results_y);
 
%  colRemoved = [4	7	11	14	18	21	25	28	32	35	39	42	46	49	53	56	60	63	67	70	74	77	81	84];
%  pred_results_mean_r = pred_results_mean;
%  pred_results_mean_r(:,colRemoved) =[];
%  pred_results_std_r = pred_results_std;
%   pred_results_std_r(:,colRemoved) =[];
 
  predTitle_1 = 'Comparison of test cases - Training data from Rob1 only(6,12,6 diff signals)'; 
   predTitle_2 = 'Comparison of test cases - Training data from all robots(6,12,6 diff signals)'; 
 % irisSpecies = {'Setosa', 'Virginica', 'Versicolor'}; % Use for legend
   figure (1);                                     % Label the top
   subplot(2,1,1)
    errorbar(pred_results_mean(:,1:15),pred_results_std(:,1:15),'rx');        % Error bars use black squares
   set(gca, 'XTick', 1:1:15 ) % Set ticks and tick labels
   xlabel('Test cases')
   ylabel('Q Residual')
   title(predTitle_1)
   legend('Mean (SD error bars)', 'Location', 'Southeast') % Put in lower right
    subplot(2,1,2)
    errorbar(pred_results_mean(:,16:30),pred_results_std(:,16:30),'rx');        % Error bars use black squares
  
   % set(gca, 'XTick', 16:1:30 ) % Set ticks and tick labels
    xlabel('Test cases')
   ylabel('Q Residual');
    ax = gca;
   title(predTitle_2)
   legend('Mean (SD error bars)', 'Location', 'Southeast') % Put in lower right
        set(gca,'XTick',[1:15]);
   set(gca,'xticklabel',{'16','17','18','19','20','21','22','23','24','25','26','27','28','29','30'})  % Set ticks and tick labels

   
   
    figure (2);                                     % Label the top
   subplot(2,1,1)
    errorbar(pred_results_mean(:,31:45),pred_results_std(:,31:45),'rx');        % Error bars use black squares
    
   xlabel('Test cases')
   ylabel('Q Residual')
   title(predTitle_1)   
   legend('Mean (SD error bars)', 'Location', 'Southeast') % Put in lower right
      set(gca,'XTick',[1:15]);
   set(gca,'xticklabel',{'31','32','33','34','35','36','37','38','39','40','41','42','43','44','45'})  % Set ticks and tick labels

   
    subplot(2,1,2)
    errorbar(pred_results_mean(:,46:60),pred_results_std(:,46:60),'rx');        % Error bars use black squares 
    
   xlabel('Test cases')
   ylabel('Q Residual')
   title(predTitle_2)
   legend('Mean (SD error bars)', 'Location', 'Southeast') % Put in lower right
   set(gca,'XTick',[1:15]);
   set(gca,'xticklabel',{'46','47','48','49','50','51','52','53','54','55','56','57','58','59','60'})  % Set ticks and tick labels
   
   
   
   % Saving all the figures into a file   
  h = get(0,'children');
    for i=1:length(h)
        saveas(h(i), ['figure' num2str(i)], 'fig');
    end 
    daytime = clock;
    savdir = 'C:\Users\INSAV3\Predictive Analytics\Figures\ETFA\';
    s1 = 'Errobars';
     s2= strcat(num2str(daytime(1)),num2str(daytime(2)),num2str(daytime(3)));
    s3= '.fig'
    s = strcat(savdir,s1,'_',s2,s3);
    
  savefig(h,s)
   
     set(0,'DefaultFigureWindowStyle','normal') ;
   
   
   
   
   
   
   
   
%     figure (2);                                     % Label the top
%     errorbar(pred_results_mean_r,pred_results_std_r,'ks');        % Error bars use black squares
%    set(gca, 'XTick', 1:2:84 ) % Set ticks and tick labels
%    xlabel('Test cases')
%    ylabel('Q Residual')
%    title(predTitle)
%    legend('Mean (SD error bars)', 'Location', 'Southeast') % Put in lower right
%    
%    