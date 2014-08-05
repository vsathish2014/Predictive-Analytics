% Plot histogram
 
 clear torque_avg;

%sampling size 
s = 60;
for j= 1:6
    k=1;
    for i = 1:s:720
    torque_avg(k,j)=mean(abs(tau_pn_mn_1(i:i+s-1,j)));
    k =k +1;
    end
end
 

% 
% %%%%%%%%%%%%

  [maxRows maxCols] = size(torque_avg);
    motionHist = 1
    weightedMotionHist = zeros(maxRows,3);
   colHeading  = {'Axis 1','Axis 2', 'Axis 3', 'Axis 4','Axis 5', 'Axis 6'};
     numChartPerFig = 6 ;
    
     
    x = 1:5:60;
    y_data = torque_avg(:,:);
   [maxRows maxCols] = size(y_data);
   
   y = zeros(maxRows,1);
j= 1;
 for numFig = 0:fix(maxCols/numChartPerFig)-1
  hFig= figure(j);
    j = j+1;
   ha = tight_subplot(numChartPerFig,1,[.003 .03],[.05 .05],[.01 .01]) ;

   for Cols = numFig*numChartPerFig+1 : (numFig+1)*numChartPerFig
       y(:,1) = y_data(:,Cols); 
     % y_detrend  = detrend(y(:,1));         
     
% for ii = 1:4; axes(ha(ii)); plot(randn(10,ii)); end 
 set(ha(1:4),'XTickLabel',''); set(ha,'YTickLabel','')
      i = Cols;
      if i > numChartPerFig
          i = i - numFig *numChartPerFig
      end
       axes(ha(i));
       plot(x,y);
       %bar(edges,y,'histc');
       xlabel('Time in minutes','FontSize',8);
        ly= ylabel(colHeading(1,Cols), 'Interpreter','none','rot',360,'Fontsize',12);
          set(ly, 'position', get(ly,'position')-[5,0,1]); % Move Y label to left
       if Cols ~= (numFig+1)*numChartPerFig
           set(ha(1:numChartPerFig),'XTickLabel','');
       end
         set(ha,'YTickLabel','')
       % set(gca, 'XTick', [-90:10:20],'Fontsize',6);
        
            
        set(gca,'ticklength',0.25*get(gca,'ticklength'))
        set(gca,'tickdir','out')
        grid off
        box off

         set(gca,'PlotBoxAspectRatio',[5  1.25 1])
%          % Draw a line at failure day - 0the day
%          ym = ylim;
%          line ([0 0],ym,'LineStyle',':','Color','r');
         % Provide a  tile for the all the sub plots
%         title = txt2(1,1);
          title ='Average Torque - Nm';
         annotation('textbox', [0 0.9 1 0.1], ...
                    'String', title, ...
                    'EdgeColor', 'none', ...
                    'HorizontalAlignment', 'center',...
                    'FontSize',14)
                
 
      
   end
 end
         


