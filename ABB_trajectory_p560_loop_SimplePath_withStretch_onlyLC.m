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



 
L = p560.links
 

% Torque profile due to Load Change with Process Noise and Measurement
% noise

j = 0;
for m=1: 60*60*24*5*10 /(50)
       j = j +5 ;
   
       time(m) = j;
       
end
% counter_lc = 60*60*24*5*10 /(2*50);
increment = 720; % for One hour

for k = 1:2:119
   % if 2.5*(1+0.01)^k < 2.75
       p560.payload( 2.5 , [0,0,0.1]);   
     
    for i = increment*(k-1)+1: 1: (k )*increment
         nl_r = randn(1,6);
        %nl_r = randn(N,6);
        tau_lc_pn(i,:) = p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:) )+ ...
               nl_r.*(p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:) ))*.1 ;

    end
end

for k = 2:2:120
   % if 2.5*(1+0.01)^k < 2.75
       p560.payload( 5 , [0,0,0.1]);   
     
    for i = increment*(k-1)+1: 1: (k )*increment
         nl_r = randn(1,6);
        %nl_r = randn(N,6);
        tau_lc_pn(i,:) = p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:) )+ ...
               nl_r.*(p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:) ))*.1 ;
    
    end
end
 

 time_hours = time./(60*60);
 
x1 = tau_lc_pn(1:86400,:);

x = abs(x1);
% add 10% noise based on gaussian
N = size(tau_lc_pn(1:86400,1),1);
scale = 0.1 ;
nl =  randn(1, N); % noise with mean=0 and std=1;
 y1 = x(:,1) + nl'.*x(:,1)*.1 ;
 y2 = x(:,2) + nl'.*x(:,2)*.1 ;
 y3 = x(:,3) + nl'.*x(:,3)*.1 ;
 y4 = x(:,4) + nl'.*x(:,4)*.1 ;
 y5 = x(:,5) + nl'.*x(:,5)*.1 ;
 y6 = x(:,6) + nl'.*x(:,6)*.1 ;
tau_lc_pn_mn = cat(2,y1,y2,y3,y4,y5,y6);

% Average torque per hour - 720 * 5 (seconds)
torque_average_1 = mean(reshape(y1,720,[]))';
torque_average_2 = mean(reshape(y2,720,[]))';
torque_average_3 = mean(reshape(y3,720,[]))';
torque_average_4 = mean(reshape(y4,720,[]))';
torque_average_5 = mean(reshape(y5,720,[]))';
torque_average_6 = mean(reshape(y6,720,[]))';

torque_average_lc_pn_mn = cat(2,torque_average_1,torque_average_2,torque_average_3,torque_average_4,torque_average_5,torque_average_6)
 
 


figure(1);
 
plot( torque_average_lc_pn_mn);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Average Torque with cyclic load change from 2.5 to 5 in every hour','FontSize', 12);
xlabel('Time in hours','FontSize', 10);
ylabel('Average Torque (Nm) per hr','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;


 figure(2);
subplot(3,1,1);
plot(time(14388:14412)',tau_lc_pn_mn(14388:14412,1:3));
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Torque 1 minute before and after payload change','FontSize', 12); % Changed 5 min to 1 min
xlabel('Time in seconds','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
axis([time(14388)',time(14412)',0,80]);
grid on;
% Draw a line at change in load
 yL = get(gca,'YLim');
line ([time(14400)' time(14400)'],yL,'LineStyle',':','Color','r','LineWidth',3);
subplot(3,1,2);
plot(time(28788:28812)',tau_lc_pn_mn(28788:28812,1:3));
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Torque 1 minute before ad after payload change','FontSize', 12);
xlabel('Time in seconds','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
axis([time(28788)',time(28812)',0,80]);
grid on;
% Draw a line at change in load
 yL = get(gca,'YLim');
line ([time(28800)' time(28800)'],yL,'LineStyle',':','Color','r','LineWidth',3);
subplot(3,1,3);
plot(time(43188:43212)',tau_lc_pn_mn(43188:43212,1:3));
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Torque 1 minute before ad after payload change','FontSize', 12);
xlabel('Time in seconds','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
axis([time(43188)',time(43212)',0,80]);
grid on;
% Draw a line at change in load
 yL = get(gca,'YLim');
line ([time(43200)' time(43200)'],yL,'LineStyle',':','Color','r','LineWidth',3);
% 
 
