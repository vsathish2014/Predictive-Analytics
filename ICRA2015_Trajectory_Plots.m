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
        end
    case 2 
        switch plot_fc_pct
            case 10
                load ICRA2015_Tajectory2_FC_10pct_17092014_5_days_All.mat

            case 20
                load ICRA2015_Tajectory1_FC_20pct_17092014_5_days_All.mat
        end
    case 3 
        switch plot_fc_pct
            case 10
                load ICRA2015_Tajectory3_FC_10pct_17092014_5_days_All.mat

            case 20
                load ICRA2015_Tajectory3_FC_20pct_17092014_5_days_All.mat

        end       
     
end
 


    simActualDuration = 3600*24*5;
    time = [0:10:simActualDuration];
     time_hours = [1:6:120];
    % tau_fc_pn_mn = tau_fc_pn_mn(:,:,2);
    
    tau_fc_pn_mn_2 = tau_fc_pn_mn(2:end,:,:); 
    tau_fc_pn_mn_s = tau_fc_pn_mn_2(4:6*360:end,:,:)
    
figure(1);

 t = [0:10:30]';
t_cycle = [0:10:60];
Ts1 = ctraj(Tq_1,Tq_2,length(t));
Ts2 = ctraj(Tq_2,Tq_1,length(t));
Ts = Ts1 ;
Ts = cat(3, Ts1,Ts2(:,:,2:4));

 
%subplot(3,1,1);
% plot(t_cycle,transl(Ts),'LineWidth',2);
% set(gca,'PlotBoxAspectRatio',[5 2 1])
% %title('Cartesian Postion vs time for one cycle: Ready to Normal position','FontSize',14)
% xlabel('Time in seconds','FontSize',12);
% ylabel('Position(meters)','FontSize',12);
% c_legend = legend('x axis','y axis', 'z axis','FontSize',10);
time_c =[0:10:60];
figure(1);
subplot(3,1,1);
 
plot(time_c,q_c,'LineWidth',2);
set(gca,'PlotBoxAspectRatio',[5 2 1])
xlabel('Time in seconds','FontSize',12);
ylabel('Joint angle(radians)','FontSize',12);
q_legend = legend('Axis 1','Axis 2', 'Axis 3', 'Axis 4', 'Axis 5', 'Axis 6');
set(q_legend,'FontSize',10);
% set(q_legend,'PlotBoxAspectRatioMode','manual');
% set(q_legend,'PlotBoxAspectRatio',[0.8 1 1]);
grid on

 
subplot(3,1,2);
plot(time_c,qd_c,'LineWidth',2);
set(gca,'PlotBoxAspectRatio',[5 2 1])
xlabel('Time in seconds','FontSize',12);
ylabel('Velocity (rad/sec)','FontSize',12);
qd_legend = legend('Axis 1','Axis 2', 'Axis 3', 'Axis 4', 'Axis 5', 'Axis 6');
set(qd_legend,'FontSize',10);
grid on

subplot(3,1,3);
plot(time_c,qdd_c,'LineWidth',2);
set(gca,'PlotBoxAspectRatio',[5 2 1])
xlabel('Time in seconds','FontSize',12);
ylabel('Accceleration (rad/sec squared)','FontSize',12);
qd_legend = legend('Axis 1','Axis 2', 'Axis 3', 'Axis 4', 'Axis 5', 'Axis 6');
set(qd_legend,'FontSize',10);
grid on

% subplot(3,1,3);
% plot(time_c,qdd_c);
% set(gca,'PlotBoxAspectRatio',[5 2 1])
% xlabel('Time in seconds','FontSize',10);
% ylabel('Acceleration - rad/sec squared','FontSize',10);
% qdd_legend = legend('Axis 1','Axis 2', 'Axis 3', 'Axis 4', 'Axis 5', 'Axis 6');
% set(qdd_legend,'FontSize',6);
% grid on
	
annotation('textbox', [0 0.9 1 0.1], ...
    'String', 'Trend of Joint Angle, Velocity and Acceleration', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center',....
    'FontSize',14)	
% 
figure(2);
tau_fc_pn_mn_2 = tau_fc_pn_mn(2:end,:,plot_axis); 
tau_fc_pn_mn_s = tau_fc_pn_mn_2(4:6*360:end,:)

%plot(time_minutes, tau_pn_mn_1);
plot( time_hours',tau_fc_pn_mn_s,'LineWidth',2);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Overall Torque ','FontSize', 14);
xlabel('Time in Hours','FontSize', 12);
ylabel('Torque (Nm)','FontSize', 12);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',8);
set(gca,'XTick',[0:10:120]);
grid on;
% 
 
% 
figure(3);
 
f_fc_pn_2 = f_fc_pn(2:end,1,plot_axis); 
f_fc_pn_s = f_fc_pn_2(4:6*360:end,:)
 
%plot( time_minutes,f_pn_mn_1);
plot(time_hours,f_fc_pn_s,'LineWidth',2);
set(gca,'PlotBoxAspectRatio',[5 2 1])
%title('Trend: Frictional Torque  ','FontSize', 12);
title(' Frictional Torque - For a specific joint configuration','FontSize', 12);
xlabel('Time in hours','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',8);
set(gca,'XTick',[0:10:120]);
grid on;
 
% figure(4);
% tau_pn_mn_2 = tau_fc_pn_mn(2:end,1); 
% tau_pn_mn_3 = tau_pn_mn_2(4:6*360:end,:)
% % tau_2 = tau_1(2:end,1); 
% % tau_3 = tau_2(7:12:end,:)
%  
% %plot(time_minutes, tau_pn_mn_1);
% plot( time_hours,tau_pn_mn_3,'LineWidth',2);
% set(gca,'PlotBoxAspectRatio',[5 2 1])
% title('Overall Torque: Specific Joint Configuration ','FontSize', 14);
% xlabel('Time in Hours','FontSize', 12);
% ylabel('Torque (Nm)','FontSize', 12);
% qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
% set(qdd_legend,'FontSize',12);
% %ylim([-40 0])
% %set(gca,'YTick',[-50:10:0]);
% set(gca,'XTick',[1:5:120]);
% grid on; 

% figure(4)
%  
% plot(time_minutes, tau_fc_pn_mn(:,1),'LineWidth',2 );
% set(gca,'PlotBoxAspectRatio',[5 2 1])
% title('Trend:  Torque - Axis 1 ','FontSize', 14);
% xlabel('Time in minutes','FontSize', 12);
% ylabel('Torque (Nm)','FontSize', 12);
% %qdd_legend = legend('Before Friciton Change','After Friction Change');
% set(qdd_legend,'FontSize',10);
% grid on;
% 
% 
% 
%  figure(8);
%  
%  plot(time_minutes, tau_fc_pn_mn,'LineWidth',2);
%  
% set(gca,'PlotBoxAspectRatio',[5 2 1])
% title('Trend: Overall Torque   ','FontSize', 14);
% xlabel('Time in minutes','FontSize', 12);
% ylabel('Torque (Nm)','FontSize', 12);
% qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
% set(qdd_legend,'FontSize',10);
% grid on;
% %


% figure(10);
%  
% f_fc_pn_2 = f_fc_pn(2:end,:,1); 
% f_fc_pn_3 = f_fc_pn_2(4:6:end,:,1)
% %plot( time_minutes,f_pn_mn_1);
% plot(f_fc_pn_3(:,1),'LineWidth',2);
% set(gca,'PlotBoxAspectRatio',[5 2 1])
% %title('Trend: Frictional Torque  ','FontSize', 12);
% title('Trend: Frictional Torque - Joint configuration 7 ','FontSize', 16);
% xlabel('Time in minutes','FontSize', 14);
% ylabel('Torque (Nm)','FontSize', 14);
% qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
% set(qdd_legend,'FontSize',12);
% ylim([10 40]);
% set(gca,'XTick',[0:60:1440]);
% grid on;

% figure(10);
% tau_pn_mn_2 = tau_pn_mn_1(2:end,1); 
% tau_pn_mn_3 = tau_pn_mn_2(7:12:end,:)
% tau_2 = tau_1(2:end,1); 
% tau_3 = tau_2(7:12:end,:)
% time_minutes_1 = time_minutes(:,2:end);
% %plot(time_minutes, tau_pn_mn_1);
% plot( tau_3,'LineWidth',2);
% set(gca,'PlotBoxAspectRatio',[5 2 1])
% title('Trend: Overall Torque - Joint configuration 7 ','FontSize', 14);
% xlabel('Time in minutes','FontSize', 12);
% ylabel('Torque (Nm)','FontSize', 12);
% qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
% set(qdd_legend,'FontSize',10);
% grid on;

% figure(11)
%  
% %plot(time_minutes,cat(2,f_pn_mn_1(:,1),f_pn_mn_1(:,2),f_pn_mn_1(:,3),f_pn_mn_1(:,4),f_pn_mn_1(:,5),f_pn_mn_1(:,6) ),'LineWidth',2);
% %plot(time_minutes,cat(2, f_pn_mn_1(:,4),f_pn_mn_1(:,5),f_pn_mn_1(:,6) ),'LineWidth',2);
% plot(time_minutes,cat(2, f_pn_mn_1(:,5)  ),'LineWidth',2);
% 
% set(gca,'PlotBoxAspectRatio',[5 2 1])
% title('Trend: Friction Torque  ','FontSize', 16);
% xlabel('Time in minutes','FontSize', 14);
% ylabel('Torque (Nm)','FontSize', 14);
% % qdd_legend = legend( 'Frictional Torque-1','Frictional Torque-2','Frictional Torque-3','Frictional Torque-4', 'Frictional Torque-5', 'Frictional Torque-6' );
% % qdd_legend = legend(  'Frictional Torque-4', 'Frictional Torque-5', 'Frictional Torque-6' );
% qdd_legend = legend(  'Frictional Torque-5'  );
%  set(qdd_legend,'FontSize',14);
% grid on;
% 
% figure(12)
%  
% %plot(time_minutes,cat(2,f_pn_mn_1(:,1),f_pn_mn_1(:,2),f_pn_mn_1(:,3),f_pn_mn_1(:,4),f_pn_mn_1(:,5),f_pn_mn_1(:,6) ),'LineWidth',2);
% %plot(time_minutes,cat(2, f_pn_mn_1(:,4),f_pn_mn_1(:,5),f_pn_mn_1(:,6) ),'LineWidth',2);
% plot(time_minutes,cat(2, tau_pn_mn_1(:,6)  ),'LineWidth',2);
% 
% set(gca,'PlotBoxAspectRatio',[5 2 1])
% title('Trend: Overall Torque  ','FontSize', 16);
% xlabel('Time in minutes','FontSize', 14);
% ylabel('Torque (Nm)','FontSize', 14);
% % qdd_legend = legend( 'Frictional Torque-1','Frictional Torque-2','Frictional Torque-3','Frictional Torque-4', 'Frictional Torque-5', 'Frictional Torque-6' );
% % qdd_legend = legend(  'Frictional Torque-4', 'Frictional Torque-5', 'Frictional Torque-6' );
% qdd_legend = legend(  'Overall Torque-6'  );
%  set(qdd_legend,'FontSize',14);
% grid on;
% 
% figure(13);
%  f_pn_mn_21 = f_pn_mn_1(2:end,4:6); 
% f_pn_mn_31 = f_pn_mn_21(7:12:end,:)
% %plot( time_minutes,f_pn_mn_1);
% plot(f_pn_mn_31,'LineWidth',2);
% set(gca,'PlotBoxAspectRatio',[5 2 1])
% %title('Trend: Frictional Torque  ','FontSize', 12);
% title('Trend: Frictional Torque - Joint configuration 7 ','FontSize', 16);
% xlabel('Time in minutes','FontSize', 14);
% ylabel('Torque (Nm)','FontSize', 14);
% qdd_legend = legend( 'Axis 4','Axis 5','Axis 6');
% set(qdd_legend,'FontSize',10);
% grid on;
% 
% figure(14);
%  tau_pn_mn_21 = tau_pn_mn_1(2:end,4:6); 
% tau_pn_mn_31 = tau_pn_mn_21(7:12:end,:)
% %plot( time_minutes,f_pn_mn_1);
% plot(tau_pn_mn_31,'LineWidth',2);
% set(gca,'PlotBoxAspectRatio',[5 2 1])
% %title('Trend: Frictional Torque  ','FontSize', 12);
% title('Trend: Overall Torque - Joint configuration 7 ','FontSize', 16);
% xlabel('Time in minutes','FontSize', 14);
% ylabel('Torque (Nm)','FontSize', 14);
% qdd_legend = legend( 'Axis 4','Axis 5','Axis 6');
% set(qdd_legend,'FontSize',10);
% grid on;

 
