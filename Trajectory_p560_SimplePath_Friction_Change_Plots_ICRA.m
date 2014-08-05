figure(1);

 t = [0:5:30]';
t_cycle = [0:5:60];
Ts1 = ctraj(Tq_1,Tq_2,length(t));
Ts2 = ctraj(Tq_2,Tq_1,length(t));
Ts = Ts1 ;
Ts = cat(3, Ts1,Ts2(:,:,2:7));

 
subplot(3,1,1);
% plot(t_cycle,transl(Ts),'LineWidth',2);
% set(gca,'PlotBoxAspectRatio',[5 2 1])
% %title('Cartesian Postion vs time for one cycle: Ready to Normal position','FontSize',14)
% xlabel('Time in seconds','FontSize',12);
% ylabel('Position(meters)','FontSize',12);
% c_legend = legend('x axis','y axis', 'z axis','FontSize',10);



a= subplot(3,1,1);
 
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
tau_pn_mn_2 = tau_pn_mn_1(2:end,:); 
tau_pn_mn_3 = tau_pn_mn_2(7:12:end,:)
time_minutes_1 = time_minutes(:,2:end);
%plot(time_minutes, tau_pn_mn_1);
plot( tau_pn_mn_3,'LineWidth',2);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Overall Torque - Joint configuration 7 ','FontSize', 14);
xlabel('Time in minutes','FontSize', 12);
ylabel('Torque (Nm)','FontSize', 12);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',10);
grid on;
% 
 
% 
figure(3);
subplot(2,1,1);
f_pn_mn_2 = f_pn_mn_1(2:end,:); 
f_pn_mn_3 = f_pn_mn_2(7:12:end,:)
%plot( time_minutes,f_pn_mn_1);
plot(f_pn_mn_3,'LineWidth',2);
set(gca,'PlotBoxAspectRatio',[5 2 1])
%title('Trend: Frictional Torque  ','FontSize', 12);
title('Trend: Frictional Torque - Joint configuration 7 ','FontSize', 14);
xlabel('Time in minutes','FontSize', 12);
ylabel('Torque (Nm)','FontSize', 12);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',10);
grid on;
subplot(2,1,2);
i_pn_mn_2 = i_pn_mn_1(2:end,:); 
i_pn_mn_3 = i_pn_mn_2(7:12:end,:)
%plot(time_minutes, i_pn_mn_1);
plot( i_pn_mn_3,'LineWidth',2);
set(gca,'PlotBoxAspectRatio',[5 2 1])
%title('Trend: Inertial Torque ','FontSize', 12);
title('Trend: Inertial Torque - Joint configuration 7','FontSize', 14);
xlabel('Time in minutes','FontSize', 12);
ylabel('Torque (Nm)','FontSize', 12);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',10);
grid on;
 
figure(4);
subplot(2,1,1);
c_pn_mn_2 = c_pn_mn_1(2:end,:); 
c_pn_mn_3 = c_pn_mn_2(7:12:end,:)
%plot(time_minutes, c_pn_mn_1);
plot(  c_pn_mn_3,'LineWidth',2);
set(gca,'PlotBoxAspectRatio',[5 2 1])
%title('Trend: Coriolis Torque','FontSize', 12);
title('Trend: Coriolis Torque- Joint configuration 7','FontSize', 14);
xlabel('Time in minutes','FontSize', 12);
ylabel('Torque (Nm)','FontSize', 12);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',10);
grid on;
  
 
subplot(2,1,2);
g_pn_mn_2 = g_pn_mn_1(2:end,:); 
g_pn_mn_3 = g_pn_mn_2(7:12:end,:)
%plot(time_minutes, g_pn_mn_1);
plot(  g_pn_mn_3,'LineWidth',2);
set(gca,'PlotBoxAspectRatio',[5 2 1])
%title('Trend: Gravity Torque','FontSize', 12);
title('Trend: Gravity Torque - Joint configuration 7','FontSize', 14);
xlabel('Time in minutes','FontSize', 12);
ylabel('Torque (Nm)','FontSize', 12);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',10);
grid on;

 


figure(5)
subplot(3,1,1);
plot(time_minutes, tau_pn_mn_1(:,2),'LineWidth',2 );
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend:  Torque - Axis 2 ','FontSize', 14);
xlabel('Time in minutes','FontSize', 12);
ylabel('Torque (Nm)','FontSize', 12);
%qdd_legend = legend('Before Friciton Change','After Friction Change');
set(qdd_legend,'FontSize',10);
grid on;

subplot(3,1,2);
plot(time_minutes, f_pn_mn_1(:,2),'LineWidth',2 );
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend:  Fricitonal Torque - Axis 2 ','FontSize',14);
xlabel('Time in minutes','FontSize', 12);
ylabel('Torque (Nm)','FontSize', 12);
%qdd_legend = legend('Before Friciton Change','After Friction Change');
set(qdd_legend,'FontSize',10);
grid on;
subplot(3,1,3);
plot(time_minutes, i_pn_mn_1(:,2),'LineWidth',2 );
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend:  Inertial Torque - Axis 2 ','FontSize', 14);
xlabel('Time in minutes','FontSize', 12);
ylabel('Torque (Nm)','FontSize', 12);
%qdd_legend = legend('Before Friciton Change','After Friction Change');
set(qdd_legend,'FontSize',10);
grid on;

figure(6)
subplot(3,1,1);
plot(time_minutes, c_pn_mn_1(:,2),'LineWidth',2 );
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend:  Coriolis Torque - Axis 2 ','FontSize', 14);
xlabel('Time in minutes','FontSize', 12);
ylabel('Torque (Nm)','FontSize', 12);
%qdd_legend = legend('Before Friciton Change','After Friction Change');
set(qdd_legend,'FontSize',10);
grid on;

subplot(3,1,2);
plot(time_minutes, g_pn_mn_1(:,2),'LineWidth',2 );
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend:  Gravitational Torque - Axis 2 ','FontSize', 14);
xlabel('Time in minutes','FontSize', 12);
ylabel('Torque (Nm)','FontSize', 12);
%qdd_legend = legend('Before Friciton Change','After Friction Change');
set(qdd_legend,'FontSize',10);
grid on;

subplot(3,1,3);
plot(time_minutes, g_pn_mn_1(:,2) ,'LineWidth',2);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend:  Gravitational Torque - Axis 2 ','FontSize', 14);
xlabel('Time in minutes','FontSize', 12);
ylabel('Torque (Nm)','FontSize', 12);
%qdd_legend = legend('Before Friciton Change','After Friction Change');
set(qdd_legend,'FontSize',10);
grid on;

figure(7)
 
plot(time_minutes,cat(2,tau_pn_mn_1(:,2),f_pn_mn_1(:,2),i_pn_mn_1(:,2),c_pn_mn_1(:,2),g_pn_mn_1(:,2)),'LineWidth',2);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Torque  ','FontSize', 12);
xlabel('Time in minutes','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
 qdd_legend = legend('Overall Torque','Frictional Torque', 'Inertial Torque', 'coriolis Torque', 'Gravitaional Torque');
set(qdd_legend,'FontSize',8);
grid on;

 figure(8);
 
 plot(time_minutes, tau_pn_mn_1,'LineWidth',2);
 
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Overall Torque   ','FontSize', 14);
xlabel('Time in minutes','FontSize', 12);
ylabel('Torque (Nm)','FontSize', 12);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',10);
grid on;