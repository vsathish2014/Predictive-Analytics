% Example of movement of Robot manupulator:
% Consider End effector moving between two cartesian poses
% Changed the comment
clear;
clc;
profile on
mdl_puma560
  p560.payload(0, [0,0,0.1]);
T1 = transl(0.4, 0.2, 0)* trotx(pi);
T2 = transl(0.4, -0.2, 0.2)* trotx(pi);
 

% Initial and Joint corodinate vectors associated with the above poses are
q1 = p560.ikine6s(T1);
q_2 = p560.ikine6s(T2);
 

% Motion to occur over a time period 2 seconds in 50  ms time steps

%t = [0:0.05:20]';
t = [0:5:20]';

[q1, qd1, qdd1] = jtraj(qr,q_2,t);
[q2, qd2, qdd2] = jtraj(q_2,qr,t);
ql= q1;
qdl = qd1;
qddl = qdd1;
ql = vertcat(ql,q2(2:5,:));
qdl = vertcat(qdl, qd2(2:5,:));
qddl = vertcat(qddl, qdd2(2:5,:));

for i = 1:60*60/40

    [r1, qd1,qdd1] = jtraj(qr, q_2,t);
    % ql = vertcat(ql,r1(2:401,:));
     ql = vertcat(ql,r1(2:5,:));
     qdl = vertcat(qdl,qd1(2:5,:));
     qddl = vertcat(qddl,qdd1(2:5,:));
    [r2, qd2,qdd2] = jtraj(q_2, qr,t);
% The following line is to view the figure in full screen
%f=figure('position', [10, 10, 1800, 1100]);
     ql = vertcat(ql,r2(2:5,:));
     qdl = vertcat(qdl,qd2(2:5,:));
     qddl = vertcat(qddl,qdd2(2:5,:));
     
   
%     if i==2
%         mdl_puma560_modified
%     end
        
     
    i = i +1;
  
   
   
end
 % The following line is to view the figure in full screen
% f=figure('position', [10, 10, 1800, 1100]);
% 
%  p560.plot(ql)
%  ql = ql(12:121,:);
%    qdl = qdl(12:121,:);
%    qddl = qddl(12:121,:);
 
figure(3);

a= subplot(3,1,1);
 
plot(ql);
set(gca,'PlotBoxAspectRatio',[5 2 1])
xlabel('Time steps of 50 ms');
ylabel('Joint angle in rad');
q_legend = legend('Axis 1','Axis 2', 'Axis 3', 'Axis 4', 'Axis 5', 'Axis 6');
set(q_legend,'FontSize',6);
set(q_legend,'PlotBoxAspectRatioMode','manual');
set(q_legend,'PlotBoxAspectRatio',[0.8 1 1]);
grid on

 
subplot(3,1,2);
plot(qdl);
set(gca,'PlotBoxAspectRatio',[5 2 1])
xlabel('Time steps of 50 ms');
ylabel('Velocity in rad/sec');
qd_legend = legend('Axis 1','Axis 2', 'Axis 3', 'Axis 4', 'Axis 5', 'Axis 6');
set(qd_legend,'FontSize',6);
grid on

subplot(3,1,3);
plot(qddl);
set(gca,'PlotBoxAspectRatio',[5 2 1])
xlabel('Time steps of 50 ms');
ylabel('Acceleration in rad/sec squared');
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
 
for k =0 :5: 60*60      
    coulomb(m,:) = [0.395+0.5/(1+exp(-((k/300000)^5))) -0.435-0.5/(1+exp(-((k/300000)^5)))];
    m= m+1;
end


j = 0;

for i =1 : 1:60*60*4  /40 
    
    tau(i,:) = p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:),[0 0 0]);
     L(1).Tc = [0.395+0.5/(1+exp(-((j/300000)^5))) -0.435-0.5/(1+exp(-((j/300000)^5)))];
     j = j +5  ;
   % j = j +0.05  ;
    time(i) = j;
end
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
%plot(time',coulomb(1:72000,1));
plot(time',coulomb(1:360,1));
set(gca,'PlotBoxAspectRatio',[5 2 1])
xlabel('Time steps of 50 ms');
ylabel('Coulomb friction Nm');
qdd_legend = legend('Axis 1');
set(qdd_legend,'FontSize',6);
grid on;

x = tau(:,1)
% Average torque per hour - 720 * 5 
torque_average_1 = mean(reshape(x,12,[]))';

% Average torque per half cycle - 4 readings - 20 seconds - this is to
% avoid cancellation of postive and negative values
torque_average_hc = mean(reshape(x,400,[]))';

% Torque sampled after one hour based average torque calulated on half
% cycle basis

for m = 1:60
    
    torque(m,1) = torque_average_hc(m*60,1);
    
end

figure(6);
plot( torque_average_1 );
set(gca,'PlotBoxAspectRatio',[5 2 1])
xlabel('Time in hours');
ylabel('Average Torque (Nm) per hr');
qdd_legend = legend('Axis 1');
set(qdd_legend,'FontSize',6);
grid on;

figure(7);
plot( torque );
set(gca,'PlotBoxAspectRatio',[5 2 1])
xlabel('Time in hours');
ylabel(' Torque (Nm) sampled after 1 hr');
qdd_legend = legend('Axis 1');
set(qdd_legend,'FontSize',6);
grid on;

p = profile('info');
save myprofiledata p
clear p
load myprofiledata
profview(0,p)

