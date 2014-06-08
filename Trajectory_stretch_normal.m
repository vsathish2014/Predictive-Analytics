% Example of movement of Robot manupulator:
 % Consider End effector moving between two cartesian poses
clear;
clc;
profile on
mdl_puma560
  p560.payload(0, [0,0,0.1]);

t = [0:5:20]';
t_cycle = [0:5:40];

[q1, qd1, qdd1] = jtraj(qr,qn,t);
[q2, qd2, qdd2] = jtraj(qn,qr,t);
ql= q1;
qdl = qd1;
qddl = qdd1;
ql = vertcat(ql,q2(2:5,:));
qdl = vertcat(qdl, qd2(2:5,:));
qddl = vertcat(qddl, qdd2(2:5,:));

tau_r_n = p560.rne(ql,qdl,qddl);

figure(1);
subplot(2,1,1);
plot(t_cycle,ql);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Joint angle in rad vs time for one cycle: Ready to Normal position','FontSize',14)
xlabel('Time in seconds','FontSize',12);
ylabel('Joint Angle in rad','FontSize',12);
c_legend = legend('Axis 1','Axis 2', 'Axis 3', 'Axis 4', 'Axis 5', 'Axis 6','FontSize',12);
 
clear q1 q2 qd1 qdd1 qd2 qdd2  ql qdl qddl;

[q1, qd1, qdd1] = jtraj(qr,qs,t);
[q2, qd2, qdd2] = jtraj(qs,qr,t);
ql= q1;
qdl = qd1;
qddl = qdd1;
ql = vertcat(ql,q2(2:5,:));
qdl = vertcat(qdl, qd2(2:5,:));
qddl = vertcat(qddl, qdd2(2:5,:));

subplot(2,1,2);
plot(t_cycle,ql);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Joint angle vs time for one cycle: Ready to Stretch position','FontSize',14)
xlabel('Time in seconds','FontSize',12);
ylabel('Joint Angle in rad','FontSize',12);
c_legend = legend('Axis 1','Axis 2', 'Axis 3', 'Axis 4', 'Axis 5', 'Axis 6','FontSize',12);

tau_r_s = p560.rne(ql,qdl,qddl);

figure(2);
subplot(2,1,1);
plot(t_cycle,tau_r_n);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Torque vs time for one cycle: Ready to Normal position','FontSize',14)
xlabel('Time in seconds','FontSize',12);
ylabel('Torque in Nm','FontSize',12);
set(gca, 'YTick',0:10:70, 'YLim',[0 60]);
c_legend = legend('Axis 1','Axis 2', 'Axis 3', 'Axis 4', 'Axis 5', 'Axis 6','FontSize',12);

subplot(2,1,2);
plot(t_cycle,tau_r_s);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Torque vs time for one cycle: Ready to Stretch position','FontSize',14)
xlabel('Time in seconds','FontSize',12);
ylabel('Torque in Nm','FontSize',12);
set(gca, 'YTick',0:10:70, 'YLim',[0 60])
c_legend = legend('Axis 1','Axis 2', 'Axis 3', 'Axis 4', 'Axis 5', 'Axis 6','FontSize',12);

