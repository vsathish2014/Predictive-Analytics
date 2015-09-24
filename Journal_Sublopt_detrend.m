clc;
clear;

for sheetNo =1:8
     str = strcat('Dataset', num2str(sheetNo));
     data(:,:,sheetNo) = xlsread('All_Robots_data',str, 'A1:O61');
end
     
[~, txt1, ~] = xlsread('All_Robots_data.xlsx','Dataset1','A1:O61');

[~, txt2, ~] = xlsread('All_Robots_data.xlsx','FailureAxis','A1:A6');

%  [num2 txt2 raw2] = xlsread('GearboxFailure_32592728_raw_d0.xlsx','Failure_Type','A1:A1');

 %  x = data1(:,1);
%% Plot the chart 
 
  x = [1:60];
 numFig =0;
 for sheetNo = 1:8
   y_data(:,:,sheetNo) = data(:,1:12,sheetNo); 
   % Normalize the data
   y_min(:,:,sheetNo) = min(y_data(:,:,sheetNo));
   y_max(:,:,sheetNo) = max(y_data(:,:,sheetNo));
   y_diff(:,:,sheetNo) = y_max(:,:,sheetNo) -y_min(:,:,sheetNo);
   y_diff_rep(:,:,sheetNo) = repmat(y_diff(:,:,sheetNo),60,1);
   y_min_rep(:,:,sheetNo)= repmat(y_min(:,:,sheetNo),60,1);
 
   y_data(:,:,sheetNo) = (y_data(:,:,sheetNo) - y_min_rep(:,:,sheetNo))./y_diff_rep(:,:,sheetNo);
  %
   %[maxRows maxCols] = size(y_data);
 end
 %%
 y = zeros(maxRows,1);

%  for numFig = 0:(maxCols/12)-1
  %hFig= figure();
   
%      for Cols = 1:12
%        y(:,1) = y_data(:,Cols); 
%        y_detrend  = detrend(y(:,1));   
%      end

y_data = reshape(y_data,[60,96]);

for cols = 1:96
   
    y_detrend(:,cols) = detrend(y_data(:,cols));
end

   ha = tight_subplot(12,8,[.003 .003],[.005 .005],[.01 .01]) ;

for ii = 1:96; axes(ha(ii)); plot(y_detrend(:,ii)); end

set(ha(1:4),'XTickLabel',''); set(ha,'YTickLabel','')
%    for Cols = 1:12
%        y(:,1) = y_data(:,Cols); 
%        y_detrend  = detrend(y(:,1));         
%      
% % for ii = 1:4; axes(ha(ii)); plot(randn(10,ii)); end 
% % set(ha(1:4),'XTickLabel',''); set(ha,'YTickLabel','')
% %       i = Cols;
% %       if i > 5
% %           i = i - numFig *5
% %       end
%        axes(ha(i));
%        plot(x,unwrap(y_detrend));
%        %xlabel(txt1(1,1));
%         ly= ylabel(txt1(1,Cols), 'Interpreter','none','rot',360,'Fontsize',8);
%         set(ly, 'position', get(ly,'position')-[25,0,0]); % Move Y label to left
% %        if Cols ~= (numFig+1)*12
% %            set(ha(1:12),'XTickLabel','');
% %        end
%          set(ha,'YTickLabel','')
%         set(gca, 'XTick', [0:10:60],'Fontsize',6);
%         
%             
%         set(gca,'ticklength',0.25*get(gca,'ticklength'))
%         set(gca,'tickdir','out')
%         grid off
%         box off
%          set(gca,'PlotBoxAspectRatio',[5  1.25 1])
%          % Draw a line at failure day - 0the day
%          ym = ylim;
%          line ([0 0],ym,'LineStyle',':','Color','r');
%          % Provide a  tile for the all the sub plots
%           title = txt2(sheetNo);
%          annotation('textbox', [0 0.9 1 0.1], ...
%                     'String', title, ...
%                     'EdgeColor', 'none', ...
%                     'HorizontalAlignment', 'center')
%                 
%          %set( gca, 'Units', 'normalized', 'Position', [0 0 1 1] );
%          %set(hFig, 'Position', [x y 10 10])
% 
%          % set(gca,'DataAspectRatio',[1000000 1 75000])
%       
%    end
