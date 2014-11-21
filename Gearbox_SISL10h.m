% SISL10h

clc;
clear;

% Read the data
 %   data = xlsread('Gearboxfailure_32592728_Day_SISL10h.xlsx','Data','A2:M166');
data =readtable('Gearboxfailure_32592728_Day_SISL10h.xlsx');
%data =readtable('Gearboxfailure_5283944_Day_SISL10h.xlsx');
 data = table2cell(data);
    x = data(:,1);
      dn = datenum(x );
    L10h_1 = cell2mat(data(:,3));
    L10h_2 = cell2mat(data(:,4));
    L10h_3 = cell2mat(data(:,5));
    L10h_4 = cell2mat(data(:,6));
    L10h_5 = cell2mat(data(:,7));
    L10h_6 = cell2mat(data(:,8));
    
 figure(1);
% ha = tight_subplot(3,2,[0.05 0.025],0.05,[0.3 0.05]);
   subplot(3,2,1);
 plot(L10h_1)
 title('L10h over days-Axis 1')
 
 
  subplot(3,2,2)
  plot(L10h_2)
 title('L10h over days-Axis 2')
 
 
  subplot(3,2,3)
  plot(L10h_3)
 title('L10h over days-Axis 3')
 
 
 subplot(3,2,4)
  plot(L10h_4)
 title('L10h over days-Axis 4')
 
 
 subplot(3,2,5)
 plot(L10h_5)
 title('L10h over days-Axis 5')
 
 
 subplot(3,2,6)
 plot(L10h_6)
 title('L10h over days-Axis 6')
 
 
     numChartPerFig = 3;
    numChartPerCol = 3 ;
  
    colHeading ={'Axis 1', 'Axis 2', 'Axis 3', 'Axis 4', 'Axis 5', 'Axis 6'...
                  'Axis 1', 'Axis 2', 'Axis 3', 'Axis 4', 'Axis 5', 'Axis 6'}
         
%    x = [1:334]';
 %    x = data(:,1);
% %     ds1 = data1(:,38:46);
% %     y_data = cat(2,weightedMotionHist,ds1);
      y_data = cell2mat(data(:,3:end));
      
%    %y_data = data1(:,2:13);
      [maxRows maxCols] = size(y_data);
%    
%  for nCols = 1 :6
%      y_max  = max(y_data(:,nCols));
%      y_min  = min(y_data(:,nCols));
%      
%       
%         y_norm(:,nCols) = (y_data(:,nCols)- y_min) /(y_max -y_min);
%  end    
%     
%     
    
   y = zeros(maxRows,1);

 for numFig = 0:fix(maxCols/numChartPerFig)-1
  hFig= figure();
    
   ha = tight_subplot(3,1,[.025 .01],[.08 .08],[.005 .005]) ;

   for Cols = numFig*numChartPerFig+1 : (numFig+1)*numChartPerFig
       y(:,1) = y_data(:,Cols); 
       y_detrend  = detrend(y(:,1));         
     
% for ii = 1:4; axes(ha(ii)); plot(randn(10,ii)); end 
% set(ha(1:4),'XTickLabel',''); set(ha,'YTickLabel','')
      i = Cols;
      if i > numChartPerFig
          i = i - numFig *numChartPerFig
      end

     
      subplot(ha(i));
      plot( y_detrend );
 
     
 
     
     
         
%       xlabel(txt1(1,1));
         ly= ylabel(colHeading(1,Cols), 'Interpreter','none','rot',90,'Fontsize',12);
         %set(ly, 'position', get(ly,'position')-[0,0,25]); % Move Y label to left
         set(ly, 'Units', 'Normalized', 'Position', [-0.1, 0.5, 0]);
          ly;
         if Cols ~= (numFig+1)*numChartPerCol
             set(ha(1:numChartPerFig),'XTickLabel','');
         else
             xlabel('Time (days)','FontSize',12);
         end
         
%         ylabel('L10h');
%         set(ha,'YTickLabel','')
         
%         min_x = ceil(min(x));
%         max_x = ceil(max(x));
%         set(gca, 'XTick', [min_x:10:max_x],'Fontsize',6);
        
            
        set(gca,'ticklength',0.25*get(gca,'ticklength'))
        set(gca,'tickdir','out')
        grid off
        box off

         set(gca,'PlotBoxAspectRatio',[3  1.25 1])
        
       % Draw a line at failure day - 0the day
         ylimits = ylim;
         ymin = ylimits(1,1);
         ymax = ylimits(1,2);
         line ([0 0],ylimits,'LineStyle',':','Color','r');
         
         % Provide a  tile for the all the sub plots
       % title = 'Time ';
%          annotation('textbox', [0 0.9 1 0.1], ...
%                     'String', title, ...
%                     'EdgeColor', 'none', ...
%                     'HorizontalAlignment', 'center')
          
          title = 'L10h over time '
                  annotation('textbox', [0.45 .9  1 0.1], ...
                    'String', title, ...
                    'EdgeColor', 'none', ...
                    'HorizontalAlignment', 'left',....
                    'FontSize', 14)
          
      
   end
 end
 

  % Plotting charts with date on x axis
  figure(7)
  dimx = size(dn);
  date = linspace(dn(1),dn(end),dimx(1,1));
   plot(date ,L10h_2);grid on;
  %plot(L10h_2);
  set(gca,'XTick',date(1:5:dimx(1,1)))
  datetick('x','yyyy/mm/dd','keepticks')
  rotateXLabels(gca, 90);
 % title('L10h over time for axis 1');
  ylabel('L10 h in hours')
  
%  annotation('line',[0.415080527086384 0.415080527086384],...
%     [0.284276073619632 0.924846625766871],'LineStyle','--','LineWidth',2,...
%     'Color',[1 0 0]);  
% % annotation('line',[0.447 0.447],[0 1],'LineStyle','--','LineWidth',2,...
% %      'Color',[1 0 0]);
% %  
 