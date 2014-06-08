clc;
clear;

% Read the data
    data1 = xlsread('SIS_SelectedControllers_d0.xlsx','SISL10h','C3:I10000');
   [num1 txt1 raw1] = xlsread('SIS_SelectedControllers_d0.xlsx','SISL10h','C2:I10000');
    [num2 txt2 raw2] = xlsread('SIS_SelectedControllers_d0.xlsx','SISL10h','A1:A1');

      [maxRows maxCols] = size(data1);
    motionHist = 1
    weightedMotionHist = zeros(maxRows,6);
    colHeading_6 = {'SISL10h_1', ...
                      'SISL10h_2', ...
                      'SISL10h_3', ....
                      'SISL10h_4', ...
                      'SISL10h_5', ....
                      'SISL10h_6',}
%     colHeading_9 = txt1(1,38:46);
%     colHeading = cat(2,colHeading_3,colHeading_9);
      colHeading = colHeading_6;
    numChartPerFig = 6;
    numChartPerCol = 6 ;
    
         
    x = data1(:,1);
%     ds1 = data1(:,38:46);
%     y_data = cat(2,weightedMotionHist,ds1);
    y_data = data1(:,2:7);
   %y_data = data1(:,2:13);
    [maxRows maxCols] = size(y_data);
   
 for nCols = 1 :6
     y_max  = max(y_data(:,nCols));
     y_min  = min(y_data(:,nCols));
     
      
        y_norm(:,nCols) = (y_data(:,nCols)- y_min) /(y_max -y_min);
 end    
    
    
    
   y = zeros(maxRows,1);

 for numFig = 0:fix(maxCols/numChartPerFig)-1
  hFig= figure();
    
   ha = tight_subplot(6,1,[.003 .003],[.05 .07],[.005 .005]) ;

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
          
          title = 'SISL10h for 6 axis';
                  annotation('textbox', [0.45 .875 1 0.1], ...
                    'String', title, ...
                    'EdgeColor', 'none', ...
                    'HorizontalAlignment', 'left')
          
      
   end
 end
         