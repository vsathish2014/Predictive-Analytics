clc;
clear;

% Read the data
    data1 = xlsread('SIS_SelectedControllers_d0.xlsx','SIS_44060208_ROB_1','D3:V10000');
   [num1 txt1 raw1] = xlsread('SIS_SelectedControllers_d0.xlsx','SIS_44060208_ROB_1','D2:V10000');
   [num2 txt2 raw2] = xlsread('SIS_SelectedControllers_d0.xlsx','SIS_44060208_ROB_1','A1:A1');

      [maxRows maxCols] = size(data1);
    motionHist = 1
    weightedMotionHist = zeros(maxRows,18);
    colHeading_18 = {'SIS_MR_1','SIS_AS_1', 'SIS_AT_1',...
                      'SIS_MR_2','SIS_AS_2', 'SIS_AT_2',...
                      'SIS_MR_3','SIS_AS_3', 'SIS_AT_3',....
                      'SIS_MR_4','SIS_AS_4', 'SIS_AT_4',...
                      'SIS_MR_5','SIS_AS_5', 'SIS_AT_5',....
                      'SIS_MR_6','SIS_AS_6', 'SIS_AT_6',}
%     colHeading_9 = txt1(1,38:46);
%     colHeading = cat(2,colHeading_3,colHeading_9);
      colHeading = colHeading_18;
    numChartPerFig = 18;
    numChartPerCol = 6 ;
    
         
    x = data1(:,1);
%     ds1 = data1(:,38:46);
%     y_data = cat(2,weightedMotionHist,ds1);
    y_data = data1(:,2:19);
   %y_data = data1(:,2:13);
    [maxRows maxCols] = size(y_data);
   
 for nCols = 1 :18
     y_max  = max(y_data(:,nCols));
     y_min  = min(y_data(:,nCols));
     
      
        y_norm(:,nCols) = (y_data(:,nCols)- y_min) /(y_max -y_min);
 end    
    
    
    
   y = zeros(maxRows,1);

 for numFig = 0:fix(maxCols/numChartPerFig)-1
  hFig= figure();
    
   ha = tight_subplot(6,3,[.003 .003],[.05 .07],[.005 .005]) ;

   for Cols = numFig*numChartPerFig+1 : (numFig+1)*numChartPerFig
       y(:,1) = y_norm(:,Cols); 
      y_detrend  = detrend(y(:,1));         
     
% for ii = 1:4; axes(ha(ii)); plot(randn(10,ii)); end 
% set(ha(1:4),'XTickLabel',''); set(ha,'YTickLabel','')
      i = Cols;
      if i > numChartPerFig
          i = i - numFig *numChartPerFig
      end

     
      subplot(ha(i));
       plot(x,y );

     
         
       xlabel(txt1(1,1));
        ly= ylabel(colHeading(1,Cols), 'Interpreter','none','rot',90,'Fontsize',8);
%         set(ly, 'position', get(ly,'position')-[0,0,1]); % Move Y label to left
%         ly;
%        if Cols ~= (numFig+1)*numChartPerCol
%            set(ha(1:numChartPerFig),'XTickLabel','');
%        end
         set(ha,'YTickLabel','')
         
        min_x = ceil(min(x));
        max_x = ceil(max(x));
        set(gca, 'XTick', [min_x:10:max_x],'Fontsize',6);
        
            
        set(gca,'ticklength',0.25*get(gca,'ticklength'))
        set(gca,'tickdir','out')
        grid off
        box off

         set(gca,'PlotBoxAspectRatio',[5  1.25 1])
        
       % Draw a line at failure day - 0the day
         ylimits = ylim;
         ymin = ylimits(1,1);
         ymax = ylimits(1,2);
         line ([0 0],ylimits,'LineStyle',':','Color','r');
         
         % Provide a  tile for the all the sub plots
         title = txt2(1,1);
         annotation('textbox', [0 0.9 1 0.1], ...
                    'String', title, ...
                    'EdgeColor', 'none', ...
                    'HorizontalAlignment', 'center')
         title = 'Moved Radians for 6 axes';
                  annotation('textbox', [0.125 .875 1 0.1], ...
                    'String', title, ...
                    'EdgeColor', 'none', ...
                    'HorizontalAlignment', 'left')
         
          title = 'Average Speed for 6 axes';
                  annotation('textbox', [0.45 .875 1 0.1], ...
                    'String', title, ...
                    'EdgeColor', 'none', ...
                    'HorizontalAlignment', 'left')
          
          title = 'Average Torque for 6 axes';
                  annotation('textbox', [0.8 .875 1 0.1], ...
                    'String', title, ...
                    'EdgeColor', 'none', ...
                    'HorizontalAlignment', 'left')
 
      
   end
 end
         