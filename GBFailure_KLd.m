% KL distnace

clc;
clear;

% Read the data
    data = xlsread('Gearboxfailure_5283944_Day.xlsx','Axis1','A2:M167');
            for counter = 2:166
                 distance_n1(counter) = kldiv(data(1,2:end) ,data(counter,2:end)+eps);
            end
 %   kldiv_dist(axis,:,fc_axis) = distance(end,:);

 
    data = xlsread('Gearboxfailure_5283944_Day.xlsx','Axis2','A2:M167');
            for counter = 2:166
                 distance_n2(counter) = kldiv(data(1,2:end) ,data(counter,2:end)+eps);
     
            end
        
            
   data = xlsread('Gearboxfailure_5283944_Day.xlsx','Axis3','A2:M167');
            for counter = 2:166
                 distance_n3(counter) = kldiv(data(1,2:end) ,data(counter,2:end)+eps);
     
            end
 
             
   data = xlsread('Gearboxfailure_5283944_Day.xlsx','Axis4','A2:M167');
            for counter = 2:166
                 distance_n4(counter) = kldiv(data(1,2:end) ,data(counter,2:end)+eps);
     
            end
            
    data = xlsread('Gearboxfailure_5283944_Day.xlsx','Axis5','A2:M167');
            for counter = 2:166
                 distance_n5(counter) = kldiv(data(1,2:end) ,data(counter,2:end)+eps);
     
            end
            
 
            
   data = xlsread('Gearboxfailure_5283944_Day.xlsx','Axis6','A2:M167');
            for counter = 2:166
                 distance_n6(counter) = kldiv(data(1,2:end) ,data(counter,2:end)+eps);
     
            end
            
 
 
    distance = vertcat(distance_n1, distance_n2,distance_n3,distance_n4,distance_n5,distance_n6)    
   KL_distance = distance'
      [maxRows maxCols] = size(KL_distance);
 
    numChartPerFig = 6;
    numChartPerCol = 6 ;
    
         
%    x = [1:334]';
     x = data(:,1);
% %     ds1 = data1(:,38:46);
% %     y_data = cat(2,weightedMotionHist,ds1);
      y_data = KL_distance(:,1:end);
      
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
    
   ha = tight_subplot(6,1,[.003 .003],[.05 .07],[.005 .005]) ;

   for Cols = numFig*numChartPerFig+1 : (numFig+1)*numChartPerFig
       y(:,1) = y_data(:,Cols); 
      %y_detrend  = detrend(y(:,1));         
     
% for ii = 1:4; axes(ha(ii)); plot(randn(10,ii)); end 
% set(ha(1:4),'XTickLabel',''); set(ha,'YTickLabel','')
      i = Cols;
      if i > numChartPerFig
          i = i - numFig *numChartPerFig
      end

     
      subplot(ha(i));
       plot(x,y );

     
         
%       xlabel(txt1(1,1));
%        ly= ylabel(colHeading(1,Cols), 'Interpreter','none','rot',90,'Fontsize',8);
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
       % title = 'Time ';
%          annotation('textbox', [0 0.9 1 0.1], ...
%                     'String', title, ...
%                     'EdgeColor', 'none', ...
%                     'HorizontalAlignment', 'center')
          
          title = 'KL Distnace over time (Axis 1 to 6)'
                  annotation('textbox', [0.45 .875 1 0.1], ...
                    'String', title, ...
                    'EdgeColor', 'none', ...
                    'HorizontalAlignment', 'left')
          
      
   end
 end
 
% Cross correlation 
  
     z = KL_distance  ;
     
    min_KLD = kron(min(z),ones(166,1));
    max_KLD = kron(max(z),ones(166,1));
    
    KL_data_n(:,:) = (z- min_KLD)./(max_KLD -min_KLD);
    KL_data_n(isnan(KL_data_n))=0;
    KL_data_n(KL_data_n==0)=eps;
     
  
 k = 1
    for j = 1:6

        for i = 1: 6             
                      %   [c(:,:,k) lags(:,:,k)] = xcorr( (KL_data_n(:,j)),   (KL_data_n(:,i)),'unbiased');   %// Cross correlation
                     [c(:,:,k) lags(:,:,k)] = xcorr( (KL_data_n(:,j)),   (KL_data_n(:,i)),'coeff');
                     %   [c(:,:,k) lags(:,:,k)] = xcorr( zscore(permuted_kldiv_dist_hs(:,j,fc_axis)),   zscore(permuted_kldiv_dist_hs(:,i,fc_axis)),'unbiased'); 
         k = k+1  

        end

    end


    lags = reshape(lags,[331,36]);
    %lags = reshape(lags,[119,36]);
     c = reshape(c,[331,36]);
    %c = reshape(c,[119,36]);
    frow = 1 ;
    lrow =331;

    for i = 1 : 36
            [m,id]=max(c(frow:lrow,i));
            tauid=lags(frow-1+id);
            tauc =c(frow-1+id);
            id_1(i) = tauid;
            c_1(i) = tauc;
    end
%   clear c;
%   clear lags;
id_t(:,:) = reshape(id_1,6,6);
c_t(:,:) = reshape(c_1,6,6);
 
 