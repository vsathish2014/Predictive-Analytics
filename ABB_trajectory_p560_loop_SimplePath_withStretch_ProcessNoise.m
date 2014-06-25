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





% Torque with Process nosie

j = 0;

for i =1 : 1:60*60*24*5*10 /50 
    nl_r = randn(1,6);
   %  nl_r = randn(N,6);
    tau_pn(i,:) = p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:) )+ ...
               nl_r.*(p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:)) )*.1 ;
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
 
 

  
figure(9);
subplot(2,1,1);
plot( torque_average_pn);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Average Torque per hour - with friction change and process nosie','FontSize', 12);
xlabel('Time in hours','FontSize', 10);
ylabel('Average Torque (Nm) per hr','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;

subplot(2,1,2);
plot( torque_average_lc_pn);
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
