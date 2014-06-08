clc;
clear;

% Read the data
    data1 = xlsread('SIS_SelectedControllers_d0.xlsx','S_N_SIS_44060208_ROB_1','A2:R10000');
   [num1 txt1 raw1] = xlsread('SIS_SelectedControllers_d0.xlsx','S_N_SIS_44060208_ROB_1','A1:R10000');
   [num2 txt2 raw2] = xlsread('SIS_SelectedControllers_d0.xlsx','S_N_SIS_44060208_ROB_1','A1:A1');

 y_angle = data1(:,1:6);
 angle_header = txt1(1,1:6);
 
  y_speed = data1(:,7:12);
 speed_header = txt1(1,7:12);
 
  y_torque = data1(:,13:18);
 torque_header = txt1(1,13:18);
 
   %// Normalize signals to zero mean and unit variance

%// Compute time lag s1 = (y1- mean(y1)) / std(y1);
%s2 = (y2 - mean(y2)) / std(y2);between signals
%c = xcorr(s1, s2);   %// Cross correlation
 
taua = ones(6);
for j = 1:6
    k=1
    for i = 1: 6 
    
        [c, lags] = xcorr(y_angle(:,j),y_angle(:,i));
        [m,id]=max(c);
        tau=lags(id);
        taua(j,k) = tau;
        k = k+1
    %plot(lags, c(1:end));
    end
end
%colNames ={'MHA_1','MHA_2',	'MHA_3', 'MHA_4','MHA_5','MHA_6'}

angleLag = {
    
     '','SIS_MR_1','SIS_MR_2','SIS_MR_3', 'SIS_MR_4','SIS_MR_5','SIS_MR_6';
     'SIS_MR_1',taua(1,1),taua(1,2),taua(1,3),taua(1,4),taua(1,5),taua(1,6);
    'SIS_MR_2',taua(2,1),taua(2,2),taua(2,3),taua(2,4),taua(2,5),taua(2,6);
    'SIS_MR_3',taua(3,1),taua(3,2),taua(3,3),taua(3,4),taua(3,5),taua(3,6);
    'SIS_MR_4',taua(4,1),taua(4,2),taua(4,3),taua(4,4),taua(4,5),taua(4,6);
    'SIS_MR_5',taua(5,1),taua(5,2),taua(5,3),taua(5,4),taua(5,5),taua(5,6);
    'SIS_MR_6',taua(6,1),taua(6,2),taua(6,3),taua(6,4),taua(6,5),taua(6,6)}

disp(angleLag);
% Speed Lag
taus = ones(6);
for j = 1:6
    k=1
    for i = 1: 6 
    
        [c, lags] = xcorr(y_speed(:,j),y_speed(:,i));
        [m,id]=max(c);
        tau=lags(id);
        taus(j,k) = tau;
        k = k+1
    %plot(lags, c(1:end));
    end
end
 
speedLag = {
    
     '','SIS_AS_1','SIS_AS_2','SIS_AS_3', 'SIS_AS_4','SIS_AS_5','SIS_AS_6';
     'SIS_AS_1',taus(1,1),taus(1,2),taus(1,3),taus(1,4),taus(1,5),taus(1,6);
    'SIS_AS_2',taus(2,1),taus(2,2),taus(2,3),taus(2,4),taus(2,5),taus(2,6);
    'SIS_AS_3',taus(3,1),taus(3,2),taus(3,3),taus(3,4),taus(3,5),taus(3,6);
    'SIS_AS_4',taus(4,1),taus(4,2),taus(4,3),taus(4,4),taus(4,5),taus(4,6);
    'SIS_AS_5',taus(5,1),taus(5,2),taus(5,3),taus(5,4),taus(5,5),taus(5,6);
    'SIS_AS_6',taus(6,1),taus(6,2),taus(6,3),taus(6,4),taus(6,5),taus(6,6)}

disp(speedLag);

% Torque Lag
taut = ones(6);
for j = 1:6
    k=1
    for i = 1: 6 
    
        [c, lags] = xcorr(y_torque(:,j),y_torque(:,i));
        [m,id]=max(c);
        tau=lags(id);
        taut(j,k) = tau;
        k = k+1
    %plot(lags, c(1:end));
    end
end
 
torqueLag = {
    
     '','SIS_AT_1','SIS_AT_2','SIS_AT_3', 'SIS_AT_4','SIS_AT_5','SIS_AT_6';
     'SIS_AT_1',taut(1,1),taut(1,2),taut(1,3),taut(1,4),taut(1,5),taut(1,6);
    'SIS_AT_2',taut(2,1),taut(2,2),taut(2,3),taut(2,4),taut(2,5),taut(2,6);
    'SIS_AT_3',taut(3,1),taut(3,2),taut(3,3),taut(3,4),taut(3,5),taut(3,6);
    'SIS_AT_4',taut(4,1),taut(4,2),taut(4,3),taut(4,4),taut(4,5),taut(4,6);
    'SIS_AT_5',taut(5,1),taut(5,2),taut(5,3),taut(5,4),taut(5,5),taut(5,6);
    'SIS_AT_6',taut(6,1),taut(6,2),taut(6,3),taut(6,4),taut(6,5),taut(6,6)}

disp(torqueLag);

