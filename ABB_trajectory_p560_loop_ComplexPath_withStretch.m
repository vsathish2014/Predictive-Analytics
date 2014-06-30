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
 

%p560.plot(q_c);
% figure(1);
% p560.plot(q_c(1,:));
% figure(2);
% p560.plot(q_c(11,:));
% figure(3);
% p560.plot(q_c(22,:));
% figure(4);
% p560.plot(q_c(33,:));
% figure(5);
% p560.plot(q_c(44,:));
% figure(6);
% p560.plot(q_c(56,:));
% 
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
% figure(7);
% 
% Cartesian Position:
%  
% t : time for half cycle 
t = [0:1:1]';
t_cycle = [0:2:328];
l=1
for q_row = 1:2:164
    Ts(:,:,l:l+1) = ctraj(p560.fkine(q_c(q_row,:)),p560.fkine(q_c(q_row+1,:)),length(t));
    l = l+2;
end
% Ts1 = ctraj(Tq_1,Tq_2,length(t));
% Ts2 = ctraj(Tq_2,Tq_1,length(t));
% Ts = Ts1 ;
% Ts = cat(3, Ts1,Ts2(:,:,2:6));
% 
%  
figure(7);
subplot(3,1,1);
plot(t_cycle(1:164)',transl(Ts));
set(gca,'PlotBoxAspectRatio',[5 2 1])
%title('Cartesian Postion vs time for one cycle: Ready to Normal position','FontSize',14)
xlabel('Time in seconds','FontSize',10);
ylabel('Position(meters)','FontSize',10);
c_legend = legend('x axis','y axis', 'z axis','FontSize',6);
grid on
% 
% 
a= subplot(3,1,2);
 
plot(t_cycle',q_c);
set(gca,'PlotBoxAspectRatio',[5 2 1])
xlabel('Time in seconds','FontSize',10);
ylabel('Joint angle(radians)','FontSize',10);
q_legend = legend('Axis 1','Axis 2', 'Axis 3', 'Axis 4', 'Axis 5', 'Axis 6');
set(q_legend,'FontSize',6);
% set(q_legend,'PlotBoxAspectRatioMode','manual');
% set(q_legend,'PlotBoxAspectRatio',[0.8 1 1]);
grid on
% 
%  
subplot(3,1,3);
plot(t_cycle',qd_c);
set(gca,'PlotBoxAspectRatio',[5 2 1])
xlabel('Time in seconds','FontSize',10);
ylabel('Velocity (rad/sec)','FontSize',10);
qd_legend = legend('Axis 1','Axis 2', 'Axis 3', 'Axis 4', 'Axis 5', 'Axis 6');
set(qd_legend,'FontSize',6);
grid on
% 
% % subplot(3,1,3);
% % plot(time_c,qdd_c);
% % set(gca,'PlotBoxAspectRatio',[5 2 1])
% % xlabel('Time in seconds','FontSize',10);
% % ylabel('Acceleration - rad/sec squared','FontSize',10);
% % qdd_legend = legend('Axis 1','Axis 2', 'Axis 3', 'Axis 4', 'Axis 5', 'Axis 6');
% % set(qdd_legend,'FontSize',6);
% % grid on
% 	
annotation('textbox', [0 0.9 1 0.1], ...
    'String', 'Trend of Position, Joint Angle and Velocity', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center',....
    'FontSize',12)	

% Torque required moving between two stretch position

tau_1 = p560.rne(ql,qdl,qddl);
time = [0:2:432000];
time_hours = time./(60*60);


x1 = tau_1(1:216000,:);
x = abs(x1);

% Average torque per hour - 1800* 5 (seconds)
torque_average_1 = mean(reshape(x(:,1),1800,[]))';
torque_average_2 = mean(reshape(x(:,2),1800,[]))';
torque_average_3 = mean(reshape(x(:,3),1800,[]))';
torque_average_4 = mean(reshape(x(:,4),1800,[]))';
torque_average_5 = mean(reshape(x(:,5),1800,[]))';
torque_average_6 = mean(reshape(x(:,6),1800,[]))';

torque_average = cat(2,torque_average_1,torque_average_2,torque_average_3,torque_average_4,torque_average_5,torque_average_6)
 

% 
% Torque with measurement noise	
% Add gaussian noise  - measurement
N = size(tau_1(1:216000,1),1);
% add 10% noise based on gaussian
scale = 0.1 ;
nl =  randn(1, N); % noise with mean=0 and std=1;
 y1 = x(:,1) + nl'.*x(:,1)*.1 ;
 y2 = x(:,2) + nl'.*x(:,2)*.1 ;
 y3 = x(:,3) + nl'.*x(:,3)*.1 ;
 y4 = x(:,4) + nl'.*x(:,4)*.1 ;
 y5 = x(:,5) + nl'.*x(:,5)*.1 ;
 y6 = x(:,6) + nl'.*x(:,6)*.1 ;
  
torque_average_2_1 = mean(reshape(y1,1800,[]))';
torque_average_2_2 = mean(reshape(y2,1800,[]))'; 
torque_average_2_3 = mean(reshape(y3,1800,[]))';
torque_average_2_4 = mean(reshape(y4,1800,[]))';
torque_average_2_5 = mean(reshape(y5,1800,[]))';
torque_average_2_6 = mean(reshape(y6,1800,[]))';
torque_average_mn = cat(2,torque_average_2_1,torque_average_2_2,torque_average_2_3,torque_average_2_4,torque_average_2_5,torque_average_2_6);

 


% Torque with Process nosie

j = 0;

for i =1 : 1:216000 
     nl_r = randn(1,6);
    % nl_r = randn(N,6);
    tau_pn(i,:) = p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:) )+ ...
               nl_r.*(p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:) ))*.1 ;
%      L(1).Tc = [0.395+0.5/(1+exp(-((j/300000)^5))) -0.435-0.5/(1+exp(-((j/300000)^5)))];
%      L(2).Tc = [0.126+0.5/(1+exp(-((j/300000)^5))) -0.071-0.5/(1+exp(-((j/300000)^5)))];
%      L(3).Tc = [0.132+0.5/(1+exp(-((j/300000)^5))) -0.105-0.5/(1+exp(-((j/300000)^5)))];
     j = j +2  ;
    time(i) = j;
end
 time_hours = time./(60*60);
% %TAU = vertcat(tau1,tau7);
% figure(4);
% plot(time, tau(:,1));
% set(gca,'PlotBoxAspectRatio',[5 2 1])
% xlabel('Time in seconds');
% ylabel('Torque Nm');
% qdd_legend = legend('Axis 1','Axis 2', 'Axis 3', 'Axis 4', 'Axis 5', 'Axis 6');
% set(qdd_legend,'FontSize',6);
% grid on;

x1 = tau_pn(1:216000,:);
x = abs(x1);

% Average torque per hour - 360* 5 (seconds)
torque_average_1 = mean(reshape(x(:,1),1800,[]))';
torque_average_2 = mean(reshape(x(:,2),1800,[]))';
torque_average_3 = mean(reshape(x(:,3),1800,[]))';
torque_average_4 = mean(reshape(x(:,4),1800,[]))';
torque_average_5 = mean(reshape(x(:,5),1800,[]))';
torque_average_6 = mean(reshape(x(:,6),1800,[]))';

torque_average_pn = cat(2,torque_average_1,torque_average_2,torque_average_3,torque_average_4,torque_average_5,torque_average_6)
 
 
% Torque with process noise and measurement noise

N = size(tau_pn(1:216000,1),1);
% add 10% noise based on gaussian
scale = 0.1 ;
nl =  randn(1, N); % noise with mean=0 and std=1;
 y1 = x(:,1) + nl'.*x(:,1)*.1 ;
 y2 = x(:,2) + nl'.*x(:,2)*.1 ;
 y3 = x(:,3) + nl'.*x(:,3)*.1 ;
 y4 = x(:,4) + nl'.*x(:,4)*.1 ;
 y5 = x(:,5) + nl'.*x(:,5)*.1 ;
 y6 = x(:,6) + nl'.*x(:,6)*.1 ;
  
torque_average_pn_mn_1 = mean(reshape(y1,1800,[]))';
torque_average_pn_mn_2 = mean(reshape(y2,1800,[]))'; 
torque_average_pn_mn_3 = mean(reshape(y3,1800,[]))';
torque_average_pn_mn_4 = mean(reshape(y4,1800,[]))';
torque_average_pn_mn_5 = mean(reshape(y5,1800,[]))';
torque_average_pn_mn_6 = mean(reshape(y6,1800,[]))';
torque_average_pn_mn = cat(2,torque_average_pn_mn_1,torque_average_pn_mn_2,torque_average_pn_mn_3,torque_average_pn_mn_4,torque_average_pn_mn_5,torque_average_pn_mn_6);

 
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
 




% Torque with friction change (without noise)
L = p560.links
j = 0;

for i =1 :1:216000 
     nl_r = randn(1,6);
     %nl_r = randn(N,6);
    tau_fc(i,:) = p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:)) ;
     L(1).Tc = [0.395+0.5/(1+exp(-((j/300000)^5))) -0.435-0.5/(1+exp(-((j/300000)^5)))];
     L(2).Tc = [0.126+0.5/(1+exp(-((j/300000)^5))) -0.071-0.5/(1+exp(-((j/300000)^5)))];
     L(3).Tc = [0.132+0.5/(1+exp(-((j/300000)^5))) -0.105-0.5/(1+exp(-((j/300000)^5)))];
     j = j +2 ;
    time(i) = j;
end
 time_hours = time./(60*60);
 
N = size(tau_fc(1:216000 ,1),1);
x1 = tau_fc(1:216000 ,:);
x = abs(x1);

 
 y1 = x(:,1)  ;
 y2 = x(:,2)   ;
 y3 = x(:,3)   ;
 y4 = x(:,4)  ;
 y5 = x(:,5) ;
 y6 = x(:,6)   ;
   
 
 
% 
% 
% % Average torque per hour - 360 * 10 (seconds)
torque_average_1 = mean(reshape(y1,1800,[]))';
torque_average_2 = mean(reshape(y2,1800,[]))';
torque_average_3 = mean(reshape(y3,1800,[]))';
torque_average_4 = mean(reshape(y4,1800,[]))';
torque_average_5 = mean(reshape(y5,1800,[]))';
torque_average_6 = mean(reshape(y6,1800,[]))';

torque_average_fc  = cat(2,torque_average_1,torque_average_2,torque_average_3,torque_average_4,torque_average_5,torque_average_6);
 


% 
% % Torque profile due to Load Change with Process Noise and Measurement
% % noise

j = 0;
counter_lc =   108000;

for i =1 : 1: counter_lc
     nl_r = randn(1,6);
    %nl_r = randn(N,6);
    tau_lc_pn(i,:) = p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:) )+ ...
               nl_r.*(p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:) ))*.1 ;
      j = j +2 ;

    time(i) = j;
end

for i =counter_lc+1 : 1: counter_lc*2
    p560.payload(10, [0,0,0.1]);
     nl_r = randn(1,6);
    %nl_r = randn(N,6);
    tau_lc_pn(i,:) = p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:) )+ ...
               nl_r.*(p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:) ))*.1 ;
      j = j +2 ;
 
    time(i) = j;
end

 time_hours = time./(60*60);
% %TAU = vertcat(tau1,tau7);
% figure(4);
% plot(time, tau(:,1));
% set(gca,'PlotBoxAspectRatio',[5 2 1])
% xlabel('Time in seconds');
% ylabel('Torque Nm');
% qdd_legend = legend('Axis 1','Axis 2', 'Axis 3', 'Axis 4', 'Axis 5', 'Axis 6');
% set(qdd_legend,'FontSize',6);
% grid on;

x1 = tau_lc_pn( 1:216000,:);
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

% Average torque per hour - 1800 * 2 (seconds)
torque_average_1 = mean(reshape(y1,1800,[]))';
torque_average_2 = mean(reshape(y2,1800,[]))';
torque_average_3 = mean(reshape(y3,1800,[]))';
torque_average_4 = mean(reshape(y4,1800,[]))';
torque_average_5 = mean(reshape(y5,1800,[]))';
torque_average_6 = mean(reshape(y6,1800,[]))';

torque_average_lc_pn_mn = cat(2,torque_average_1,torque_average_2,torque_average_3,torque_average_4,torque_average_5,torque_average_6)
 
torque_average_lc_pn_mn_m =cat(1, torque_average_pn_mn(1:60,:),torque_average_lc_pn_mn(61:120,:));
 figure(8);
subplot(2,1,1);
plot( torque_average);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Average Torque per hour','FontSize', 12);
xlabel('Time in hours','FontSize', 10);
ylabel('Average Torque (Nm) per hr','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;
subplot(2,1,2);
plot(torque_average_mn);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Average Torque per hour-with Measurement noise','FontSize', 12);
xlabel('Time in hours','FontSize', 10);
ylabel('Average Torque (Nm) per hr','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;
% 
figure(9);
subplot(2,1,1);
plot( torque_average_pn);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Average Torque per hour-with process nosie ','FontSize', 12);
xlabel('Time in hours','FontSize', 10);
ylabel('Average Torque (Nm) per hr','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;

subplot(2,1,2);
plot( torque_average_pn_mn);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Average Torque per hour-with process and measurement nosie ','FontSize', 12);
xlabel('Time in hours','FontSize', 10);
ylabel('Average Torque (Nm) per hr','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;

figure(10);
subplot(2,1,1);
plot( torque_average_fc );
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Average Torque per hour during friction change(without noise)','FontSize', 12);
xlabel('Time in hours','FontSize', 10);
ylabel('Average Torque (Nm) per hr','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;
subplot(2,1,2);
plot( torque_average_fc_pn_mn);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Average Torque per hour during friction change (with process and measurement nosie)','FontSize', 12);
xlabel('Time in hours','FontSize', 10);
ylabel('Average Torque (Nm) per hr','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;

figure(11);
 
plot( torque_average_lc_pn_mn_m);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Average Torqueper hour-pay load changed at 60th hour(with process and measurement nosie) ','FontSize', 12);
xlabel('Time in hours','FontSize', 10);
ylabel('Average Torque (Nm) per hr','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;

% % 
% % 
% %  
