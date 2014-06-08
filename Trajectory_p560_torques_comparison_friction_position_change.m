% Example of movement of Robot manupulator:
% Consider End effector moving between two cartesian poses
% used teach method to use
% Changed the comment
clear;
clc;
profile on
mdl_puma560
  p560.payload(0, [0,0,0.1]);

% Initial and Joint corodinate vectors associated with the above poses are
%q1 = p560.ikine6s(T1);
%q_2 = p560.ikine6s(T2);
qe1 = [-2.7925   -0.7854   -3.9270   -1.9199   -1.7453   -4.6426];
qm = [0    1.5708   -1.5999    0.5236         0         0];
qe2 = [2.7925    3.9270    0.7854    2.9671    1.7453    4.6426];

% form normal movement  - checked qr to qn

% Motion to occur over a time period 2 seconds in 5 seconds time steps

t = [0:5:20]';
time_c = [0;5;10;15;20;25;30;35;40];

[q1, qd1, qdd1] = jtraj(qr,qn,t);
[q2, qd2, qdd2] = jtraj(qn,qr,t);
ql= q1;
qdl = qd1;
qddl = qdd1;
ql = vertcat(ql,q2(2:5,:));
qdl = vertcat(qdl, qd2(2:5,:));
qddl = vertcat(qddl, qdd2(2:5,:));

% Get the information for one cycle
q_c = ql;
qd_c = qdl;
qdd_c = qddl;


for i = 1:60*60*24*5/40

    [r1, qd1,qdd1] = jtraj(qr,qn,t);
     ql = vertcat(ql,r1(2:5,:));
     qdl = vertcat(qdl,qd1(2:5,:));
     qddl = vertcat(qddl,qdd1(2:5,:));
    [r2, qd2,qdd2] = jtraj(qn,qr,t);
% The following line is to view the figure in full screen
%f=figure('position', [10, 10, 1800, 1100]);
     ql = vertcat(ql,r2(2:5,:));
     qdl = vertcat(qdl,qd2(2:5,:));
     qddl = vertcat(qddl,qdd2(2:5,:));    

   
end
  
figure(3);

a= subplot(3,1,1);
 
plot(time_c,q_c);
set(gca,'PlotBoxAspectRatio',[5 2 1])
xlabel('Time in seconds','FontSize',10);
ylabel('Joint angle in rad','FontSize',10);
q_legend = legend('Axis 1','Axis 2', 'Axis 3', 'Axis 4', 'Axis 5', 'Axis 6');
set(q_legend,'FontSize',6);
set(q_legend,'PlotBoxAspectRatioMode','manual');
set(q_legend,'PlotBoxAspectRatio',[0.8 1 1]);
grid on

 
subplot(3,1,2);
plot(time_c,qd_c);
set(gca,'PlotBoxAspectRatio',[5 2 1])
xlabel('Time in seconds','FontSize',10);
ylabel('Velocity in rad/sec','FontSize',10);
qd_legend = legend('Axis 1','Axis 2', 'Axis 3', 'Axis 4', 'Axis 5', 'Axis 6');
set(qd_legend,'FontSize',6);
grid on

subplot(3,1,3);
plot(time_c,qdd_c);
set(gca,'PlotBoxAspectRatio',[5 2 1])
xlabel('Time in seconds','FontSize',10);
ylabel('Acceleration in rad/sec squared','FontSize',10);
qdd_legend = legend('Axis 1','Axis 2', 'Axis 3', 'Axis 4', 'Axis 5', 'Axis 6');
set(qdd_legend,'FontSize',6);
grid on
	
annotation('textbox', [0 0.9 1 0.1], ...
    'String', 'Trend of Position, Velocity and Acceleration', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center',....
    'FontSize',12)	
	
%tau1 = p560.rne(ql(1:100,:),qdl(1:100,:),qddl(1:100,:));
L = p560.links

m = 1; 
 
for k =0 :5: 60*60*24*5      
    coulomb(m,:) = [0.395+0.5/(1+exp(-((k/300000)^5))) -0.435-0.5/(1+exp(-((k/300000)^5)))];
    m= m+1;
end


j = 0;

for i =1 : 1:60*60*24*5*8 /40 
    nl_r = randn(1,6);
    tau(i,:) = p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:),[0 0 0])+ ...
               nl_r.*(p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:),[0 0 0]))*.1 ;
     L(1).Tc = [0.395+0.5/(1+exp(-((j/300000)^5))) -0.435-0.5/(1+exp(-((j/300000)^5)))];
     L(2).Tc = [0.126+0.5/(1+exp(-((j/300000)^5))) -0.071-0.5/(1+exp(-((j/300000)^5)))];
     L(3).Tc = [0.132+0.5/(1+exp(-((j/300000)^5))) -0.105-0.5/(1+exp(-((j/300000)^5)))];
     j = j +5  ;
    time(i) = j;
end
 time_hours = time./(60*60);
%TAU = vertcat(tau1,tau7);
figure(4);
plot(time, tau(:,1));
set(gca,'PlotBoxAspectRatio',[5 2 1])
xlabel('Time in seconds');
ylabel('Torque Nm');
qdd_legend = legend('Axis 1','Axis 2', 'Axis 3', 'Axis 4', 'Axis 5', 'Axis 6');
set(qdd_legend,'FontSize',6);
grid on;

figure(5);
plot(time_hours',coulomb(1:86400,1));
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Coulomb Friction change','FontSize', 14);
xlabel('Time in hours','FontSize', 12);
ylabel('Coulomb friction Nm','FontSize', 12);
qdd_legend = legend('Axis 1');
set(qdd_legend,'FontSize',6);
grid on;

x1 = tau(:,:);
x = abs(x1);

% Average torque per hour - 720 * 5 
torque_average_1 = mean(reshape(x(:,1),720,[]))';
torque_average_2 = mean(reshape(x(:,2),720,[]))';
torque_average_3 = mean(reshape(x(:,3),720,[]))';
torque_average_4 = mean(reshape(x(:,4),720,[]))';
torque_average_5 = mean(reshape(x(:,5),720,[]))';
torque_average_6 = mean(reshape(x(:,6),720,[]))';

torque_average = cat(2,torque_average_1,torque_average_2,torque_average_3,torque_average_4,torque_average_5,torque_average_6)
 

figure(6);
plot( torque_average);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Average Torque per hour','FontSize', 14);
xlabel('Time in hours','FontSize', 12);
ylabel('Average Torque (Nm) per hr','FontSize', 12);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;

% % Add gaussian noise  - measurement
% N = size(tau(:,1),1);
% % add 10% noise based on gaussian
% scale = 0.1 ;
% nl =  randn(1, N); % noise with mean=0 and std=1;
% y_n = tau(:,1);
% y = abs(y_n);
% y1 = y + nl'.*y*.1
% torque_average_2 = mean(reshape(y1,720,[]))';
 
 

p = profile('info');
save myprofiledata p
clear p
load myprofiledata
profview(0,p)

