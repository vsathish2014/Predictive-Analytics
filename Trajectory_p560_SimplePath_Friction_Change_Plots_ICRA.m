figure(1);

 

 
subplot(3,1,1);
plot(t_cycle,transl(Ts));
set(gca,'PlotBoxAspectRatio',[5 2 1])
%title('Cartesian Postion vs time for one cycle: Ready to Normal position','FontSize',14)
xlabel('Time in seconds','FontSize',10);
ylabel('Position(meters)','FontSize',10);
c_legend = legend('x axis','y axis', 'z axis','FontSize',6);



a= subplot(3,1,2);
 
plot(time_c,q_c);
set(gca,'PlotBoxAspectRatio',[5 2 1])
xlabel('Time in seconds','FontSize',10);
ylabel('Joint angle(radians)','FontSize',10);
q_legend = legend('Axis 1','Axis 2', 'Axis 3', 'Axis 4', 'Axis 5', 'Axis 6');
set(q_legend,'FontSize',6);
% set(q_legend,'PlotBoxAspectRatioMode','manual');
% set(q_legend,'PlotBoxAspectRatio',[0.8 1 1]);
grid on

 
subplot(3,1,3);
plot(time_c,qd_c);
set(gca,'PlotBoxAspectRatio',[5 2 1])
xlabel('Time in seconds','FontSize',10);
ylabel('Velocity (rad/sec)','FontSize',10);
qd_legend = legend('Axis 1','Axis 2', 'Axis 3', 'Axis 4', 'Axis 5', 'Axis 6');
set(qd_legend,'FontSize',6);
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
    'String', 'Trend of Position, Joint Angle and Velocity', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center',....
    'FontSize',12)	
% 
figure(2);
 
plot(time_minutes, tau_pn_mn_1);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Overall Torque ','FontSize', 12);
xlabel('Time in minutes','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;
% 
 
% 
figure(3);
subplot(2,1,1);
plot( time_minutes,f_pn_mn_1);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Frictional Torque  ','FontSize', 12);
xlabel('Time in minutes','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;
subplot(2,1,2);
plot(time_minutes, i_pn_mn_1);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Inertial Torque ','FontSize', 12);
xlabel('Time in minutes','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;
 
figure(4);
subplot(2,1,1);
plot(time_minutes, c_pn_mn_1);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Coriolis Torque before friction change','FontSize', 12);
xlabel('Time in minutes','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;
  
 
subplot(2,1,2);
plot(time_minutes, g_pn_mn_1);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Gravity Torque before friction change ','FontSize', 12);
xlabel('Time in minutes','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;
% 
 


figure(5)
subplot(3,1,1);
plot(time_minutes, tau_pn_mn_1(:,2) );
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend:  Torque - Axis 2 ','FontSize', 10);
xlabel('Time in minutes','FontSize', 8);
ylabel('Torque (Nm)','FontSize', 8);
%qdd_legend = legend('Before Friciton Change','After Friction Change');
set(qdd_legend,'FontSize',6);
grid on;

subplot(3,1,2);
plot(time_minutes, f_pn_mn_1(:,2) );
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend:  Fricitonal Torque - Axis 2 ','FontSize',10);
xlabel('Time in minutes','FontSize', 8);
ylabel('Torque (Nm)','FontSize', 8);
%qdd_legend = legend('Before Friciton Change','After Friction Change');
set(qdd_legend,'FontSize',6);
grid on;
subplot(3,1,3);
plot(time_minutes, i_pn_mn_1(:,2) );
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend:  Inertial Torque - Axis 2 ','FontSize', 10);
xlabel('Time in minutes','FontSize', 8);
ylabel('Torque (Nm)','FontSize', 8);
%qdd_legend = legend('Before Friciton Change','After Friction Change');
set(qdd_legend,'FontSize',6);
grid on;

figure(6)
subplot(2,1,1);
plot(time_minutes, c_pn_mn_1(:,2) );
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend:  Coriolis Torque - Axis 2 ','FontSize', 8);
xlabel('Time in minutes','FontSize', 6);
ylabel('Torque (Nm)','FontSize', 6);
%qdd_legend = legend('Before Friciton Change','After Friction Change');
set(qdd_legend,'FontSize',6);
grid on;

subplot(2,1,2);
plot(time_minutes, g_pn_mn_1(:,2) );
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend:  Gravitational Torque - Axis 2 ','FontSize', 8);
xlabel('Time in minutes','FontSize', 6);
ylabel('Torque (Nm)','FontSize', 6);
%qdd_legend = legend('Before Friciton Change','After Friction Change');
set(qdd_legend,'FontSize',6);
grid on;

figure(7)
 
plot(time_minutes,cat(2,tau_pn_mn_1(:,2),f_pn_mn_1(:,2),i_pn_mn_1(:,2),c_pn_mn_1(:,2),g_pn_mn_1(:,2)));
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Torque  ','FontSize', 12);
xlabel('Time in minutes','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
 qdd_legend = legend('Overall Torque','Frictional Torque', 'Inertial Torque', 'coriolis Torque', 'Gravitaional Torque');
set(qdd_legend,'FontSize',8);
grid on;

 