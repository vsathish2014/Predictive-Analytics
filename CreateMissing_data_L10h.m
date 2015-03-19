clc;
clear;
close all;
for  j = 1:6
     clear x x1 y1 x_new y_new x_y_new y xi result
     data = readtable('NoGBF_L10h_Torque_KL_1566530_IRB6600.xlsx','Sheet',j+1);
      data = table2cell(data(:,3:end)); 
     data_new = cell2mat(data);

     x = [0:1:107]';
     x1 = data_new(:,1);
     y1 = data_new(:,2:end);
     x_new = [x1; setdiff(x,x1)];
     y_new = [y1; NaN(48,27)];

     x_y_new = [x_new, y_new];
     x_y_new = sortrows(x_y_new);

     for i = 2: 28
      y = x_y_new(:,i);

       xi=x(find(~isnan(y)));yi=y(find(~isnan(y)));
       result(:,i-1)=interp1(xi,yi,x,'linear');
     end

     new_data(:,:,j) = [x, result];
end

col_header ={'Axis_1','Axis_2','Axis_3','Axis_4','Axis_5','Axis_6'};

        tau_print = fullfile('C:\Users\INSAV3\Predictive Analytics\DataSets\ETFA-Data', 'NoGBF_L10h_Torque_KL_1566530_IRB6600.xlsx');
        xlswrite(tau_print,col_header,'Axis_1_m','A1');
        xlswrite(tau_print,new_data(:,:,1),'Axis_1_m','A2');
        xlswrite(tau_print,col_header,'Axis_2_m','A1');
        xlswrite(tau_print,new_data(:,:,2),'Axis_2_m','A2');
        xlswrite(tau_print,col_header,'Axis_3_m','A1');
        xlswrite(tau_print,new_data(:,:,3),'Axis_3_m','A2');
        xlswrite(tau_print,col_header,'Axis_4_m','A1');
        xlswrite(tau_print,new_data(:,:,4),'Axis_4_m','A2');
        xlswrite(tau_print,col_header,'Axis_5_m','A1');
        xlswrite(tau_print,new_data(:,:,5),'Axis_5_m','A2');
        xlswrite(tau_print,col_header,'Axis_6_m','A1');
        xlswrite(tau_print,new_data(:,:,6),'Axis_6_m','A2');


%  y =data_new(:,1);
%  result=interp1(x,yi,x,'linear');