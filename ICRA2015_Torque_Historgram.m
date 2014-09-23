% Plot histogram
%max_tau_1 = max(abs(tau_pn_mn_1(2:13,1)));
%max_tau_f_1 = max(tau_pn_mn_1(:,2));
axis = 1;
% max_tau_1 = 97.6
% max_tau_2 = 186.4;
% max_tau_3 = 89.4;
% max_tau_4 = 24.2;
% max_tau_5 = 20.1;
% max_tau_6 = 21.3;

max_tau_1 = max(abs(tau_fc_pn_mn(:,1)));
max_tau_2 = max(abs(tau_fc_pn_mn(:,2)));
max_tau_3 = max(abs(tau_fc_pn_mn(:,3)));
max_tau_4 = max(abs(tau_fc_pn_mn(:,4)));
max_tau_5 = max(abs(tau_fc_pn_mn(:,5)));
max_tau_6 = max(abs(tau_fc_pn_mn(:,6)));

switch axis
    case 1
        max_tau = max_tau_1;
    case 2
        max_tau = max_tau_2;
    case 3
         max_tau = max_tau_3;
    case 4
        max_tau = max_tau_4;
    case 5
        max_tau = max_tau_5;
    case 6
        max_tau = max_tau_6;
end
     

%edges = [0; 0.1*max_tau;0.2*max_tau;0.3*max_tau;0.4*max_tau;0.5*max_tau;0.6*max_tau; ...
%    0.7*max_tau;0.8*max_tau;0.9*max_tau;1.0*max_tau;1.05*max_tau];

edges = [0; 0.1*max_tau;0.2*max_tau;0.3*max_tau;0.4*max_tau;0.5*max_tau;0.6*max_tau; ...
    0.7*max_tau;0.8*max_tau;0.9*max_tau;1.0*max_tau;1.1*max_tau];
%;1.1*max_tau
clear bincounts
clear bincounts1
clear bincounts2
edges = edges(:,:);
size_edges = size(edges);
no_bins = size_edges(1,1);
k=1;
%sampling size 
s = 60;
for i = 1:s:8640
bincounts1(:,:,k)=histc(  abs(tau_fc_pn_mn(i:i+s-1,axis)),edges);
k =k +1;

end
 bincounts2 = reshape(bincounts1,no_bins,8640/s);
  bincounts = bincounts2./repmat(sum(bincounts2),size(bincounts2,1),1);
% figure(1);
% subplot(3,2,1);
%[bincounts]=histc(abs(tau_pn_mn_1(1:13,1)),edges);
% Normalize to 1

%[bincounts]= histc(x,edges1);
% bar(edges,bincounts(:,1),'histc');
% subplot(3,2,2);
% bar(edges,bincounts(:,2),'histc');
% subplot(3,2,3);
% bar(edges,bincounts(:,4),'histc');
% subplot(3,2,4);
% bar(edges,bincounts(:,6),'histc');
% subplot(3,2,5);
% bar(edges,bincounts(:,8),'histc');
% subplot(3,2,6);
% bar(edges,bincounts(:,12),'histc');


%%%%%%%%%%%%

  [maxRows maxCols] = size(bincounts);
    motionHist = 1
    weightedMotionHist = zeros(maxRows,3);
   colHeading  = {'Sample 1(0-5 min)','Sample 2(5- 10 min)', 'Sample 3(10-15 min)', 'Sample 4(15-20 min)','Sample 5(20-25 min)', 'Sample 6(25-30 min)'....
                  'Sample 7(30-35 min) ','Sample 8(35-40 min)', 'Sample 9(40-45 min)', 'Sample 10(45-50 min)','Sample 11(50-55 min)','Sample 12(55-60 min)'};
     numChartPerFig = 6 ;
    
     
    x = 0:10:140;
    y_data = bincounts(:,:);
   [maxRows maxCols] = size(y_data);
   
   y = zeros(maxRows,1);
j= 1;
 for numFig = 0:fix(maxCols/numChartPerFig)-1
  hFig= figure(j);
    j = j+1;
   ha = tight_subplot(numChartPerFig,1,[.003 .03],[.075 .075],[.01 .01]) ;

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
       %plot(x,y);
       bar(edges,y,'histc');
       xlabel('Torque Nm','Fontsize',12');
        ly= ylabel(colHeading(1,Cols), 'Interpreter','none','rot',360,'Fontsize',12);
          set(ly, 'position', get(ly,'position')-[0.5,0,1]); % Move Y label to left
       if Cols ~= (numFig+1)*numChartPerFig
           set(ha(1:numChartPerFig),'XTickLabel','');
       end
         set(ha,'YTickLabel','')
       % set(gca, 'XTick', [-90:10:20],'Fontsize',6);
       %axis([0,12,0.0,1.0]);
        set(gca, 'YLim', [0 1])
            
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
          title ='Torque Histogram - Axis 4';
         annotation('textbox', [0 0.9 1 0.1], ...
                    'String', title, ...
                    'EdgeColor', 'none', ...
                    'HorizontalAlignment', 'center'....
                    ,'Fontsize',14')
                
 
      
   end
 end
         


