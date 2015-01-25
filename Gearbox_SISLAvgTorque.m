% SISAvgTorque

clc;
clear;
close all;

% Dock all the charts  as tabs
 set(0,'DefaultFigureWindowStyle','docked')
 
% controllerid = 5283944;
controllerid = 32592728;

% Read the data
switch controllerid
    case 5283944  % Failure date 14th Jan 2013
         data =readtable('Gearboxfailure_5283944_Day_SISAvgTorque.xlsx');
         plot_axis = 1;
         day_of_failure = 61;
    case 32592728 % Failure Date 29th Jan 2013
         data =readtable('Gearboxfailure_32592728_Day_SISAvgTorque.xlsx');
         plot_axis = 3;
         day_of_failure = 76;
end

  data = table2cell(data);
    x = data(:,1);
      dn = datenum(x );
   j = 1;
   for i = 3:8
      AvgTorque(:,j) = cell2mat(data(:,i));
      j = j+1;
   end  
   
     
 figure(1);
 
 for plotno = 1:6
      subplot(3,2,plotno);
    plot(AvgTorque(:,plotno))
    title_text = strcat('Avg Torque over days: Axis: ',num2str(plotno));
    title(title_text);
    hold on;
    y=[min(AvgTorque(:,plotno)) max(AvgTorque(:,plotno))];
    x = [day_of_failure  day_of_failure ];
    line(x,y,'Color','r','LineWidth',2,'LineStyle','--')
    set(gca,'YLim', y);
 end 
 
    numChartPerFig = 6;
    numChartPerCol = 3 ;
  
    colHeading ={'Axis 1', 'Axis 2', 'Axis 3', 'Axis 4', 'Axis 5', 'Axis 6'...
                  'Axis 1', 'Axis 2', 'Axis 3', 'Axis 4', 'Axis 5', 'Axis 6'}

      y_data = cell2mat(data(:,3:end));
      
%    %y_data = data1(:,2:13);
      [maxRows maxCols] = size(y_data(:,1:6));
     
    
   y = zeros(maxRows,1);
% Detrend plots
 for numFig = 0:fix(maxCols/numChartPerFig)-1
  hFig= figure();
    
   ha = tight_subplot(3,2,[.025 .01],[.08 .08],[.005 .005]) ;

   for Cols = numFig*numChartPerFig+1 : (numFig+1)*numChartPerFig
       y(:,1) = y_data(:,Cols); 
       y_detrend  = detrend(y(:,1));         
 
      i = Cols;
      if i > numChartPerFig
          i = i - numFig *numChartPerFig;
      end

     
      subplot(ha(i));
      plot( y_detrend );
    
        hold on;
        y_s=[min(y_detrend) max(y_detrend)];
         x_s = [day_of_failure  day_of_failure ];
         line(x_s,y_s,'Color','r','LineWidth',2,'LineStyle','--')
         set(gca,'YLim', y_s);
 
         ly= ylabel(colHeading(1,Cols), 'Interpreter','none','rot',90,'Fontsize',12);
         %set(ly, 'position', get(ly,'position')-[0,0,25]); % Move Y label to left
         set(ly, 'Units', 'Normalized', 'Position', [-0.1, 0.5, 0]);
          ly;
         %if Cols ~= (numFig+1)*numChartPerCol
             
         if Cols == numChartPerFig || Cols == numChartPerFig-1
            
              xlabel('Time (days)','FontSize',12);    
         else
              set(ha(1:numChartPerFig),'XTickLabel','');
         end         
 
%         set(gca, 'XTick', [min_x:10:max_x],'Fontsize',6);        
            
        set(gca,'ticklength',0.25*get(gca,'ticklength'))
        set(gca,'tickdir','out')
        grid off
        box off

         set(gca,'PlotBoxAspectRatio',[4  1.25 1])        
 
          
          title = 'Avg Torque over time - detrend'
                  annotation('textbox', [0.45 .9  1 0.1], ...
                    'String', title, ...
                    'EdgeColor', 'none', ...
                    'HorizontalAlignment', 'left',....
                    'FontSize', 14)
          
      
   end
 end
 
% Original data plots
 for numFig = 0:fix(maxCols/numChartPerFig)-1
  hFig= figure();
    
   ha = tight_subplot(3,2,[.025 .01],[.08 .08],[.005 .005]) ;

   for Cols = numFig*numChartPerFig+1 : (numFig+1)*numChartPerFig
       y(:,1) = y_data(:,Cols); 
       y_detrend  = detrend(y(:,1));         
 
      i = Cols;
      if i > numChartPerFig
          i = i - numFig *numChartPerFig;
      end

     
      subplot(ha(i));
      plot( y );
    
        hold on;
        y_s1=[min(y) max(y)];
         x_s1 = [day_of_failure  day_of_failure ];
         line(x_s1,y_s1,'Color','r','LineWidth',2,'LineStyle','--')
         set(gca,'YLim', y_s1);
 
         ly= ylabel(colHeading(1,Cols), 'Interpreter','none','rot',90,'Fontsize',12);
         %set(ly, 'position', get(ly,'position')-[0,0,25]); % Move Y label to left
         set(ly, 'Units', 'Normalized', 'Position', [-0.1, 0.5, 0]);
          ly;
         %if Cols ~= (numFig+1)*numChartPerCol
             
         if Cols == numChartPerFig || Cols == numChartPerFig-1
            
              xlabel('Time (days)','FontSize',12);    
         else
              set(ha(1:numChartPerFig),'XTickLabel','');
         end         
 
%         set(gca, 'XTick', [min_x:10:max_x],'Fontsize',6);        
            
        set(gca,'ticklength',0.25*get(gca,'ticklength'))
        set(gca,'tickdir','out')
        grid off
        box off

         set(gca,'PlotBoxAspectRatio',[3  1.25 1])        
 
          
          title = 'Avg Torque over time '
                  annotation('textbox', [0.45 .9  1 0.1], ...
                    'String', title, ...
                    'EdgeColor', 'none', ...
                    'HorizontalAlignment', 'left',....
                    'FontSize', 14)
          
      
   end
 end
  

 
 
  % Plotting charts with date on x axis
    switch plot_axis
      case 1
          y_axis = AvgTorque(:,1)
      case 2
          y_axis = AvgTorque(:,2)
      case 3
          y_axis = AvgTorque(:,3)
      case 4
          y_axis = AvgTorque(:,4)
      case 5
          y_axis = AvgTorque(:,5)
      case 6
          y_axis = AvgTorque(:,6)
    end 
  
  figure(4)
  dimx = size(dn);
  date = linspace(dn(1),dn(end),dimx(1,1));
   plot(date ,y_axis);grid on;
  %plot(L10h_2);
  set(gca,'XTick',date(1:5:dimx(1,1)))
  datetick('x','yyyy/mm/dd','keepticks')
  rotateXLabels(gca, 90);
 % title('L10h over time for axis 1');
  ylabel('Average Torque')
  
  hold on;
  y=[min(y_axis) max(y_axis)];
  x = [min(date)+day_of_failure min(date)+day_of_failure ];
  line(x,y,'Color','r','LineWidth',2,'LineStyle','--')
set(gca,'YLim', y)
%   hline = gline; % Connect circles
%    set(hline,'Color','r')
  
  
  
  
% Saving all the figures into a file   
  h = get(0,'children');
    for i=1:length(h)
        saveas(h(i), ['figure' num2str(i)], 'fig');
    end 
    daytime = clock;
    savdir = 'C:\Users\INSAV3\Predictive Analytics\Figures\Gearbox\';
    s1 = 'GearboxFailure';
    s2 = strcat('_',num2str(controllerid),'_AvgTorque_');
    s3= strcat(num2str(daytime(1)),num2str(daytime(2)),num2str(daytime(3)));
    s4 = '.fig'
    s = strcat(savdir,s1,s2,s3,s4);
    
  savefig(h,s)