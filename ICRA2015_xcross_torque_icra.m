
clc;
clear all;
clear lags;
clear id_1 ;
clear c_1;
 
plot_trajectory = 1;
plot_fc_pct = 10;
plot_axis = 1;
switch plot_trajectory
    case 1 
        switch plot_fc_pct
            case 10
                load ICRA2015_Tajectory1_FC_10pct_24092014_5_days_All_Run2.mat
            case 20
                load ICRA2015_Tajectory1_FC_20pct_24092014_5_days_All_Run1.mat
        end
    case 2 
        switch plot_fc_pct
            case 10
                load ICRA2015_Tajectory2_FC_10pct_24092014_5_days_All_Run1.mat

            case 20
                load ICRA2015_Tajectory2_FC_20pct_24092014_5_days_All_Run1.mat
        end
    case 3 
        switch plot_fc_pct
            case 10
                load ICRA2015_Tajectory3_FC_10pct_24092014_5_days_All_Run1.mat

            case 20
                load ICRA2015_Tajectory3_FC_20pct_24092014_5_days_All_Run1.mat

        end       
     
end

% Sample the signal - hourly 
    time_hours = [1:6:120];
    % tau_fc_pn_mn = tau_fc_pn_mn(:,:,2);
    
    tau_fc_pn_mn_2(:,:,:) = tau_fc_pn_mn(2:end,:,:);    
      
    tau_fc_pn_mn_hs = tau_fc_pn_mn_2(4:360:end,:,:);
    
 % teake absolute value of torque   
    for i= 1: 6
         x(:,:,i) = abs(tau_fc_pn_mn_2(:,:,i));
        % x(:,:,i) = (tau_fc_pn_mn_2(:,:,i));
    end
 % Avergae hourly 
 
 for i = 1 : 6
 tau_fc_pn_mn_avg_1(:,:,i) = mean(reshape(x(:,1,i),360,[]))';
 tau_fc_pn_mn_avg_2(:,:,i) = mean(reshape(x(:,2,i),360,[]))';
 tau_fc_pn_mn_avg_3(:,:,i) = mean(reshape(x(:,3,i),360,[]))';
 tau_fc_pn_mn_avg_4(:,:,i) = mean(reshape(x(:,4,i),360,[]))';
 tau_fc_pn_mn_avg_5(:,:,i) = mean(reshape(x(:,5,i),360,[]))';
 tau_fc_pn_mn_avg_6(:,:,i) = mean(reshape(x(:,6,i),360,[]))';
 
 tau_fc_pn_mn_avg(:,:,i) = cat(2,tau_fc_pn_mn_avg_1(:,:,i),tau_fc_pn_mn_avg_2(:,:,i),tau_fc_pn_mn_avg_3(:,:,i),tau_fc_pn_mn_avg_4(:,:,i),...
                            tau_fc_pn_mn_avg_5(:,:,i),tau_fc_pn_mn_avg_6(:,:,i));
 end
 fc_axis = 1;
 for fc_axis = 1:6
 z =tau_fc_pn_mn_hs(:,:,fc_axis);
  min_torque = kron(min(z),ones(120,1 ));
  max_torque = kron(max(z),ones(120,1 ));
%     
      torque_data_n(:,:,fc_axis) = (z- min_torque)./(max_torque -min_torque);
 end     
 
  for fc_axis = 1:6    
 j=0;
 i=0;
 % fc_axis=2
  % Compute time lag between signals
  
 
k=1;
for j = 1:6
    
    for i = 1: 6             
      %// Cross correlation
                   %[c(:,:,k) lags(:,:,k)] = xcorr( (torque_data_n(:,j,fc_axis)),   (torque_data_n(:,i,fc_axis)),'unbiased');                   %// Cross correlation
                  % [c(:,:,k) lags(:,:,k)] = xcorr( (torque_data_n(:,j,fc_axis)),   (torque_data_n(:,i,fc_axis)),'coeff');                   %// Cross correlation
                  
                   % [c(:,:,k) lags(:,:,k)] = xcorr(zscore(tau_fc_pn_mn_avg(:,j,fc_axis)), zscore(tau_fc_pn_mn_avg(:,i,fc_axis)),'unbiased'); 
                   
                     [c(:,:,k) lags(:,:,k)] = xcorr(zscore(tau_fc_pn_mn_hs(:,j,fc_axis)), zscore(tau_fc_pn_mn_hs(:,i,fc_axis)),'coeff');              
              k = k+1;
         
    end
    
end


lags = reshape(lags,[239,36]);
%lags = reshape(lags,[119,36]);
 c = reshape(c,[239,36]);
%c = reshape(c,[119,36]);
frow = 1 ;
lrow =239;
 
% id_1 = zeros(36, 'uint8');
% c_1 = zeros(36,'uint8');
        for i = 1 : 36
                [m  id]=max(c(1:239,i));
                tauid =lags(frow-1+id);
                tauc =c(frow-1+id);
                id_1(i) = tauid;
                c_1(i) = tauc;
        end
  clear c;
  clear lags;

id_t(:,:,fc_axis) = cat(3, reshape(id_1,6,6));
c_t(:,:,fc_axis) = cat(3, reshape(c_1,6,6));
 end
% Writing data to a file

% tau_print = fullfile('c:\results', 'Traj_1_torque_fc_10pct.xlsx');
% xlswrite(tau_print,tau_fc_pn_mn_avg(:,:,1),'Torques_fc_1','A2');
% xlswrite(tau_print,tau_fc_pn_mn_avg(:,:,2),'Torques_fc_2','A2');
% xlswrite(tau_print,tau_fc_pn_mn_avg(:,:,3),'Torques_fc_3','A2');
% xlswrite(tau_print,tau_fc_pn_mn_avg(:,:,4),'Torques_fc_4','A2');
% xlswrite(tau_print,tau_fc_pn_mn_avg(:,:,5),'Torques_fc_5','A2');
% xlswrite(tau_print,tau_fc_pn_mn_avg(:,:,6),'Torques_fc_6','A2');
