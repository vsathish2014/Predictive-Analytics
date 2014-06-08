clc;
clear;

% Read the data
    data1 = xlsread('MotionHist_SelectedContollers_d0.xlsx','MotionHist_32592728_ROB_1','D3:HL10000');
   [num1 txt1 raw1] = xlsread('MotionHist_SelectedContollers_d0.xlsx','MotionHist_32592728_ROB_1','D2:HL10000');
   [num2 txt2 raw2] = xlsread('MotionHist_SelectedContollers_d0.xlsx','MotionHist_32592728_ROB_1','A1:A1');

      % Weight vector for the histogram  
   Weight_vector = [0.05; 0.15 ; 0.25 ; 0.35 ; 0.45 ; 0.55 ; 0.65 ; 0.75; 0.85; 0.95 ;1.025;1.075];
    [maxRows maxCols] = size(data1);
    motionHist = 1
    weightedMotionHist = zeros(maxRows,18);
    colHeading_18 = {'MHA_1','MHS_1', 'MHT_1',...
                      'MHA_2','MHS_2', 'MHT_2',...
                      'MHA_3','MHS_3', 'MHT_3',....
                      'MHA_4','MHS_4', 'MHT_4',...
                      'MHA_5','MHS_5', 'MHT_5',....
                      'MHA_6','MHS_6', 'MHT_6',}
%     colHeading_9 = txt1(1,38:46);
%     colHeading = cat(2,colHeading_3,colHeading_9);
      colHeading = colHeading_18;
    numChartPerFig = 18;
    numChartPerCol = 6 ;
    
  for nCols = 2:12:217
    for nRows = 1 : maxRows
          
         Col_row = data1(nRows,nCols :nCols+11) ;
         weightedMotionHist(nRows,motionHist) = Col_row * Weight_vector;
    end
    motionHist = motionHist +1;
  end       
    x = data1(:,1);
%     ds1 = data1(:,38:46);
%     y_data = cat(2,weightedMotionHist,ds1);
    y_data = weightedMotionHist;
   %y_data = data1(:,2:13);
    [maxRows maxCols] = size(y_data);
   
   y = zeros(maxRows,1);

 for numFig = 0:fix(maxCols/numChartPerFig)-1
  hFig= figure();
    
   ha = tight_subplot(6,3,[.003 .003],[.05 .07],[.005 .005]) ;

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
       plot(x,y);

     
         
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
         title = 'Angle for 6 axes';
                  annotation('textbox', [0.125 .875 1 0.1], ...
                    'String', title, ...
                    'EdgeColor', 'none', ...
                    'HorizontalAlignment', 'left')
         
          title = 'Speed for 6 axes';
                  annotation('textbox', [0.45 .875 1 0.1], ...
                    'String', title, ...
                    'EdgeColor', 'none', ...
                    'HorizontalAlignment', 'left')
          
          title = 'Torque for 6 axes';
                  annotation('textbox', [0.8 .875 1 0.1], ...
                    'String', title, ...
                    'EdgeColor', 'none', ...
                    'HorizontalAlignment', 'left')
 
      
   end
 end
         