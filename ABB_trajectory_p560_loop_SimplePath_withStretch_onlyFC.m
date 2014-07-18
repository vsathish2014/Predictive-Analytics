% ABB Trajecotry example
clear;
clc;
%profile on
mdl_puma560
  p560.payload(2.5, [0,0,0.1]);

% % q_1 = [-2.7925         0   -1.3381         0         0         0];
% % q_2 = [-0.0690   -0.0291   -1.3381         0         0         0];
  q_1 = [-2.7925   -0.7854   -3.9270   -1.9199   -1.7453   -4.6426];
  q_2 = [2.7925    3.9270    0.7854    2.9671    1.7453    4.6426];

Tq_1 = p560.fkine(q_1);
Tq_2 = p560.fkine(q_2);


path = [Tq_1(1:3,4)'; Tq_2(1:3,4)'];
  
%path = [ 0.5 -0.5 -0.5 ; 0.5 0.5 -0.5; -0.5 0.5 -0.5; -0.5 -0.5 -0.5;0.5 -0.5 -0.5 ];
%p_test = mstraj(path,[0.5 0.5 0.3],[],[0.5 -0.5 -0.5],0.02,0.2);
% p = mstraj(path,[0.5 0.5 0.3],[],[0.5 -0.5 -0.5],10,0.2);
% 
% Tp = transl(0.5*p);
% Tp = homtrans(transl(-0.8563 ,  -0.1520 ,   0.0798 ),Tp);
% q = p560.ikine6s(Tp);
% p560.plot(q);
% t = [0:2.5:10]';
% time_c = [0;2.5;5;7.5;10;12.5;15;17.5;20;22.5;25;27.5;30;32.5;35;37.5;40;42.5;45;47.5;50];
% j =1
% for i = 1: size(q,1)-1
%     [q_c(j:j+4,:), qd_c(j:j+4,:), qdd_c(j:j+4,:)] = jtraj(q(i,:),q(i+1,:),t);
%     j = j +4;
% end
time_c = [0;5;10;15;20;25;30;35;40;45;50];
  t = [0:5:25]';
% Half cycle information
[q_ch1 qd_ch1 qdd_ch1] = jtraj(q_1,q_2,t);

[q_ch2 qd_ch2 qdd_ch2] = jtraj(q_2,q_1,t);

q_c = cat(1,q_ch1(:,:),q_ch2(2:6,:));
qd_c = cat(1,qd_ch1(:,:),qd_ch2(2:6,:));
qdd_c = cat(1,qdd_ch1(:,:),qdd_ch2(2:6,:));

 

ql = q_c;
qdl = qd_c;
qddl = qdd_c;
 
for cycles = 1:8639
    ql = cat(1,ql,q_c(2:11,:));
    qdl = cat(1,qdl,qd_c(2:11,:));
    qddl =cat(1,qddl, qdd_c(2:11,:));
   
end



% Torque with friction change ( measurement noise and process noise)
L = p560.links
j = 0;

for i =1 : 1:60*60*24*5*10 /50 
     nl_r = randn(1,6);
     %nl_r = randn(N,6);
    tau_fc_pn(i,:) = p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:))+ ...
               nl_r.*(p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:) ))*.1 ;
     L(1).Tc = [0.395+0.5/(1+exp(-((j/300000)^5))) -0.435-0.5/(1+exp(-((j/300000)^5)))];
     L(2).Tc = [0.126+0.5/(1+exp(-((j/300000)^5))) -0.071-0.5/(1+exp(-((j/300000)^5)))];
     L(3).Tc = [0.132+0.5/(1+exp(-((j/300000)^5))) -0.105-0.5/(1+exp(-((j/300000)^5)))];
     j = j +5  ;
    time(i) = j;
end
 time_hours = time./(60*60);
 
N = size(tau_fc_pn(1:86400,1),1);
x1 = tau_fc_pn(1:86400,:);
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
   
 
 tau_fc_pn_mn_1 = reshape(y1,720,[])';
 tau_fc_pn_mn_2 = reshape(y2,720,[])';
 tau_fc_pn_mn_3 = reshape(y3,720,[])';
 tau_fc_pn_mn_4 = reshape(y4,720,[])';
 tau_fc_pn_mn_5 = reshape(y5,720,[])';
 tau_fc_pn_mn_6 = reshape(y6,720,[])';

 tau_fc_pn_mn = cat(2,y1,y2,y3,y4,y5,y6);
 
% Average torque per hour - 720 * 5 (seconds)
torque_average_1 = mean(reshape(y1,720,[]))';
torque_average_2 = mean(reshape(y2,720,[]))';
torque_average_3 = mean(reshape(y3,720,[]))';
torque_average_4 = mean(reshape(y4,720,[]))';
torque_average_5 = mean(reshape(y5,720,[]))';
torque_average_6 = mean(reshape(y6,720,[]))';

torque_average_fc_pn_mn = cat(2,torque_average_1,torque_average_2,torque_average_3,torque_average_4,torque_average_5,torque_average_6);

% Coriolis torque

coriolis_0 = p560.coriolis(ql(1,:),qdl(1,:))
coriolis_1 = p560.coriolis(ql(720,:),qdl(720,:))
coriolis_100 = p560.coriolis(ql(72000,:),qdl(72000,:))

% friction torque
F1_0 = p560.friction(qdl(1,:))
F1_1 = p560.friction(qdl(720,:))
F1_100 = p560.friction(qdl(72000,:))
figure(10);
 
plot( torque_average_fc_pn_mn);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Average Torque per hour during friction change','FontSize', 12);
xlabel('Time in hours','FontSize', 10);
ylabel('Average Torque (Nm) per hr','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;

figure(11);
subplot(3,1,1);
plot(time(14400:15120)',tau_fc_pn_mn(14400:15120,1:2)); % Changed only two axis
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Torque in 20th hour during friction change','FontSize', 12);
xlabel('Time in seconds','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
axis([time(14400)',time(15120)',0,200]);
grid on;
subplot(3,1,2);
plot(time(28800:29520)',tau_fc_pn_mn(28800:29520,1:2));
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Torque in 40th hour during friction change','FontSize', 12);
xlabel('Time in seconds','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
axis([time(28800)',time(29520)',0,200]);
grid on;

subplot(3,1,3);
plot(time(43200:43920)',tau_fc_pn_mn(43200:43920,1:2));
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Torque in 60th hour during friction change','FontSize', 12);
xlabel('Time in seconds','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
axis([time(43200)',time(43920)',0,200]);
grid on;


figure(12);
subplot(3,1,1);
plot(time(57600:58320)',tau_fc_pn_mn(57600:58320,1:2));
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Torque in 80th hour during friction change','FontSize', 12);
xlabel('Time in seconds','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
 axis([time(57600)',time(58320)',0,200]);
grid on;
subplot(3,1,2);
plot(time(72000:72720)',tau_fc_pn_mn(72000:72720,1:2));
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Torque in 100th hour during friction change','FontSize', 12);
xlabel('Time in seconds','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
axis([time(72000)',time(72720)',0,200]);
grid on;

subplot(3,1,3);
plot(time(85680:86400)',tau_fc_pn_mn(85680:86400,1:2));
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Torque in 119th hour during friction change','FontSize', 12);
xlabel('Time in seconds','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
axis([time(85680)',time(86400)',0,200]);
grid on;







% figure(11);
% subplot(2,1,2);
% plot( torque_average_lc_pn_mn_m);
% set(gca,'PlotBoxAspectRatio',[5 2 1])
% title('Trend: Average Torqueper hour-pay load changed at 60th hour(with process and measurement nosie) ','FontSize', 12);
% xlabel('Time in hours','FontSize', 10);
% ylabel('Average Torque (Nm) per hr','FontSize', 10);
% qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
% set(qdd_legend,'FontSize',6);
% grid on;



 
