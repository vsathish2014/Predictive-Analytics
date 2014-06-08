% need to run Trahectory_p560_loop_Friction
N = size(tau(:,1),1);
% add 10% noise based on gaussian
scale = 0.1 ;
nl =  randn(1, N); % noise with mean=0 and std=1;
y = tau(:,1);
y1 = y + nl'.*y*.1
torque_average_2 = mean(reshape(y1,720,[]))';
torque_average_hc1 = mean(reshape(y1,4,[]))';
for o = 1:120
    
    torque1(o,1) = torque_average_hc1(o*180,1);
    
end
figure(1);
plot(y1);
xlabel('Time in seconds');
figure(2);
plot( torque_average_2 );
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Average torque per hour','FontSize',12);
xlabel('Time in hours','FontSize',10);
ylabel('Average Torque (Nm) per hr','FontSize',10);
qdd_legend = legend('Axis 1');
set(qdd_legend,'FontSize',6);
grid on;

figure(3);
plot( torque1 );
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Torque sampled on an hourly basis from positive torque(averaged per cycle)','FontSize',12);
xlabel('Time in hours','FontSize',10);
ylabel(' Torque (Nm) sampled after 1 hr','FontSize',10);
qdd_legend = legend('Axis 1');
set(qdd_legend,'FontSize',6);
grid on;