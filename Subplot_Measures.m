clc;
clear;

% Read the data
    data1 = xlsread('GearboxFailure_32592728_raw_Rob1_d0.xlsx','MotionHist_rate','A3:S10000');
   [num1 txt1 raw1] = xlsread('GearboxFailure_32592728_raw_Rob1_d0.xlsx','MotionHist_rate','A2:S10000');
   [num2 txt2 raw2] = xlsread('GearboxFailure_32592728_raw_Rob1_d0.xlsx','MotionHist_rate','A1:A1');

   [maxRows maxCols] = size(data1);
    motionHist = 1
    weightedMotionHist = zeros(maxRows,3);
    colHeading  = txt1(1,2:19);
     numChartPerFig = 6 ;
    
     
    x = data1(:,1);
    y_data = data1(:,2:19);
   [maxRows maxCols] = size(y_data);
   
   y = zeros(maxRows,1);

 for numFig = 0:fix(maxCols/numChartPerFig)-1
  hFig= figure();
    
   ha = tight_subplot(numChartPerFig,1,[.003 .03],[.05 .05],[.01 .01]) ;

   for Cols = numFig*numChartPerFig+1 : (numFig+1)*numChartPerFig
       y(:,1) = y_data(:,Cols); 
      y_detrend  = detrend(y(:,1));         
     
% for ii = 1:4; axes(ha(ii)); plot(randn(10,ii)); end 
% set(ha(1:4),'XTickLabel',''); set(ha,'YTickLabel','')
      i = Cols;
      if i > numChartPerFig
          i = i - numFig *numChartPerFig
      end
       axes(ha(i));
       plot(x,y);
       xlabel(txt1(1,1));
        ly= ylabel(colHeading(1,Cols), 'Interpreter','none','rot',360,'Fontsize',8);
        set(ly, 'position', get(ly,'position')-[15,0,1]); % Move Y label to left
       if Cols ~= (numFig+1)*numChartPerFig
           set(ha(1:numChartPerFig),'XTickLabel','');
       end
         set(ha,'YTickLabel','')
        set(gca, 'XTick', [-90:10:20],'Fontsize',6);
        
            
        set(gca,'ticklength',0.25*get(gca,'ticklength'))
        set(gca,'tickdir','out')
        grid off
        box off

         set(gca,'PlotBoxAspectRatio',[5  1.25 1])
         % Draw a line at failure day - 0the day
         ym = ylim;
         line ([0 0],ym,'LineStyle',':','Color','r');
         % Provide a  tile for the all the sub plots
         title = txt2(1,1);
         annotation('textbox', [0 0.9 1 0.1], ...
                    'String', title, ...
                    'EdgeColor', 'none', ...
                    'HorizontalAlignment', 'center')
                
 
      
   end
 end
         