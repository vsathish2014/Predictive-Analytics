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
       % data =readtable('GBF_L10h_Torque_KL_5283944_IRB6600.xlsx','Sheet',i+1);
      %data =readtable('GBF_L10h_Torque_KL_32592728_Rob2_IRB6640.xlsx','Sheet',i+1);
       % data = readtable('NoGBF_L10h_Torque_KL_1566530_IRB6600.xlsx','Sheet',i+1); 
       % data = readtable('NoGBF_L10h_Torque_KL_36750658_IRB6640.xlsx','Sheet',i+1);
       %data = readtable('5_NoGBF_L10h_Torque_KL_5284258_IRB6600.xlsx','Sheet',i+1); 
       %data = readtable('6_NoGBF_L10h_Torque_KL_33252794_IRB6640.xlsx','Sheet',i+1); 
       data = readtable(file.name,'Sheet',1);       
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
       abs_diff_data_rest = diff_data_rest'
     
  
 
 % Create KL distance between two consecutive samples

 % x axis data
% x = data_new(1:f_day,1,2);
 for j = 1: 6
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
        
        KL_all = cat(2,distance_a_r_all,distance_s_r_all,distance_t_r_all);

%Print the file to excel  
Col_header = {'KL_A_1','KL_A_2','KL_A_3','KL_A_4','KL_A_5','KL_A_6',...
              'KL_S_1','KL_S_2','KL_S_3','KL_S_4','KL_S_5','KL_S_6',...
              'KL_T_1','KL_T_2','KL_T_3','KL_T_4','KL_T_5','KL_T_6'};
stat_print = fullfile('C:\ABB\4-DM\DataSets\FieldFailures\Gearbox\Test', file.name);
xlswrite(stat_print, Col_header,'KL_all','A1');      
xlswrite(stat_print, KL_all(2:end,:),'KL_all','A2'); 
      
xlswrite(stat_print, abs_diff_data_rest,'Data_rest','A2'); 

end
 