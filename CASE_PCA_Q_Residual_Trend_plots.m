%clear all;
%clc;
% Dock all the charts  as tabs
 set(0,'DefaultFigureWindowStyle','docked')
% Error Plots

  pred_results = readtable('Q_residual_Results.xlsx','Sheet',1); 
    pred_results = table2cell(pred_results); 
    pred_results = cell2mat(pred_results);
 pred_results_y = pred_results(1:240,:);  
 pred_q_pt95 = pred_results(241,:);  
  pred_q_pt90 = pred_results(242,:); 
   pred_q_pt99 = pred_results(243,:);  
   % Plot charts
      %y_data = data1(:,2:13);
   y_data = pred_results_y(1:240,:);
        numChartPerFig = 6;
    numChartPerCol = 3 ;
     
  
colHeading ={'T1_fc1_10',	'T1_fc2_10',	'T1_fc3_10',	'T1_fc4_10',	'T1_fc5_10',	'T1_fc6_10',...
'T1_fc1_20',	'T1_fc2_20',	'T1_fc3_20',	'T1_fc4_20',	'T1_fc5_20',	'T1_fc6_20',...
'T2_fc1_10',	'T2_fc2_10',	'T2_fc3_10',	'T2_fc4_10',	'T2_fc5_10',	'T2_fc6_10',...
'T2_fc1_20',	'T2_fc2_20',	'T2_fc3_20',	'T2_fc4_20',	'T2_fc5_20',	'T2_fc6_20',...
'T3_fc1_10',	'T3_fc2_10',	'T3_fc3_10',	'T3_fc4_10',	'T3_fc5_10',	'T3_fc6_10',...
'T3_fc1_20',	'T3_fc2_20',	'T3_fc3_20',	'T3_fc4_20',	'T3_fc5_20',	'T3_fc6_20'};

      [maxRows_p maxCols_p] = size(y_data);
     
    
   y = zeros(maxRows_p,1);
   x = [1:240];
   
 % Original data plots
 for numFig = 0:fix(maxCols_p/numChartPerFig)-1
  hFig= figure();
    
   ha = tight_subplot(3,2,[.025 .01],[.08 .08],[.005 .005]) ;

   for Cols = numFig*numChartPerFig+1 : (numFig+1)*numChartPerFig
       y(:,1) = (y_data(:,Cols)); 
       %y_detrend  = detrend(y(:,1));         
 
      i = Cols;
      if i > numChartPerFig
          i = i - numFig *numChartPerFig;
      end

     
      subplot(ha(i));
%      set(ha(i+1),'Visible','off') % remove the 6th plot in a figure
      plot(x, log10(y') );
      grid on;
          hold on;
          xL = get(gca,'XLim');
            line(xL,[log10(pred_q_pt95(1,Cols)) log10(pred_q_pt95(1,Cols))],'Color','r');
          hold on;
            line(xL,[log10(pred_q_pt90(1,Cols)) log10(pred_q_pt90(1,Cols))],'Color','k');
          hold on;
            line(xL,[log10(pred_q_pt99(1,Cols)) log10(pred_q_pt99(1,Cols))],'Color','g');
          hold on;
          yL = get(gca,'YLim');
          yLlog = log10(yL);
            line([120 120],yL,'Color','c','LineStyle','--');
 
%  
         ly= ylabel(colHeading(1,Cols), 'Interpreter','none','rot',90,'Fontsize',10);
         %set(ly, 'position', get(ly,'position')-[0,0,25]); % Move Y label to left
          set(ly, 'Units', 'Normalized', 'Position', [-0.065, 0.5, 0]);
           ly;
         %if Cols ~= (numFig+1)*numChartPerCol
             
         %if Cols == numChartPerFig || Cols == numChartPerFig-1
         %if  mod(Cols,4)==0 ||mod(Cols,5)==0
         if Cols == numFig*6+5 ||Cols == numFig*6+6
           
              xlabel('Time (days)','FontSize',12);   
               set(ha(1:numChartPerFig),'XTick',[0:20:240]);
               grid on;
         else
              set(ha(1:numChartPerFig),'XTickLabel','');
              grid on;
         end         
 
%         set(gca, 'XTick', [min_x:10:max_x],'Fontsize',6);        
            
        set(gca,'ticklength',0.25*get(gca,'ticklength'))
        set(gca,'tickdir','out')
        grid off
        box off

         set(gca,'PlotBoxAspectRatio',[5  1.5 1])   
         set(gcf,'color','w');
 
          
          title = strcat('Q-Residual', '-Trend over Samples ')
                  annotation('textbox', [0.45 .9  1 0.1], ...
                    'String', title, ...
                    'EdgeColor', 'none', ...
                    'HorizontalAlignment', 'left',....
                    'FontSize', 14)
          grid on;
      
   end
 end
 

   
   
  % Saving all the figures into a file   
  h = get(0,'children');
    for i=1:length(h)
        saveas(h(i), ['figure' num2str(i)], 'fig');
    end 
    daytime = clock;
    savdir = 'C:\Users\INSAV3\Predictive Analytics\DataSets\CASE\Datasets\Results';
    s1 = 'Q_Residual_Trend';
     s2= strcat(num2str(daytime(1)),num2str(daytime(2)),num2str(daytime(3)));
    s3= '.fig';
    s = strcat(savdir,s1,'_',s2,s3);
    
  savefig(h,s)
   
     set(0,'DefaultFigureWindowStyle','normal') ;
   
  
% Save as pdf or jpeg
%print('-f2','MySavedPlot','-dpng')
   
   