% ABB Trajecotry example
clear;
clc;
%profile on
mdl_puma560
  p560.payload(2.5, [0,0,0.1]);

 
% p = mstraj(path,[0.5 0.5 0.3],[],[0.5 -0.5 -0.5],10,0.2);
t_circle = circle([-0.2 -0.2 -0.2],.1,100);
Tp = transl(1*t_circle');
 q = p560.ikine6s(Tp);
 t1 = [0:5:10]';
 qh = [ -2.7236    0.4363   -2.3562         0    2.9245   -1.7195];
[q_1 qd_1 qdd_1] = jtraj (qh,q(1,:),t1);
[q_2 qd_2 qdd_2] = jtraj(q(end,:),qh,t1);
q = cat(1,q_1,q);
q = cat(1,q,q_2);

% 
% Tp = transl(0.5*p);
% Tp = homtrans(transl(-0.8563 ,  -0.1520 ,   0.0798 ),Tp);
 
%  p560.plot(q);
t = [0:1:2]';
 
j =1
for i = 1: size(q,1)-1
    [q_c(j:j+2,:), qd_c(j:j+2,:), qdd_c(j:j+2,:)] = jtraj(q(i,:),q(i+1,:),t);
    j = j +3;
end
 

 
ql = q_c;
qdl = qd_c;
qddl = qdd_c;
 % 550 seconds for one cycle
for cycles = 1:1318
    ql = cat(1,ql,q_c(2:165,:));
    qdl = cat(1,qdl,qd_c(2:165,:));
    qddl =cat(1,qddl, qdd_c(2:165,:));
   
end
% 
 
% 
% Torque with friction change ( measurement noise and process noise)
L = p560.links
j = 0;

for i =1 :1:216000
     nl_r = randn(1,6);
     %nl_r = randn(N,6);
    tau_fc_pn(i,:) = p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:))+ ...
               nl_r.*(p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:) ))*.1 ;
     L(1).Tc = [0.395+0.5/(1+exp(-((j/300000)^5))) -0.435-0.5/(1+exp(-((j/300000)^5)))];
     L(2).Tc = [0.126+0.5/(1+exp(-((j/300000)^5))) -0.071-0.5/(1+exp(-((j/300000)^5)))];
     L(3).Tc = [0.132+0.5/(1+exp(-((j/300000)^5))) -0.105-0.5/(1+exp(-((j/300000)^5)))];
     j = j +2 ;
    time(i) = j;
end
 time_hours = time./(60*60);
 
N = size(tau_fc_pn(1:216000 ,1),1);
x1 = tau_fc_pn(1:216000 ,:);
x = abs(x1);

% add 10% noise based on gaussian
scale = 0.1 ;
nl =  randn(1, N); % noise with mean=0 and std=1;
 y1 = x(:,1) + nl'.*x(:,1)*.1 ;
 y2 = x(:,2) + nl'.*x(:,2)*.1 ;
 y3 = x(:,3) + nl'.*x(:,3)*.1 ;
 y4 = x(:,4) + nl'.*x(:,4)*.1 ;
 y5 = x(:,5) + nl'.*x(:,5)*.1 ;
 y6 = x(:,6) + nl'.*x(:,6)*.1 ;
   
 tau_fc_pn_mn = cat(2,y1,y2,y3,y4,y5,y6);
 
% 
% 
% % Average torque per hour - 1800 * 10 (seconds)
torque_average_1 = mean(reshape(y1,1800,[]))';
torque_average_2 = mean(reshape(y2,1800,[]))';
torque_average_3 = mean(reshape(y3,1800,[]))';
torque_average_4 = mean(reshape(y4,1800,[]))';
torque_average_5 = mean(reshape(y5,1800,[]))';
torque_average_6 = mean(reshape(y6,1800,[]))';

torque_average_fc_pn_mn = cat(2,torque_average_1,torque_average_2,torque_average_3,torque_average_4,torque_average_5,torque_average_6);
 


 
figure(1);
 
 
plot( torque_average_fc_pn_mn);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Average Torque per hour during friction change (with process and measurement nosie)','FontSize', 12);
xlabel('Time in hours','FontSize', 10);
ylabel('Average Torque (Nm) per hr','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;

 
 
  figure(2);
subplot(3,1,1);
plot(time(35850:36150)',tau_fc_pn_mn(35850:36150,1:3));
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Torque in 20th hour during friction change','FontSize', 12);
xlabel('Time in seconds','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
axis([time(35850)',time(36150)',0,200]);
grid on;
subplot(3,1,2);
plot(time(71850:72150)',tau_fc_pn_mn(71850:72150,1:3));
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Torque in 40th hour during friction change','FontSize', 12);
xlabel('Time in seconds','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
axis([time(71850)',time(72150)',0,200]);
grid on;

subplot(3,1,3);
plot(time(107850:108150)',tau_fc_pn_mn(107850:108150,1:3));
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Torque in 60th hour during friction change','FontSize', 12);
xlabel('Time in seconds','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
axis([time(107850)',time(108150)',0,200]);
grid on;


figure(12);
subplot(3,1,1);
plot(time(143850:144150)',tau_fc_pn_mn(143850:144150,1:3));
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Torque in 80th hour during friction change','FontSize', 12);
xlabel('Time in seconds','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
 axis([time(143850)',time(144150)',0,200]);
grid on;
subplot(3,1,2);
plot(time(179850:180150)',tau_fc_pn_mn(179850:180150,1:3));
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Torque in 100th hour during friction change','FontSize', 12);
xlabel('Time in seconds','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
axis([time(179850)',time(180150)',0,200]);
grid on;

subplot(3,1,3);
plot(time(214050:214350)',tau_fc_pn_mn(214050:214350,1:3));
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Torque in 119th hour during friction change','FontSize', 12);
xlabel('Time in seconds','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
axis([time(214050)',time(214350)',0,200]);
grid on;
% % 
% % 
% %  
