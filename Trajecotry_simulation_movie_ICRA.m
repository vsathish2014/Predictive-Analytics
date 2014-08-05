% ABB Trajecotry example
clear;
clc;
%profile on
mdl_puma560
  p560.payload(2.5, [0,0,0.1]);

% % q_1 = [-2.7925         0   -1.3381         0         0         0];
% % q_2 = [-0.0690   -0.0291   -1.3381         0         0         0];
%  q_1 = [-2.7925   -0.7854   -3.9270   -1.9199   -1.7453   -4.6426];
%  q_2 = [2.7925    3.9270    0.7854    2.9671    1.7453    4.6426];
  
  q_1 = [ -2.7925    0.2036   -1.5126   -1.9199   -1.7453    0.0000];
  q_2 = [0.0690   -0.0582   -3.1125   -1.9199   -1.7453    0.0000]

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
time_c = [0;5;10;15;20;25;30;35;40;45;50;55;60];
  t = [0:1:30]';
% Half cycle information
[q_ch1 qd_ch1 qdd_ch1] = jtraj(q_1,q_2,t);

[q_ch2 qd_ch2 qdd_ch2] = jtraj(q_2,q_1,t);

[lrow lcol] = size(q_ch1);

q_c = cat(1,q_ch1(:,:),q_ch2(2:lrow,:));
qd_c = cat(1,qd_ch1(:,:),qd_ch2(2:lrow,:));
qdd_c = cat(1,qdd_ch1(:,:),qdd_ch2(2:lrow,:));

% figure(1);
% p560.plot(q_c(1,:));
% figure(2);
% p560.plot(q_c(3,:));
% figure(3);
% p560.plot(q_c(5,:));
% figure(4);
% p560.plot(q_c(8,:));
% figure(5);
% p560.plot(q_c(9,:));
% figure(6);
% p560.plot(q_c(11,:));

ql = q_c;
qdl = qd_c;
qddl = qdd_c;

[lrow_c lcol_c] = size(q_c);

simDuration = 10; % in seconds
 
  for cycles = 1:(simDuration/(lrow_c-1))-1
      ql = cat(1,ql,q_c(2:lrow_c,:));
      qdl = cat(1,qdl,qd_c(2:lrow_c,:));
      qddl =cat(1,qddl, qdd_c(2:lrow_c,:));
     
  end
  for i= 1: 5
  p560.plot(q_c)
  end
  