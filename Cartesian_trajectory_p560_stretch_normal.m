% Example of movement of Robot manupulator:
% Consider End effector moving between two cartesian poses
% The location of end effector
clear;
clc;
profile on
mdl_puma560
  p560.payload(0, [0,0,0.1]);
  qe1 = [-2.7925   -0.7854   -3.9270   -1.9199   -1.7453   -4.6426];
  qe2 = [2.7925    3.9270    0.7854    2.9671    1.7453    4.6426];
Tr = fkine(p560,qr);
Tn = fkine(p560,qn);
Tst = fkine(p560,qs);
Te1 = fkine(p560,qe1);
Te2 = fkine(p560,qe2);

% From Ready to Normal position 
% t : time for half cycle 
t = [0:5:20]';
t_cycle = [0:5:40];
Ts1 = ctraj(Tr,Tn,length(t));
Ts2 = ctraj(Tn,Tr,length(t));
Ts = Ts1 ;
Ts = cat(3, Ts1,Ts2(:,:,2:5));

figure(1); 
subplot(2,1,1);
plot(t_cycle,transl(Ts));
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Cartesian Postion vs time for one cycle: Ready to Normal position','FontSize',14)
xlabel('Time in seconds','FontSize',12);
ylabel('Position','FontSize',12);
c_legend = legend('x axis','y axis', 'z axis','FontSize',12);
% set(q_legend,'FontSize',6);
 
% From ready to stretch position

Ts3 = ctraj(Tr,Tst,length(t));
Ts4 = ctraj(Tst,Tr,length(t));
Ts = Ts3 ;
Ts = cat(3, Ts3,Ts4(:,:,2:5));

subplot(2,1,2);  
plot(t_cycle,transl(Ts));
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Cartesian Postion vs time for one cycle: Ready to Stretch position','FontSize',14)
xlabel('Time in seconds','FontSize',12);
ylabel('Position','FontSize',12);
c_legend = legend('x axis','y axis', 'z axis','FontSize',12);

% Compatring ready to normal and extremes

Ts5 = ctraj(Tr,Tn,length(t));
Ts6 = ctraj(Tn,Tr,length(t));
Ts = Ts5 ;
Ts = cat(3, Ts5,Ts6(:,:,2:5));

figure(1); 
subplot(2,1,1);
plot(t_cycle,transl(Ts));
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Cartesian Postion vs time for one cycle: Ready to Normal position','FontSize',14)
xlabel('Time in seconds','FontSize',12);
ylabel('Position','FontSize',12);
c_legend = legend('x axis','y axis', 'z axis','FontSize',12);
% set(q_legend,'FontSize',6);
 
% From ready to stretch position

Ts7 = ctraj(Te1,Te2,length(t));
Ts8 = ctraj(Te2,Te1,length(t));
Ts = Ts7 ;
Ts = cat(3, Ts7,Ts8(:,:,2:5));

subplot(2,1,2);  
plot(t_cycle,transl(Ts));
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Cartesian Postion vs time for one cycle: Between extreme positions','FontSize',14)
xlabel('Time in seconds','FontSize',12);
ylabel('Position','FontSize',12);
c_legend = legend('x axis','y axis', 'z axis','FontSize',12);


  

p = profile('info');
save myprofiledata p
clear p
load myprofiledata
profview(0,p)