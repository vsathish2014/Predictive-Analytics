clc;
clear;
close all;
% Dock all the charts  as tabs
 set(0,'DefaultFigureWindowStyle','docked')
 % Controller ID
 s4= 'Gear box failure : 23535801   ';
 % failure day
 f_day = 60;
 x_day = 40;
 x_start= 1;
 for i= 1:6
 
%Read distrubitions      
       % data =readtable('GBF_L10h_Torque_KL_5283944_IRB6600.xlsx','Sheet',i+1);
      %data =readtable('GBF_L10h_Torque_KL_32592728_Rob2_IRB6640.xlsx','Sheet',i+1);
       % data = readtable('NoGBF_L10h_Torque_KL_1566530_IRB6600.xlsx','Sheet',i+1); 
       % data = readtable('NoGBF_L10h_Torque_KL_36750658_IRB6640.xlsx','Sheet',i+1);
       %data = readtable('5_NoGBF_L10h_Torque_KL_5284258_IRB6600.xlsx','Sheet',i+1); 
       %data = readtable('6_NoGBF_L10h_Torque_KL_33252794_IRB6640.xlsx','Sheet',i+1); 
       data = readtable('7_GB_Torque_23535801_IRB6600_CNV1.xlsx','Sheet',i+1);
       
       
     
 data = table2cell(data(1:60,3:end)); 
 data_new(:,:,i) = cell2mat(data);
 
 end 
 % x axis data
 x = data_new(1:f_day,1,2);
 for j = 1: 6
     data_s = data_new(:,3:14,j);
    % data_a = data(:,3:14);
     data_t = data_new(:,15:26,j);

     [cRows cCols] =size(data_new);

            for counter = 2:cRows
                    % distance_a(counter) = kldiv(data_a(1,:) ,data_a(counter,:)+eps);
                      distance_s(counter) =kldiv(data_s(1,:) ,data_s(counter,:)+eps);
                     distance_t(counter) =kldiv(data_t(1,:) ,data_t(counter,:)+eps);
            end
       % kldiv_dist(axis,:,fc_axis) = distance(end,:);
      % distance_a = distance_a';
         distance_s_all(:,:,j) = distance_s';
         distance_t_all(:,:,j) = distance_t';
         avgSpeed_all(:,:,j) = data_new(:,27,j);
         avgTorque_all(:,:,j) = data_new(:,28,j);
         SISL10h_all(:,:,j) = data_new(:,2,j);
         


 end   
         distance_s_all = reshape(distance_s_all, cRows,6);
        distance_t_all = reshape(distance_t_all, cRows,6);
        avgSpeed_all = reshape(avgSpeed_all,cRows,6);
        avgTorque_all = reshape(avgTorque_all,cRows,6);
        SISL10h_all = reshape(SISL10h_all, cRows, 6);
 
   y_data = horzcat(  distance_s_all,distance_t_all, avgSpeed_all, avgTorque_all);
   
% Create KL distance between two consecutive samples

 % x axis data
 x = data_new(1:f_day,1,2);
 for j = 1: 6
     data_s_r = data_new(:,3:14,j);
    % data_a = data(:,3:14);
     data_t_r = data_new(:,15:26,j);

     [cRows cCols] =size(data_new);

            for counter = 2:cRows
                    % distance_a(counter) = kldiv(data_a(1,:) ,data_a(counter,:)+eps);
                      distance_s_r(counter) =kldiv(data_s_r(counter-1,:) ,data_s_r(counter,:)+eps);
                     distance_t_r(counter) =kldiv(data_t_r(counter-1,:),data_t_r(counter,:)+eps);
            end
       % kldiv_dist(axis,:,fc_axis) = distance(end,:);
      % distance_a = distance_a';
        distance_s_r_all(:,:,j) = distance_s_r';
         distance_t_r_all(:,:,j) = distance_t_r';
  
         

 

 end   
        distance_s_r_all = reshape(distance_s_r_all, cRows,6);
        distance_t_r_all = reshape(distance_t_r_all, cRows,6);
   


   clear lags;
clear c;

% % Read the data
%      KL_data = xlsread('Trajectory1_Axis1_FC_10pct_09142014.xlsx','KL_All','A2:F145');
   % entropy_data = xlsread('Entropy_08052014.xlsx','F_A2','A2:F13');
% permuted_kldiv_dist_hs = permute(kldiv_dist_hs,[2,1,3]);  
    
   
  %  z =distance_t_all(41:f_day,:);
   z =distance_t_all(x_start:x_day,:);
   % z = SISL10h_all(2:61,:);
  % z = avgTorque_all(2:x_day,:);
    
    [cRows_m cCols_m] = size(z);
     
    min_KLD = kron(min(z),ones(cRows_m,1));
    max_KLD = kron(max(z),ones(cRows_m,1));
    
    KL_data_n(:,:) = (z- min_KLD)./(max_KLD -min_KLD);
    KL_data_n(isnan(KL_data_n))=0;
    KL_data_n(KL_data_n==0)=eps;
  
  
 k = 1;
    for j = 1:6

        for i = 1: 6             
                    % [c(:,:,k) lags(:,:,k)] = xcorr( (KL_data_n(:,j,fc_axis)),   (KL_data_n(:,i,fc_axis)),'unbiased');   %// Cross correlation
                     [c(:,:,k) lags(:,:,k)] = xcorr( (KL_data_n(:,j)),   (KL_data_n(:,i)),'coeff');
                     %   [c(:,:,k) lags(:,:,k)] = xcorr( zscore(permuted_kldiv_dist_hs(:,j,fc_axis)),   zscore(permuted_kldiv_dist_hs(:,i,fc_axis)),'unbiased'); 
          
                     k = k+1;
        end

    end

    lags = reshape(lags,[2*cRows_m-1,36]);
    %lags = reshape(lags,[119,36]);
     c = reshape(c,[2*cRows_m-1,36]);
    %c = reshape(c,[119,36]);
    frow = 1 ;
    lrow =2*cRows_m-1;

    for i = 1 : 36
            [m,id]=max(c(frow:lrow,i));
            tauid=lags(frow-1+id);
            tauc =c(frow-1+id);
            id_1(i) = tauid;
            c_1(i) = tauc;
    end
 % clear c;
 % clear lags;
id_t(:,:) =   reshape(id_1,6,6);
c_t(:,:) =  reshape(c_1,6,6);
 

   
   
   % Plot charts
   %    %y_data = data1(:,2:13);
   y_data_l10h = SISL10h_all(1:f_day,:);
        numChartPerFig = 6;
    numChartPerCol = 3 ;
  
    colHeading ={'L10h_Axis1', 'L10h_Axis2','L10h_Axis3','L10h_Axis4','L10h_Axis5','L10h_Axis6'}

      [maxRows_p maxCols_p] = size(y_data_l10h);
     
    
   y = zeros(maxRows_p,1);
   
   
%  % Original data plots
%  for numFig = 0:fix(maxCols_p/numChartPerFig)-1
%   hFig= figure();
%     
%    ha = tight_subplot(3,2,[.025 .01],[.08 .08],[.005 .005]) ;
% 
%    for Cols = numFig*numChartPerFig+1 : (numFig+1)*numChartPerFig
%        y(:,1) = (y_data_l10h(:,Cols)); 
%        %y_detrend  = detrend(y(:,1));         
%  
%       i = Cols;
%       if i > numChartPerFig
%           i = i - numFig *numChartPerFig;
%       end
% 
%      
%       subplot(ha(i));
%       plot(x, y );
%     
% %         hold on;
% %         y_s1=[min(y) max(y)];
% %          x_s1 = [day_of_failure  day_of_failure ];
% %          line(x_s1,y_s1,'Color','r','LineWidth',2,'LineStyle','--')
% %          set(gca,'YLim', y_s1);
% %  
%          ly= ylabel(colHeading(1,Cols), 'Interpreter','none','rot',90,'Fontsize',12);
%          %set(ly, 'position', get(ly,'position')-[0,0,25]); % Move Y label to left
%          set(ly, 'Units', 'Normalized', 'Position', [-0.1, 0.5, 0]);
%           ly;
%          %if Cols ~= (numFig+1)*numChartPerCol
%              
%          if Cols == numChartPerFig || Cols == numChartPerFig-1
%             
%               xlabel('Time (days)','FontSize',12);    
%          else
%               set(ha(1:numChartPerFig),'XTickLabel','');
%          end         
%  
% %         set(gca, 'XTick', [min_x:10:max_x],'Fontsize',6);        
%             
%         set(gca,'ticklength',0.25*get(gca,'ticklength'))
%         set(gca,'tickdir','out')
%         grid off
%         box off
% 
%          set(gca,'PlotBoxAspectRatio',[5  1.5 1])        
%  
%           
%           title = strcat(s4, ' -Measurement Trend over Time ')
%                   annotation('textbox', [0.45 .9  1 0.1], ...
%                     'String', title, ...
%                     'EdgeColor', 'none', ...
%                     'HorizontalAlignment', 'left',....
%                     'FontSize', 14)
%           
%       
%    end
%  end
%  
%   % Plot charts
%    %    %y_data = data1(:,2:13);
%    y_data_t = distance_t_all(1:f_day,:);
%         numChartPerFig = 6;
%     numChartPerCol = 3 ;
%   
%     colHeading ={'KL_T_Axis1', 'KL_T_Axis2','KL_T_Axis3','KL_T_Axis4','KL_T_Axis5','KL_T_Axis6'}
% 
%       [maxRows_t maxCols_t] = size(y_data_t);
%      
%     
%    y = zeros(maxRows_t,1);
%    
%    x_lim = max(y_data_t(:)); 
%  % Original data plots
%  for numFig = 0:fix(maxCols_t/numChartPerFig)-1
%   hFig= figure();
%    
%    ha = tight_subplot(3,2,[.025 .01],[.08 .08],[.005 .005]) ;
% 
%    for Cols = numFig*numChartPerFig+1 : (numFig+1)*numChartPerFig
%        y(:,1) = (y_data_t(:,Cols)); 
%        %y_detrend  = detrend(y(:,1));         
%  
%       i = Cols;
%       if i > numChartPerFig
%           i = i - numFig *numChartPerFig;
%       end
%       
%      
%       subplot(ha(i));
%       plot(x, y );
%     
% %         hold on;
% %         y_s1=[min(y) max(y)];
% %          x_s1 = [day_of_failure  day_of_failure ];
% %          line(x_s1,y_s1,'Color','r','LineWidth',2,'LineStyle','--')
% %          set(gca,'YLim', y_s1);
% %  
%          ly= ylabel(colHeading(1,Cols), 'Interpreter','none','rot',90,'Fontsize',12);
%          %set(ly, 'position', get(ly,'position')-[0,0,25]); % Move Y label to left
%          set(ly, 'Units', 'Normalized', 'Position', [-0.1, 0.5, 0]);
%           ly;
%          %if Cols ~= (numFig+1)*numChartPerCol
%              
%          if Cols == numChartPerFig || Cols == numChartPerFig-1
%             
%               xlabel('Time (days)','FontSize',12);    
%          else
%               set(ha(1:numChartPerFig),'XTickLabel','');
%          end         
%  
%         
% %         set(gca, 'XTick', [min_x:10:max_x],'Fontsize',6);        
%          axis([0,f_day,0,x_lim]);   
%         set(gca,'ticklength',0.25*get(gca,'ticklength'))
%         set(gca,'tickdir','out')
%         grid off
%         box off
% 
%          set(gca,'PlotBoxAspectRatio',[5  1.5 1])        
%  
%           
%           title = strcat(s4, ' - KL Torque over Time ');
%                   annotation('textbox', [0.45 .9  1 0.1], ...
%                     'String', title, ...
%                     'EdgeColor', 'none', ...
%                     'HorizontalAlignment', 'left',....
%                     'FontSize', 14)
%           
%       
%    end
%  end
 
 
 
 
% figure(2);
% clear title 
% x = [1:1:cRows];
%  subplot(3,1,1);
% plot(l10h);
% title_a=strcat(s4,': L10h over time');
% title(title_a);
% title(title_a,'FontSize',14);
% subplot(3,1,2)
% 
% plot( x,distance_s );
% title_b=strcat(s4,': KL distance -Hist data for Moved Rad, Speed and Torque');
% title(title_b,'FontSize',14);
% legend( 'KL speed' );
% subplot(3,1,3)
% 
% plot(  x,distance_t);
% title_b=strcat(s4,': KL distance -Hist data for Moved Rad, Speed and Torque');
% title(title_b,'FontSize',14);
% legend(   'KL torque');
% 
% 
% figure(3);
% clear title 
% x = [1:1:cRows];
%  subplot(2,2,1);
% plot(l10h);
% title_a=strcat(s4,': L10h over time');
% title(title_a);
% title(title_a,'FontSize',14);
% % 
% % subplot(2,2,2)
% % plot(x,movedRad);
% % title_b=strcat(s4,': Moved Radians');
% % title(title_b,'FontSize',14);
%  
% subplot(2,2,3)
% plot(x,avgSpeed);
% title_b=strcat(s4,': Avg Speed (rpm)');
% title(title_b,'FontSize',14);
% 
% subplot(2,2,4)
% plot(x,avgTorque);
% title_b=strcat(s4,': Avg Torque (Nm)');
% title(title_b,'FontSize',14);
%  
%  
%  
% % Saving all the figures into a file   
%   h = get(0,'children');
%     for i=1:length(h)
%         saveas(h(i), ['figure' num2str(i)], 'fig');
%     end 
%     daytime = clock;
%     savdir = 'C:\Users\INSAV3\Predictive Analytics\Figures\Gearbox\';
%     s1 = 'Motor Failure Measurement Trend';
%      s2= strcat(num2str(daytime(1)),num2str(daytime(2)),num2str(daytime(3)));
%     s3= '.fig'
%     s = strcat(savdir,s1,s4,'_',s2,s3);
%     
%   savefig(h,s)
%    
%      set(0,'DefaultFigureWindowStyle','normal') ;
%    
   
   