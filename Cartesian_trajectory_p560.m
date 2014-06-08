% Example of movement of Robot manupulator:
% Consider End effector moving between two cartesian poses
% The location of end effector
% Test for checkout
clear;
clc;
profile on
mdl_puma560
  p560.payload(0, [0,0,0.1]);
T1 = fkine(p560,qr);
T2 = transl(0.4, -0.2, 0.2)* trotx(pi);
 
 
% Motion to occur over a time period 2 seconds in 50  ms time steps

t = [0:5:20]';

Ts1 = ctraj(T1,T2,length(t));
Ts2 = ctraj(T2,T1,length(t));
  Ts = Ts1 ;
  Ts = cat(3, Ts1,Ts2(:,:,2:5));
 

% for i = 2:60*60*24*5/40
% 
%     Ts_3 = ctraj(T1,T2,length(t));
%     Ts = cat(3,Ts,Ts_3(:,:,2:5));
%     Ts_4 = ctraj(T2,T1,length(t));
% % % The following line is to view the figure in full screen
% % %f=figure('position', [10, 10, 1800, 1100]);
%      Ts = cat(3,Ts,Ts_4(:,:,2:5));
%      
% end
%   
% figure(3);
% 
% a= subplot(3,1,1);
%  
% plot(ql);
% set(gca,'PlotBoxAspectRatio',[5 2 1])
% xlabel('Time steps of 50 ms');
% ylabel('Joint angle in rad');
% q_legend = legend('Axis 1','Axis 2', 'Axis 3', 'Axis 4', 'Axis 5', 'Axis 6');
% set(q_legend,'FontSize',6);
% set(q_legend,'PlotBoxAspectRatioMode','manual');
% set(q_legend,'PlotBoxAspectRatio',[0.8 1 1]);
% grid on

p = profile('info');
save myprofiledata p
clear p
load myprofiledata
profview(0,p)