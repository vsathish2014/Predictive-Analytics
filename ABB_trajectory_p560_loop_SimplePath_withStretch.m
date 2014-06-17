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

figure(1);
p560.plot(q_c(1,:));
figure(2);
p560.plot(q_c(3,:));
figure(3);
p560.plot(q_c(5,:));
figure(4);
p560.plot(q_c(8,:));
figure(5);
p560.plot(q_c(9,:));
figure(6);
p560.plot(q_c(11,:));

ql = q_c;
qdl = qd_c;
qddl = qdd_c;
 
for cycles = 1:8639
    ql = cat(1,ql,q_c(2:11,:));
    qdl = cat(1,qdl,qd_c(2:11,:));
    qddl =cat(1,qddl, qdd_c(2:11,:));
   
end


figure(7);

% Cartesian Position:
%  
% t : time for half cycle 
t = [0:5:25]';
t_cycle = [0:5:50];
Ts1 = ctraj(Tq_1,Tq_2,length(t));
Ts2 = ctraj(Tq_2,Tq_1,length(t));
Ts = Ts1 ;
Ts = cat(3, Ts1,Ts2(:,:,2:6));

 
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
set(q_legend,'PlotBoxAspectRatioMode','manual');
set(q_legend,'PlotBoxAspectRatio',[0.8 1 1]);
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

% Torque required moving between two stretch position

tau_1 = p560.rne(ql,qdl,qddl);
time = [0:5:432000];
time_hours = time./(60*60);


x1 = tau_1(1:86400,:);
x = abs(x1);

% Average torque per hour - 720 * 5 (seconds)
torque_average_1 = mean(reshape(x(:,1),720,[]))';
torque_average_2 = mean(reshape(x(:,2),720,[]))';
torque_average_3 = mean(reshape(x(:,3),720,[]))';
torque_average_4 = mean(reshape(x(:,4),720,[]))';
torque_average_5 = mean(reshape(x(:,5),720,[]))';
torque_average_6 = mean(reshape(x(:,6),720,[]))';

torque_average = cat(2,torque_average_1,torque_average_2,torque_average_3,torque_average_4,torque_average_5,torque_average_6)
 


	
% Add gaussian noise  - measurement
N = size(tau_1(1:86400,1),1);
% add 10% noise based on gaussian
scale = 0.1 ;
nl =  randn(1, N); % noise with mean=0 and std=1;
 y1 = x(:,1) + nl'.*x(:,1)*.1 ;
 y2 = x(:,2) + nl'.*x(:,2)*.1 ;
 y3 = x(:,3) + nl'.*x(:,3)*.1 ;
 y4 = x(:,4) + nl'.*x(:,4)*.1 ;
 y5 = x(:,5) + nl'.*x(:,5)*.1 ;
 y6 = x(:,6) + nl'.*x(:,6)*.1 ;
  
torque_average_2_1 = mean(reshape(y1,720,[]))';
torque_average_2_2 = mean(reshape(y2,720,[]))'; 
torque_average_2_3 = mean(reshape(y3,720,[]))';
torque_average_2_4 = mean(reshape(y4,720,[]))';
torque_average_2_5 = mean(reshape(y5,720,[]))';
torque_average_2_6 = mean(reshape(y6,720,[]))';
torque_average_with_measurement_noise = cat(2,torque_average_2_1,torque_average_2_2,torque_average_2_3,torque_average_2_4,torque_average_2_5,torque_average_2_6);

 


% Torque with Process nosie

j = 0;

for i =1 : 1:60*60*24*5*10 /50 
    nl_r = randn(1,6);
    tau_pn(i,:) = p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:),[0 0 0])+ ...
               nl_r.*(p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:),[0 0 0]))*.1 ;
%      L(1).Tc = [0.395+0.5/(1+exp(-((j/300000)^5))) -0.435-0.5/(1+exp(-((j/300000)^5)))];
%      L(2).Tc = [0.126+0.5/(1+exp(-((j/300000)^5))) -0.071-0.5/(1+exp(-((j/300000)^5)))];
%      L(3).Tc = [0.132+0.5/(1+exp(-((j/300000)^5))) -0.105-0.5/(1+exp(-((j/300000)^5)))];
     j = j +5  ;
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

x1 = tau_pn(1:86400,:);
x = abs(x1);

% Average torque per hour - 720 * 5 (seconds)
torque_average_1 = mean(reshape(x(:,1),720,[]))';
torque_average_2 = mean(reshape(x(:,2),720,[]))';
torque_average_3 = mean(reshape(x(:,3),720,[]))';
torque_average_4 = mean(reshape(x(:,4),720,[]))';
torque_average_5 = mean(reshape(x(:,5),720,[]))';
torque_average_6 = mean(reshape(x(:,6),720,[]))';

torque_average_pn = cat(2,torque_average_1,torque_average_2,torque_average_3,torque_average_4,torque_average_5,torque_average_6)
 
 



% Torque with Process nosie an friction change
L = p560.links
j = 0;

for i =1 : 1:60*60*24*5*10 /50 
    nl_r = randn(1,6);
    tau_fc_pn(i,:) = p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:),[0 0 0])+ ...
               nl_r.*(p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:),[0 0 0]))*.1 ;
     L(1).Tc = [0.395+0.5/(1+exp(-((j/300000)^5))) -0.435-0.5/(1+exp(-((j/300000)^5)))];
     L(2).Tc = [0.126+0.5/(1+exp(-((j/300000)^5))) -0.071-0.5/(1+exp(-((j/300000)^5)))];
     L(3).Tc = [0.132+0.5/(1+exp(-((j/300000)^5))) -0.105-0.5/(1+exp(-((j/300000)^5)))];
     j = j +5  ;
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

x1 = tau_fc_pn(1:86400,:);
x = abs(x1);

% Average torque per hour - 720 * 5 (seconds)
torque_average_1 = mean(reshape(x(:,1),720,[]))';
torque_average_2 = mean(reshape(x(:,2),720,[]))';
torque_average_3 = mean(reshape(x(:,3),720,[]))';
torque_average_4 = mean(reshape(x(:,4),720,[]))';
torque_average_5 = mean(reshape(x(:,5),720,[]))';
torque_average_6 = mean(reshape(x(:,6),720,[]))';

torque_average_fc_pn = cat(2,torque_average_1,torque_average_2,torque_average_3,torque_average_4,torque_average_5,torque_average_6)
 



% Torque profile due to Load Change and Process Noise

j = 0;

for i =1 : 1:60*60*24*5*10 /50 
    nl_r = randn(1,6);
    tau_lc_pn(i,:) = p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:),[0 0 0])+ ...
               nl_r.*(p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:),[0 0 0]))*.1 ;
%      L(1).Tc = [0.395+0.5/(1+exp(-((j/300000)^5))) -0.435-0.5/(1+exp(-((j/300000)^5)))];
%      L(2).Tc = [0.126+0.5/(1+exp(-((j/300000)^5))) -0.071-0.5/(1+exp(-((j/300000)^5)))];
%      L(3).Tc = [0.132+0.5/(1+exp(-((j/300000)^5))) -0.105-0.5/(1+exp(-((j/300000)^5)))];
     j = j +5 ;
         if j>=216000 
            p560.payload(10, [0,0,0.1]);
         else
            p560.payload(2.5, [0,0,0.1]);
         end 
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

x1 = tau_lc_pn(1:86400,:);
x = abs(x1);

% Average torque per hour - 720 * 5 (seconds)
torque_average_1 = mean(reshape(x(:,1),720,[]))';
torque_average_2 = mean(reshape(x(:,2),720,[]))';
torque_average_3 = mean(reshape(x(:,3),720,[]))';
torque_average_4 = mean(reshape(x(:,4),720,[]))';
torque_average_5 = mean(reshape(x(:,5),720,[]))';
torque_average_6 = mean(reshape(x(:,6),720,[]))';

torque_average_lc_pn = cat(2,torque_average_1,torque_average_2,torque_average_3,torque_average_4,torque_average_5,torque_average_6)
 
torque_average_lc_pn_m =cat(1, torque_average_pn(1:60,:),torque_average_lc_pn(61:120,:));
 figure(8);
subplot(3,1,1);
plot( torque_average);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Average Torque per hour','FontSize', 12);
xlabel('Time in hours','FontSize', 10);
ylabel('Average Torque (Nm) per hr','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;
subplot(3,1,2);
plot(torque_average_with_measurement_noise);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Average Torque per hour-with Measurement noise','FontSize', 12);
xlabel('Time in hours','FontSize', 10);
ylabel('Average Torque (Nm) per hr','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;
subplot(3,1,3);
plot( torque_average_pn);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Average Torque per hour-with process nosie ','FontSize', 12);
xlabel('Time in hours','FontSize', 10);
ylabel('Average Torque (Nm) per hr','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;
figure(9);
subplot(2,1,1);
plot( torque_average_fc_pn);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Average Torque per hour - with friction change and process nosie','FontSize', 12);
xlabel('Time in hours','FontSize', 10);
ylabel('Average Torque (Nm) per hr','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;

subplot(2,1,2);
plot( torque_average_lc_pn_m);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Average Torqueper hour-pay load changed at 60th hour(with process nosie) ','FontSize', 10);
xlabel('Time in hours','FontSize', 8);
ylabel('Average Torque (Nm) per hr','FontSize', 8);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;



% %tau1 = p560.rne(ql(1:100,:),qdl(1:100,:),qddl(1:100,:));
% L = p560.links
% 
% % m = 1; 
% %  
% % for k =0 :5: 60*60*24*5      
% %     coulomb(m,:) = [0.395+0.5/(1+exp(-((k/300000)^5))) -0.435-0.5/(1+exp(-((k/300000)^5)))];
% %     m= m+1;
% % end
% 
% 
% 
% 
% % figure(5);
% % plot(time_hours',coulomb(1:86400,1));
% % set(gca,'PlotBoxAspectRatio',[5 2 1])
% % title('Trend: Coulomb Friction change','FontSize', 14);
% % xlabel('Time in hours','FontSize', 12);
% % ylabel('Coulomb friction Nm','FontSize', 12);
% % qdd_legend = legend('Axis 1');
% % set(qdd_legend,'FontSize',6);
% % grid on;
% 
% x1 = tau(:,:);
% x = abs(x1);
% 
% % Average torque per hour - 1440 * 2.5 (seconds)
% torque_average_1 = mean(reshape(x(:,1),1440,[]))';
% torque_average_2 = mean(reshape(x(:,2),1440,[]))';
% torque_average_3 = mean(reshape(x(:,3),1440,[]))';
% torque_average_4 = mean(reshape(x(:,4),1440,[]))';
% torque_average_5 = mean(reshape(x(:,5),1440,[]))';
% torque_average_6 = mean(reshape(x(:,6),1440,[]))';
% 
% torque_average = cat(2,torque_average_1,torque_average_2,torque_average_3,torque_average_4,torque_average_5,torque_average_6)
%  
% 
% figure(6);
% plot( torque_average);
% set(gca,'PlotBoxAspectRatio',[5 2 1])
% title('Trend: Average Torque per hour','FontSize', 14);
% xlabel('Time in hours','FontSize', 12);
% ylabel('Average Torque (Nm) per hr','FontSize', 12);
% qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
% set(qdd_legend,'FontSize',6);
% grid on;
% 

%  
% 
% p = profile('info');
% save myprofiledata p
% clear p
% load myprofiledata
% profview(0,p)
% 
% %plot(q(:,1));
% %tau = p560.rne(q,qd,qdd);
% 
% 
