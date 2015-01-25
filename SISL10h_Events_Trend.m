% SISL10h Trend

clc;
clear;
close all;

% Dock all the charts  as tabs
 set(0,'DefaultFigureWindowStyle','docked') 

% Read the data
 
    
         data =readtable('L10h_Events_Trend.xlsx','Sheet',16,'Range','B1:M178');
      
 data = table2cell(data); 
 for k = 1:numel(data)
  if isnan(data{k})
    data{k} = inf;
  end
end
 
%  data(cellfun(@isnan,data))={[]}
 %y_data =cell2mat(data);
 y_data = data;
% data = cell2mat(data(:,:));
 
     numChartPerFig = 6;
    numChartPerCol = 3 ;
  
    colHeading ={'L10h (hrs)','E10002','E80001','E10010','E10012','E10151','E10011','E10053','E10052','E20206','E20205','E10013'}
     
 
%    %y_data = data1(:,2:13);
      [maxRows maxCols] = size(y_data(:,1:12));
     
    
   y = zeros(maxRows,1);
   
   
 % Original data plots
 for numFig = 0:fix(maxCols/numChartPerFig)-1
  hFig= figure();
    
   ha = tight_subplot(3,2,[.025 .01],[.08 .08],[.005 .005]) ;

   for Cols = numFig*numChartPerFig+1 : (numFig+1)*numChartPerFig
       y(:,1) = cell2mat(y_data(:,Cols)); 
       y_detrend  = detrend(y(:,1));         
 
      i = Cols;
      if i > numChartPerFig
          i = i - numFig *numChartPerFig;
      end

     
      subplot(ha(i));
      plot( y );
    
%         hold on;
%         y_s1=[min(y) max(y)];
%          x_s1 = [day_of_failure  day_of_failure ];
%          line(x_s1,y_s1,'Color','r','LineWidth',2,'LineStyle','--')
%          set(gca,'YLim', y_s1);
%  
         ly= ylabel(colHeading(1,Cols), 'Interpreter','none','rot',90,'Fontsize',12);
         %set(ly, 'position', get(ly,'position')-[0,0,25]); % Move Y label to left
         set(ly, 'Units', 'Normalized', 'Position', [-0.1, 0.5, 0]);
          ly;
         %if Cols ~= (numFig+1)*numChartPerCol
             
                 if Cols ==  (numFig+1)*numChartPerFig || Cols ==  (numFig+1)*numChartPerFig-1
            
                    xlabel('Time (days)','FontSize',12);    
                 else
                    set(ha(1:numChartPerFig),'XTickLabel','');
                end 
 
%         set(gca, 'XTick', [min_x:10:max_x],'Fontsize',6);        
            
        set(gca,'ticklength',0.25*get(gca,'ticklength'))
        set(gca,'tickdir','out')
        grid off
        box off

         set(gca,'PlotBoxAspectRatio',[5  1.5 1])        
 
          
          title = 'SISL10h (hrs) and Event Count over time -  ID 9273779'
                  annotation('textbox', [0.45 .9  1 0.1], ...
                    'String', title, ...
                    'EdgeColor', 'none', ...
                    'HorizontalAlignment', 'left',....
                    'FontSize', 14)
          
      
   end

 end
  

 
 
%   % Plotting charts with date on x axis
%     switch plot_axis
%       case 1
%           y_axis = AvgTorque(:,1)
%       case 2
%           y_axis = AvgTorque(:,2)
%       case 3
%           y_axis = AvgTorque(:,3)
%       case 4
%           y_axis = AvgTorque(:,4)
%       case 5
%           y_axis = AvgTorque(:,5)
%       case 6
%           y_axis = AvgTorque(:,6)
%     end 
%   
%   figure(4)
%   dimx = size(dn);
%   date = linspace(dn(1),dn(end),dimx(1,1));
%    plot(date ,y_axis);grid on;
%   %plot(L10h_2);
%   set(gca,'XTick',date(1:5:dimx(1,1)))
%   datetick('x','yyyy/mm/dd','keepticks')
%   rotateXLabels(gca, 90);
%  % title('L10h over time for axis 1');
%   ylabel('Average Torque')
%   
%   hold on;
%   y=[min(y_axis) max(y_axis)];
%   x = [min(date)+day_of_failure min(date)+day_of_failure ];
%   line(x,y,'Color','r','LineWidth',2,'LineStyle','--')
% set(gca,'YLim', y)
% %   hline = gline; % Connect circles
% %    set(hline,'Color','r')
%   
%   
%   
%   
% Saving all the figures into a file   
  h = get(0,'children');
    for i=1:length(h)
        saveas(h(i), ['figure' num2str(i)], 'fig');
    end 
    daytime = clock;
    savdir = 'C:\Users\INSAV3\Predictive Analytics\Figures\L10h\';
    s1 = 'SISL10h Events Trend';
     s2= strcat(num2str(daytime(1)),num2str(daytime(2)),num2str(daytime(3)));
    s3= '.fig'
    s = strcat(savdir,s1,s2,s3);
    
  savefig(h,s)