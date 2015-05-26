clear all;
clc;
% Dock all the charts  as tabs
 set(0,'DefaultFigureWindowStyle','docked')
% Error Plots

  pred_results = readtable('Residuals.xlsx','Sheet',1); 
    pred_results = table2cell(pred_results); 
    pred_results = cell2mat(pred_results);
 pred_results_y = pred_results(1:59,:);  
 pred_q_pt95 = pred_results(60,:);  
  
   % Plot charts
      %y_data = data1(:,2:13);
   y_data = pred_results_y(1:59,:);
        numChartPerFig = 5;
    numChartPerCol = 3 ;
     
  
    colHeading ={'F_TC_1','F_TC_2','N_TC_3','N_TC_4','N_TC_5','F_TC_6',...
'F_TC_7','N_TC_8','N_TC_9','N_TC_10','F_TC_11','F_TC_12',...
'N_TC_13','N_TC_14','N_TC_15','F_TC_16','F_TC_17','N_TC_18',...
'N_TC_19','N_TC_20','F_TC_21','F_TC_22','N_TC_23','N_TC_24',...
'N_TC_25','F_TC_26','F_TC_27','N_TC_28','N_TC_29','N_TC_30',...
'F_TC_31','F_TC_32','N_TC_33','N_TC_34','N_TC_35','F_TC_36',...
'F_TC_37','N_TC_38','N_TC_39','N_TC_40','F_TC_41','F_TC_42',...
'N_TC_43','N_TC_44','N_TC_45','F_TC_46','F_TC_47','N_TC_48',...
'N_TC_49','N_TC_50','F_TC_51','F_TC_52','N_TC_53','N_TC_54',...
'N_TC_55','F_TC_56','F_TC_57','N_TC_58','N_TC_59','N_TC_60'};

      [maxRows_p maxCols_p] = size(y_data);
     
    
   y = zeros(maxRows_p,1);
   x = [1:59];
   
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
      set(ha(i+1),'Visible','off') % remove the 6th plot in a figure
      plot(x, y );
    
          hold on;
          xL = get(gca,'XLim');
            line(xL,[pred_q_pt95(1,Cols) pred_q_pt95(1,Cols)],'Color','r');
%            line(xL,[7 7],'Color','r');
%         y_s1=[min(y) max(y)];
%          x_s1 = [day_of_failure  day_of_failure ];
%          line(x_s1,y_s1,'Color','r','LineWidth',2,'LineStyle','--')
%          set(gca,'YLim', y_s1);
%  
         ly= ylabel(colHeading(1,Cols), 'Interpreter','none','rot',90,'Fontsize',10);
         %set(ly, 'position', get(ly,'position')-[0,0,25]); % Move Y label to left
          set(ly, 'Units', 'Normalized', 'Position', [-0.065, 0.5, 0]);
           ly;
         %if Cols ~= (numFig+1)*numChartPerCol
             
         %if Cols == numChartPerFig || Cols == numChartPerFig-1
         %if  mod(Cols,4)==0 ||mod(Cols,5)==0
         if Cols == numFig*5+4 ||Cols == numFig*5+5
           
              xlabel('Time (days)','FontSize',12);   
               set(ha(1:numChartPerFig),'XTick',[0:5:60]);
         else
              set(ha(1:numChartPerFig),'XTickLabel','');
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
          
      
   end
 end
 

   
   
  % Saving all the figures into a file   
  h = get(0,'children');
    for i=1:length(h)
        saveas(h(i), ['figure' num2str(i)], 'fig');
    end 
    daytime = clock;
    savdir = 'C:\Users\INSAV3\Predictive Analytics\Figures\ETFA\';
    s1 = 'Q_Residual_Trend';
     s2= strcat(num2str(daytime(1)),num2str(daytime(2)),num2str(daytime(3)));
    s3= '.fig';
    s = strcat(savdir,s1,'_',s2,s3);
    
  savefig(h,s)
   
     set(0,'DefaultFigureWindowStyle','normal') ;
   
  
% Save as pdf or jpeg
%print('-f2','MySavedPlot','-dpng')
   
   