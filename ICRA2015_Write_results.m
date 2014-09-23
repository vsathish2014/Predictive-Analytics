clc;
clear all;
 
plot_trajectory = 1;
plot_fc_pct = 10;
plot_axis = 1;
switch plot_trajectory
    case 1 
        switch plot_fc_pct
            case 10
                load ICRA2015_Tajectory1_FC_10pct_22092014_5_days_All.mat
            case 20
                load ICRA2015_Tajectory1_FC_20pct_22092014_5_days_All.mat
            case 0
                load ICRA2015_Tajectory1_NO_FC_20092014_5_days_All.mat
        end
    case 2 
        switch plot_fc_pct
            case 10
                load ICRA2015_Tajectory2_FC_10pct_22092014_5_days_All.mat

            case 20
                load ICRA2015_Tajectory2_FC_20pct_22092014_5_days_All.mat
                
            case 0
                load ICRA2015_Tajectory1_NO_FC_20092014_5_days_All.mat
    
        end
    case 3 
        switch plot_fc_pct
            case 10
                load ICRA2015_Tajectory3_FC_10pct_21092014_5_days_All.mat

            case 20
                load ICRA2015_Tajectory3_FC_20pct_21092014_5_days_All.mat
                
            case 0
                load ICRA2015_Tajectory1_NO_FC_20092014_5_days_All.mat

        end       
     
end

% Sample the signal - hourly 
%    time_hours = [1:6:120];
    % tau_fc_pn_mn = tau_fc_pn_mn(:,:,2);
    
    tau_fc_pn_mn_2(:,:,:) = tau_fc_pn_mn(2:end,:,:);    
      
    tau_fc_pn_mn_hs = tau_fc_pn_mn_2(4:360:end,:,:);
    
%  % teake absolute value of torque   
%     for i= 1: 6
%          x(:,:,i) = abs(tau_fc_pn_mn_2(:,:,i));
%         % x(:,:,i) = (tau_fc_pn_mn_2(:,:,i));
%     end
%  % Avergae hourly 
%  
%  for i = 1 : 6
%  tau_fc_pn_mn_avg_1(:,:,i) = mean(reshape(x(:,1,i),360,[]))';
%  tau_fc_pn_mn_avg_2(:,:,i) = mean(reshape(x(:,2,i),360,[]))';
%  tau_fc_pn_mn_avg_3(:,:,i) = mean(reshape(x(:,3,i),360,[]))';
%  tau_fc_pn_mn_avg_4(:,:,i) = mean(reshape(x(:,4,i),360,[]))';
%  tau_fc_pn_mn_avg_5(:,:,i) = mean(reshape(x(:,5,i),360,[]))';
%  tau_fc_pn_mn_avg_6(:,:,i) = mean(reshape(x(:,6,i),360,[]))';
%  
%  tau_fc_pn_mn_avg(:,:,i) = cat(2,tau_fc_pn_mn_avg_1(:,:,i),tau_fc_pn_mn_avg_2(:,:,i),tau_fc_pn_mn_avg_3(:,:,i),tau_fc_pn_mn_avg_4(:,:,i),...
%                             tau_fc_pn_mn_avg_5(:,:,i),tau_fc_pn_mn_avg_6(:,:,i));
%  end
%  
 
 
 
 
 switch plot_fc_pct
        case 10
        % Writing data to a file
        col_header ={'Axis_1','Axis_2','Axis_3','Axis_4','Axis_5','Axis_6'};

        tau_print = fullfile('c:\results', 'Traj_1_torque_fc_10pct.xlsx');
        xlswrite(tau_print,col_header,'Torques_fc_1','A1');
        xlswrite(tau_print,tau_fc_pn_mn_hs(:,:,1),'Torques_fc_1','A2');
        xlswrite(tau_print,col_header,'Torques_fc_2','A1');
        xlswrite(tau_print,tau_fc_pn_mn_hs(:,:,2),'Torques_fc_2','A2');
        xlswrite(tau_print,col_header,'Torques_fc_3','A1');
        xlswrite(tau_print,tau_fc_pn_mn_hs(:,:,3),'Torques_fc_3','A2');
        xlswrite(tau_print,col_header,'Torques_fc_4','A1');
        xlswrite(tau_print,tau_fc_pn_mn_hs(:,:,4),'Torques_fc_4','A2');
        xlswrite(tau_print,col_header,'Torques_fc_5','A1');
        xlswrite(tau_print,tau_fc_pn_mn_hs(:,:,5),'Torques_fc_5','A2');
        xlswrite(tau_print,col_header,'Torques_fc_6','A1');
        xlswrite(tau_print,tau_fc_pn_mn_hs(:,:,6),'Torques_fc_6','A2');

        case 20
        % Writing data to a file
        col_header ={'Axis_1','Axis_2','Axis_3','Axis_4','Axis_5','Axis_6'};

        tau_print = fullfile('c:\results', 'Traj_1_torque_fc_20pct.xlsx');
        xlswrite(tau_print,col_header,'Torques_fc_1','A1');
        xlswrite(tau_print,tau_fc_pn_mn_hs(:,:,1),'Torques_fc_1','A2');
        xlswrite(tau_print,col_header,'Torques_fc_2','A1');
        xlswrite(tau_print,tau_fc_pn_mn_hs(:,:,2),'Torques_fc_2','A2');
        xlswrite(tau_print,col_header,'Torques_fc_3','A1');
        xlswrite(tau_print,tau_fc_pn_mn_hs(:,:,3),'Torques_fc_3','A2');
        xlswrite(tau_print,col_header,'Torques_fc_4','A1');
        xlswrite(tau_print,tau_fc_pn_mn_hs(:,:,4),'Torques_fc_4','A2');
        xlswrite(tau_print,col_header,'Torques_fc_5','A1');
        xlswrite(tau_print,tau_fc_pn_mn_hs(:,:,5),'Torques_fc_5','A2');
        xlswrite(tau_print,col_header,'Torques_fc_6','A1');
        xlswrite(tau_print,tau_fc_pn_mn_hs(:,:,6),'Torques_fc_6','A2');
        case 0
        % Writing data to a file
        col_header ={'Axis_1','Axis_2','Axis_3','Axis_4','Axis_5','Axis_6'};

        tau_print = fullfile('c:\results', 'Traj_1_torque_fc_0pct.xlsx');
        xlswrite(tau_print,col_header,'Torques_fc_1','A1');
        xlswrite(tau_print,tau_fc_pn_mn_hs(:,:,1),'Torques_fc_1','A2');
         
 end
