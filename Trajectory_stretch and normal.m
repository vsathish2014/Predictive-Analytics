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

plot(t_cycle,ql);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Joint angle in rad vs time for one cycle: Ready to Normal position','FontSize',14)
xlabel('Time in seconds','FontSize',12);
ylabel('Position','FontSize',12);
c_legend = legend('x axis','y axis', 'z axis','FontSize',12);