clc;
clear;
 % This is a test
% Read the data
  %  data1 = xlsread('GearboxFailure_32592728_RawData_d2.xlsx','Daily Average_1','A2:IA165');
  % [num1 txt1 raw1] = xlsread('GearboxFailure_32592728_RawData_d2.xlsx','Daily Average_1','A1:IA165');
   
%    data1 = xlsread('GearboxFailure_32592728_RawData_d2.xlsx','Daily Average_Axis_3','A2:AX165');
%    [num1 txt1 raw1] = xlsread('GearboxFailure_32592728_RawData_d2.xlsx','Daily Average_Axis_3','A1:AX165');
 
%   data1 = xlsread('GearboxFailure_5283944_RawData_d2.xlsx','Daily Average_Axis_1','A2:AX171');
%   [num1 txt1 raw1] = xlsread('GearboxFailure_5283944_RawData_d2.xlsx','Daily Average_Axis_1','A1:AX171');
  
   data1 = xlsread('GearboxFailure_32592728_raw_d0.xlsx','Axis_6_ROB_1','F2:AZ10000');
  [num1 txt1 raw1] = xlsread('GearboxFailure_32592728_raw_d0.xlsx','Axis_6_ROB_1','F1:AZ10000');
  [num2 txt2 raw2] = xlsread('GearboxFailure_32592728_raw_d0.xlsx','Failure_Type','A1:A1');


   x = data1(:,1);
   y_data = data1(:,2:37);
    [maxRows maxCols] = size(y_data);
   
   y = zeros(maxRows,1);

 for numFig = 0:(maxCols/12)-1
  hFig= figure();
    
   ha = tight_subplot(12,1,[.003 .03],[.05 .05],[.01 .01]) ;

   for Cols = numFig*12+1 : (numFig+1)*12
       y(:,1) = y_data(:,Cols); 
       y_detrend  = detrend(y(:,1));         
     
% for ii = 1:4; axes(ha(ii)); plot(randn(10,ii)); end 
% set(ha(1:4),'XTickLabel',''); set(ha,'YTickLabel','')
      i = Cols;
      if i > 12
          i = i - numFig *12
      end
       axes(ha(i));
       plot(x,unwrap(y_detrend));
       xlabel(txt1(1,1));
        ly= ylabel(txt1(1,Cols+1), 'Interpreter','none','rot',360,'Fontsize',8);
        set(ly, 'position', get(ly,'position')-[25,0,0]); % Move Y label to left
       if Cols ~= (numFig+1)*12
           set(ha(1:12),'XTickLabel','');
       end
         set(ha,'YTickLabel','')
        set(gca, 'XTick', [-70:10:20],'Fontsize',6);
        
            
        set(gca,'ticklength',0.25*get(gca,'ticklength'))
        set(gca,'tickdir','out')
        grid off
        box off
 
         %set(gca,'CameraViewAngle',get(gca,'CameraViewAngle')-5)
         %set(gca,'CameraViewAngle',get(gca,'CameraViewAngle')+5)
         %set(gca,'PlotBoxAspectRatio',[100000000 15000000 1000000])
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
                
         %set( gca, 'Units', 'normalized', 'Position', [0 0 1 1] );
         %set(hFig, 'Position', [x y 10 10])

         % set(gca,'DataAspectRatio',[1000000 1 75000])
      
   end
 end
