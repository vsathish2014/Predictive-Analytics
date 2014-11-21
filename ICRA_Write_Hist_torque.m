clc;
clear all;
 
plot_trajectory = 3;
plot_fc_pct = 0;
plot_axis = 1;
switch plot_trajectory
    case 1
        switch plot_fc_pct
            case 10
                load ICRA2015_Tajectory1_FC_10pct_24092014_5_days_All_Run1.mat
            case 20
                load ICRA2015_Tajectory1_FC_20pct_24092014_5_days_All_Run1.mat
            case 0
                load ICRA2015_Tajectory1_NO_FC_25092014_5_days_All.mat
        end
    case 2 
        switch plot_fc_pct
            case 10
                load ICRA2015_Tajectory2_FC_10pct_24092014_5_days_All_Run1.mat

            case 20
                load ICRA2015_Tajectory2_FC_20pct_24092014_5_days_All_Run1.mat
                
            case 0
                load ICRA2015_Tajectory2_NO_FC_25092014_5_days_All.mat
    
        end
    case 3 
        switch plot_fc_pct
            case 10
                load ICRA2015_Tajectory3_FC_10pct_24092014_5_days_All_Run1.mat

            case 20
                load ICRA2015_Tajectory3_FC_20pct_24092014_5_days_All_Run1.mat
                
            case 0
                load ICRA2015_Tajectory3_NO_FC_25092014_5_days_All.mat

        end       
     
end

% Sample the signal - hourly 
%    time_hours = [1:6:120];
    % tau_fc_pn_mn = tau_fc_pn_mn(:,:,2);
    
   % tau_fc_pn_mn_2(:,:,:) = tau_fc_pn_mn(2:end,:,:);    
      
   % tau_fc_pn_mn_hist = tau_fc_pn_mn_2(4:360:end,:,:);
    
 
 
 
            tau_fc_pn_mn_hist(:,:,:)=  abs(tau_fc_pn_mn(:,:,:)) ;
            
 
  
 switch plot_fc_pct
        case 10
        % Writing data to a file
        col_header ={'Axis_1','Axis_2','Axis_3','Axis_4','Axis_5','Axis_6'};

        tau_print = fullfile('C:\IIITD\Publications\ICRA2015\Results', 'Hist_Torque_Traj_3_fc_10pct.xlsx');
        xlswrite(tau_print,col_header,'Torques_fc_1','A1');
        xlswrite(tau_print,tau_fc_pn_mn_hist(:,:,1),'Torques_fc_1','A2');
        xlswrite(tau_print,col_header,'Torques_fc_2','A1');
        xlswrite(tau_print,tau_fc_pn_mn_hist(:,:,2),'Torques_fc_2','A2');
        xlswrite(tau_print,col_header,'Torques_fc_3','A1');
        xlswrite(tau_print,tau_fc_pn_mn_hist(:,:,3),'Torques_fc_3','A2');
        xlswrite(tau_print,col_header,'Torques_fc_4','A1');
        xlswrite(tau_print,tau_fc_pn_mn_hist(:,:,4),'Torques_fc_4','A2');
        xlswrite(tau_print,col_header,'Torques_fc_5','A1');
        xlswrite(tau_print,tau_fc_pn_mn_hist(:,:,5),'Torques_fc_5','A2');
        xlswrite(tau_print,col_header,'Torques_fc_6','A1');
        xlswrite(tau_print,tau_fc_pn_mn_hist(:,:,6),'Torques_fc_6','A2');

        case 20
        % Writing data to a file
        col_header ={'Axis_1','Axis_2','Axis_3','Axis_4','Axis_5','Axis_6'};

        tau_print = fullfile('C:\IIITD\Publications\ICRA2015\Results', 'Hist_Torque_Traj_3_fc_20pct.xlsx');
        xlswrite(tau_print,col_header,'Torques_fc_1','A1');
        xlswrite(tau_print,tau_fc_pn_mn_hist(:,:,1),'Torques_fc_1','A2');
        xlswrite(tau_print,col_header,'Torques_fc_2','A1');
        xlswrite(tau_print,tau_fc_pn_mn_hist(:,:,2),'Torques_fc_2','A2');
        xlswrite(tau_print,col_header,'Torques_fc_3','A1');
        xlswrite(tau_print,tau_fc_pn_mn_hist(:,:,3),'Torques_fc_3','A2');
        xlswrite(tau_print,col_header,'Torques_fc_4','A1');
        xlswrite(tau_print,tau_fc_pn_mn_hist(:,:,4),'Torques_fc_4','A2');
        xlswrite(tau_print,col_header,'Torques_fc_5','A1');
        xlswrite(tau_print,tau_fc_pn_mn_hist(:,:,5),'Torques_fc_5','A2');
        xlswrite(tau_print,col_header,'Torques_fc_6','A1');
        xlswrite(tau_print,tau_fc_pn_mn_hist(:,:,6),'Torques_fc_6','A2');
        case 0
        % Writing data to a file
        col_header ={'Axis_1','Axis_2','Axis_3','Axis_4','Axis_5','Axis_6'};

        %tau_print = fullfile('C:\IIITD\Publications\ICRA2015\Results', 'Traj_3_torque_fc_0pct.xlsx');
         tau_print = fullfile('C:\IIITD\Publications\ICRA2015\Results', 'Hist_Torque_Traj_3_fc_0pct.xlsx');
 
        xlswrite(tau_print,col_header,'Torques_fc_1','B1');
        %xlswrite(tau_print,tau_fc_pn_mn_hist(:,:,1),'Torques_fc_1','A2');
         xlswrite(tau_print,tau_fc_pn_mn_hist(:,:,1),'Torques_fc_1','b2');
         
 end
