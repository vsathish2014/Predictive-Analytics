clc;
clear;
close all;
% Dock all the charts  as tabs
 set(0,'DefaultFigureWindowStyle','docked')
 % Controller ID
 s4= ' GB Axis 6: 5283944 ';
 
%Read distrubitions      
        data =readtable('GB_L10h_Speed_Torque_5283944.xlsx','Sheet',7,'Range','C1:AD171');
      
      
 data = table2cell(data); 
 data = cell2mat(data);
 
 
 data_s = data(:,3:14);
% data_a = data(:,3:14);
 data_t = data(:,15:26);
 
 [cRows cCols] =size(data);
 
 
        for counter = 2:cRows
                % distance_a(counter) = kldiv(data_a(1,:) ,data_a(counter,:)+eps);
                 distance_s(counter) =kldiv(data_s(1,:) ,data_s(counter,:)+eps);
                 distance_t(counter) =kldiv(data_t(1,:) ,data_t(counter,:)+eps);
        end
   % kldiv_dist(axis,:,fc_axis) = distance(end,:);
  % distance_a = distance_a';
    distance_s = distance_s';
     distance_t = distance_t';
   l10h = data (:,2);
  % movedRad = data(:,43);
   avgSpeed = data(:,27);
   avgTorque = data(:,28);
   
   y_data = horzcat( avgSpeed,distance_s,avgTorque, distance_t);
   
   % Plot charts
   %    %y_data = data1(:,2:13);
   
        numChartPerFig = 6;
    numChartPerCol = 3 ;
  
    colHeading ={'AvgSpeed', 'KL_Speed','AvgTorque','KL_Torque'}

      [maxRows maxCols] = size(y_data(:,1:4));
     
    
   y = zeros(maxRows,1);
   
   
 % Original data plots
 for numFig = 0:fix(maxCols/numChartPerFig)-1
  hFig= figure();
    
   ha = tight_subplot(3,2,[.025 .01],[.08 .08],[.005 .005]) ;

   for Cols = numFig*numChartPerFig+1 : (numFig+1)*numChartPerFig
       y(:,1) = (y_data(:,Cols)); 
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

         set(gca,'PlotBoxAspectRatio',[5  1.5 1])        
 
          
          title = strcat(s4, ' -Measurement Trend over Time ')
                  annotation('textbox', [0.45 .9  1 0.1], ...
                    'String', title, ...
                    'EdgeColor', 'none', ...
                    'HorizontalAlignment', 'left',....
                    'FontSize', 14)
          
      
   end
 end
 
figure(2);
clear title 
x = [1:1:cRows];
 subplot(3,1,1);
plot(l10h);
title_a=strcat(s4,': L10h over time');
title(title_a);
title(title_a,'FontSize',14);
subplot(3,1,2)

plot( x,distance_s );
title_b=strcat(s4,': KL distance -Hist data for Moved Rad, Speed and Torque');
title(title_b,'FontSize',14);
legend( 'KL speed' );
subplot(3,1,3)

plot(  x,distance_t);
title_b=strcat(s4,': KL distance -Hist data for Moved Rad, Speed and Torque');
title(title_b,'FontSize',14);
legend(   'KL torque');


figure(3);
clear title 
x = [1:1:cRows];
 subplot(2,2,1);
plot(l10h);
title_a=strcat(s4,': L10h over time');
title(title_a);
title(title_a,'FontSize',14);
% 
% subplot(2,2,2)
% plot(x,movedRad);
% title_b=strcat(s4,': Moved Radians');
% title(title_b,'FontSize',14);
 
subplot(2,2,3)
plot(x,avgSpeed);
title_b=strcat(s4,': Avg Speed (rpm)');
title(title_b,'FontSize',14);

subplot(2,2,4)
plot(x,avgTorque);
title_b=strcat(s4,': Avg Torque (Nm)');
title(title_b,'FontSize',14);
 
 
 
% Saving all the figures into a file   
  h = get(0,'children');
    for i=1:length(h)
        saveas(h(i), ['figure' num2str(i)], 'fig');
    end 
    daytime = clock;
    savdir = 'C:\Users\INSAV3\Predictive Analytics\Figures\L10h\';
    s1 = 'L10h Measurement Trend';
     s2= strcat(num2str(daytime(1)),num2str(daytime(2)),num2str(daytime(3)));
    s3= '.fig'
    s = strcat(savdir,s1,s4,'_',s2,s3);
    
  savefig(h,s)
   
     
   
   
   