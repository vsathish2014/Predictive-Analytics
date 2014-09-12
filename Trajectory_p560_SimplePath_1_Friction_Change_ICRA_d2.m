% ABB Trajecotry example
clear;
clc;
%profile on
mdl_puma560
  p560.payload(2.5, [0,0,0.1]);

% % q_1 = [-2.7925         0   -1.3381         0         0         0];
% % q_2 = [-0.0690   -0.0291   -1.3381         0         0         0];
%Earlier experiments
  %q_1 = [-2.7925   -0.7854   -3.9270   -1.9199   -1.7453   -4.6426];
  %q_2 = [2.7925    3.9270    0.7854    2.9671    1.7453    4.6426];
  
  q_1 = [ -2.7925    0.2036   -1.5126   -1.9199   -1.7453    0.0000];
  q_2 = [0.0690   -0.0582   -3.1125   -1.9199   -1.7453    0.0000];

Tq_1 = p560.fkine(q_1);
Tq_2 = p560.fkine(q_2);


path = [Tq_1(1:3,4)'; Tq_2(1:3,4)'];
  
 
time_c = [0;5;10;15;20;25;30;35;40;45;50;55;60];
  t = [0:5:30]';
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

simDuration = 720; % in seconds
 
  for cycles = 1:(simDuration/(lrow_c-1))-1
      ql = cat(1,ql,q_c(2:lrow_c,:));
      qdl = cat(1,qdl,qd_c(2:lrow_c,:));
      qddl =cat(1,qddl, qdd_c(2:lrow_c,:));
     
  end
  
% Introduced measurement noise for joint angle, velocity and acceleration: - 
  
[lrow_p lcol_p] = size(ql);

N = size(ql(1:lrow_p,1),1);
% add 10% noise based on gaussian
scale_ql = 0.0025;
scale_qdl = scale_ql*2;
scale_qddl = scale_ql*4;

nl =  randn(1, N); % noise with mean=0 and std=1;

 y1 = ql(:,1) + nl'.*ql(:,1)*scale_ql ;
 y2 = ql(:,2) + nl'.*ql(:,2)*scale_ql ;
 y3 = ql(:,3) + nl'.*ql(:,3)*scale_ql ;
 y4 = ql(:,4) + nl'.*ql(:,4)*scale_ql ;
 y5 = ql(:,5) + nl'.*ql(:,5)*scale_ql ;
 y6 = ql(:,6) + nl'.*ql(:,6)*scale_ql ;
 
ql_mn_1 = cat(2,y1,y2,y3,y4,y5,y6); 

clear y1,y2,y3,y4,y5,y6;

 y1 = qdl(:,1) + nl'.*qdl(:,1)*scale_qdl ;
 y2 = qdl(:,2) + nl'.*qdl(:,2)*scale_qdl ;
 y3 = qdl(:,3) + nl'.*qdl(:,3)*scale_qdl ;
 y4 = qdl(:,4) + nl'.*qdl(:,4)*scale_qdl ;
 y5 = qdl(:,5) + nl'.*qdl(:,5)*scale_qdl ;
 y6 = qdl(:,6) + nl'.*qdl(:,6)*scale_qdl ;
  
 
qdl_mn_1 = cat(2,y1,y2,y3,y4,y5,y6); 

clear y1,y2,y3,y4,y5,y6;

 y1 = qddl(:,1) + nl'.*qddl(:,1)*scale_qddl ;
 y2 = qddl(:,2) + nl'.*qddl(:,2)*scale_qddl ;
 y3 = qddl(:,3) + nl'.*qddl(:,3)*scale_qddl ;
 y4 = qddl(:,4) + nl'.*qddl(:,4)*scale_qddl ;
 y5 = qddl(:,5) + nl'.*qddl(:,5)*scale_qddl ;
 y6 = qddl(:,6) + nl'.*qddl(:,6)*scale_qddl ;
  
 
qddl_mn_1 = cat(2,y1,y2,y3,y4,y5,y6); 



% % Torque required moving between two stretch position
% 

% Torque after friction change for Axis 2.

L = p560.links
 
 
time = [0:5:simDuration];
 time_minutes = time./(60);

 
 
% Torque  

j = 0;
 
for  i =1 : 1:lrow_p 
  
    tau_1(i,:)  = p560.rne(ql_mn_1(i,:),qdl_mn_1(i,:), qddl_mn_1(i ,:) )  ;           
    f_1(i,:)= p560.friction(qdl_mn_1(i,:)) ;                  
    i_1(i,:)= p560.itorque(ql_mn_1(i,:),qddl_mn_1(i ,:)) ;             
    c_1(i,:)= (p560.coriolis(ql_mn_1(i,:),qdl_mn_1(i ,:))*qdl_mn_1(i,:)')' ; 
    g_1(i,:) =p560.gravload(qdl_mn_1(i,:)) ;
              
 
% Modify the axis to increase friction for 5 %

% friction change 10%  
  L(1).Tc = [0.395+0.5/(1+exp(-((j/4791.5)^4)))-0.25 -0.435-0.5/(1+exp(-((j/4791.5)^4)))+0.25];
 %   L(2).Tc = [0.126+0.5/(1+exp(-((j/6387.7)^4)))-0.25 -0.071-0.5/(1+exp(-((j/6387.7)^4)))+0.25];
  % L(3).Tc = [0.132+0.5/(1+exp(-((j/6313.7)^4)))-0.25 -0.105-0.5/(1+exp(-((j/6313.7)^4)))+0.25];
%   L(4).Tc =  [11.2e-3+0.5/(1+exp(-((j/11701)^4)))-0.25 -16.9e-3-0.5/(1+exp(-((j/11701)^4)))+0.25];
%   L(5).Tc = [11.2e-3+0.5/(1+exp(-((j/12271)^4)))-0.25 -16.9e-3-0.5/(1+exp(-((j/12271)^4)))+0.25];   
%   L(6).Tc = [3.96e-3+0.5/(1+exp(-((j/15174)^4)))-0.25 -10.5e-3-0.5/(1+exp(-((j/15174)^4)))+0.25];
 
  
  % friction change 50%  
  %  L(1).Tc = [0.395+0.5/(1+exp(-((j/2975.5)^4)))-0.25 -0.435-0.5/(1+exp(-((j/2975.5)^4)))+0.25];


     j = j +5  ;
    time(i) = j;
end
 

%
 
% Copy dat awith only ine type of measurement - 

tau_pn_mn_1 = tau_1;
f_pn_mn_1 = f_1 ;
i_pn_mn_1 = i_1 ;
c_pn_mn_1 = c_1;
g_pn_mn_1 = g_1;

  

 time_minutes = time./(60);
