clc;
clear;
close all;
% Dock all the charts  as tabs
% set(0,'DefaultFigureWindowStyle','docked')
 % Controller ID
  
 % failure day
%  f_day = 60;
%  x_day = 40;
%  x_start= 1;
files = dir('*.xlsx');
for file = files'  
 
 %Read distrubitions      
  
       data = readtable(file.name,'Sheet',1); 
        ColHeader_temp =   data.Properties.VariableNames;
       data = table2cell(data(1:61,2:end)); 
       data = cell2mat(data);
       data_new(:,:,1) = data(:,1:36);
       data_new(:,:,2) = data(:,37:72);
       data_new(:,:,3) = data(:,73:108);
       data_new(:,:,4) = data(:,109:144);
       data_new(:,:,5) = data(:,145:180);
       data_new(:,:,6) = data(:,181:216);
       removeCols = [1:216];
       data_rest = data;
       data_rest(:,removeCols)= [];
       
       % Find the absolute difference bewtween rows
       diff_data_rest = abs(diff(data_rest',1,2));
       abs_diff_data_rest = diff_data_rest';
     

  
   % Create KL distance between  first sample to subsequent samples

 % x axis data
% x = data_new(1:f_day,1,2);
 for j = 1: 6
     clear distance_a_all distance_s_all distance_t_all
     data_a = data_new(:,1:12,j);
     data_s = data_new(:,13:24,j);
     data_t = data_new(:,25:36,j);
  

     [cRows cCols] =size(data_new);

            for counter = 2:cRows
                    % distance_a(counter) = kldiv(data_a(1,:) ,data_a(counter,:)+eps);
                      distance_a(counter) =kldiv(data_a(1,:) ,data_a(counter,:)+eps);
                      distance_s(counter) =kldiv(data_s(1,:) ,data_s(counter,:)+eps);
                     distance_t(counter) =kldiv(data_t(1,:),data_t(counter,:)+eps);
            end
       % kldiv_dist(axis,:,fc_axis) = distance(end,:);
      % distance_a = distance_a';
      
        distance_a_all(:,:,j) = distance_a';
        distance_s_all(:,:,j) = distance_s';
         distance_t_all(:,:,j) = distance_t';
  
       
 end
        distance_a_all = reshape(distance_a_all, cRows,6);
        distance_s_all = reshape(distance_s_all, cRows,6);
        distance_t_all = reshape(distance_t_all, cRows,6);
        
        KL_all = cat(2,distance_a_all,distance_s_all,distance_t_all);
        all_data = cat(2,data_rest(2:end,:),KL_all(2:end,:));     
         
          
       
 
 % Create KL distance between two consecutive samples

 % x axis data
% x = data_new(1:f_day,1,2);
 for j = 1: 6
     clear distance_a_r_all distance_s_r_all distance_t_r_all
     data_a_r = data_new(:,1:12,j);
     data_s_r = data_new(:,13:24,j);
     data_t_r = data_new(:,25:36,j);
  

     [cRows cCols] =size(data_new);

            for counter = 2:cRows
                    % distance_a(counter) = kldiv(data_a(1,:) ,data_a(counter,:)+eps);
                      distance_a_r(counter) =kldiv(data_a_r(counter-1,:) ,data_a_r(counter,:)+eps);
                      distance_s_r(counter) =kldiv(data_s_r(counter-1,:) ,data_s_r(counter,:)+eps);
                     distance_t_r(counter) =kldiv(data_t_r(counter-1,:),data_t_r(counter,:)+eps);
            end
       % kldiv_dist(axis,:,fc_axis) = distance(end,:);
      % distance_a = distance_a';
      
        distance_a_r_all(:,:,j) = distance_a_r';
        distance_s_r_all(:,:,j) = distance_s_r';
         distance_t_r_all(:,:,j) = distance_t_r';
  
       
 end
        distance_a_r_all = reshape(distance_a_r_all, cRows,6);
        distance_s_r_all = reshape(distance_s_r_all, cRows,6);
        distance_t_r_all = reshape(distance_t_r_all, cRows,6);
        
        diffKL_all = cat(2,distance_a_r_all,distance_s_r_all,distance_t_r_all);
        
        diff_all_data = cat(2,abs_diff_data_rest,diffKL_all(2:end,:));
        all_data_with_diff = cat(2,all_data,diff_all_data);
        
        
%Print the file to excel  
Col_header_1 = {'KL_A_1','KL_A_2','KL_A_3','KL_A_4','KL_A_5','KL_A_6',...
              'KL_S_1','KL_S_2','KL_S_3','KL_S_4','KL_S_5','KL_S_6',...
              'KL_T_1','KL_T_2','KL_T_3','KL_T_4','KL_T_5','KL_T_6'};
Col_header_2 = ColHeader_temp(:,218:316);   
Col_header = cat(2, Col_header_2,Col_header_1);
diff_Col_header = strcat('diff_',Col_header);
Col_header_all = cat(2,Col_header,diff_Col_header);

stat_print = fullfile('C:\Users\INSAV3\Predictive Analytics\DataSets\ETFA-Data', file.name);
% xlswrite(stat_print, Col_header,'KL_all','A1');      
% xlswrite(stat_print, KL_all(2:end,:),'KL_all','A2'); 
% Write training data set - distinct measures
xlswrite(stat_print, Col_header,'dist_data_Trg','A1');       
xlswrite(stat_print, all_data(1:40,:),'dist_data_Trg','A2'); 

% Write test data set -  distinct measures
xlswrite(stat_print, Col_header,'dist_data_Test','A1');       
xlswrite(stat_print, all_data(41:60,:),'dist_data_Test','A2'); 

% Write training data set - diff measures
xlswrite(stat_print, diff_Col_header,'diff_data_Trg','A1');       
xlswrite(stat_print, diff_all_data(1:40,:),'diff_data_Trg','A2'); 

% Write test data set -  diff measures
xlswrite(stat_print, diff_Col_header,'diff_data_Test','A1');       
xlswrite(stat_print, diff_all_data(41:60,:),'diff_data_Test','A2'); 


% Write training data set - all measures
xlswrite(stat_print, Col_header_all,'all_data_Trg','A1');       
xlswrite(stat_print, all_data_with_diff(1:40,:),'all_data_Trg','A2'); 

% Write test data set - all measures
xlswrite(stat_print, Col_header_all,'all_data_Test','A1');       
xlswrite(stat_print, all_data_with_diff(41:60,:),'all_data_Test','A2'); 




end
 
%Create Missing values for 1 dimensional space
% clear x x1 y1 x_new y_new x_y_new y xi result
%      data = readtable('10_NoF_All_37590669_IRB6640.xlsx','Sheet',1);
%       data = table2cell(data(:,2:end)); 
%      data_new = cell2mat(data);
% 
%      x = [0:1:60]';
%   
%      y_new = data_new;
% 
%      x_y_new = [x, y_new];
%      
% 
%      for i = 2: 316
%       y = x_y_new(:,i);
% 
%        xi=x(find(~isnan(y)));yi=y(find(~isnan(y)));
%        result(:,i-1)=interp1(xi,yi,x,'linear');
%      end
% 
%      new_data(:,:) = [x, result];


