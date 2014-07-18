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
time_c = [0;5;10;15;20;25;30;35;40;45;50];
  t = [0:5:25]';
% Half cycle information
[q_ch1 qd_ch1 qdd_ch1] = jtraj(q_1,q_2,t);

[q_ch2 qd_ch2 qdd_ch2] = jtraj(q_2,q_1,t);

q_c = cat(1,q_ch1(:,:),q_ch2(2:6,:));
qd_c = cat(1,qd_ch1(:,:),qd_ch2(2:6,:));
qdd_c = cat(1,qdd_ch1(:,:),qdd_ch2(2:6,:));

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
 
% for cycles = 1:5
%     ql = cat(1,ql,q_c(2:11,:));
%     qdl = cat(1,qdl,qd_c(2:11,:));
%     qddl =cat(1,qddl, qdd_c(2:11,:));
%    
% end


figure(1);

% Cartesian Position:
%  
% t : time for half cycle 
t = [0:5:25]';
t_cycle = [0:5:50];
Ts1 = ctraj(Tq_1,Tq_2,length(t));
Ts2 = ctraj(Tq_2,Tq_1,length(t));
Ts = Ts1 ;
Ts = cat(3, Ts1,Ts2(:,:,2:6));

 
subplot(3,1,1);
plot(t_cycle,transl(Ts));
set(gca,'PlotBoxAspectRatio',[5 2 1])
%title('Cartesian Postion vs time for one cycle: Ready to Normal position','FontSize',14)
xlabel('Time in seconds','FontSize',10);
ylabel('Position(meters)','FontSize',10);
c_legend = legend('x axis','y axis', 'z axis','FontSize',6);



a= subplot(3,1,2);
 
plot(time_c,q_c);
set(gca,'PlotBoxAspectRatio',[5 2 1])
xlabel('Time in seconds','FontSize',10);
ylabel('Joint angle(radians)','FontSize',10);
q_legend = legend('Axis 1','Axis 2', 'Axis 3', 'Axis 4', 'Axis 5', 'Axis 6');
set(q_legend,'FontSize',6);
% set(q_legend,'PlotBoxAspectRatioMode','manual');
% set(q_legend,'PlotBoxAspectRatio',[0.8 1 1]);
grid on

 
subplot(3,1,3);
plot(time_c,qd_c);
set(gca,'PlotBoxAspectRatio',[5 2 1])
xlabel('Time in seconds','FontSize',10);
ylabel('Velocity (rad/sec)','FontSize',10);
qd_legend = legend('Axis 1','Axis 2', 'Axis 3', 'Axis 4', 'Axis 5', 'Axis 6');
set(qd_legend,'FontSize',6);
grid on

% subplot(3,1,3);
% plot(time_c,qdd_c);
% set(gca,'PlotBoxAspectRatio',[5 2 1])
% xlabel('Time in seconds','FontSize',10);
% ylabel('Acceleration - rad/sec squared','FontSize',10);
% qdd_legend = legend('Axis 1','Axis 2', 'Axis 3', 'Axis 4', 'Axis 5', 'Axis 6');
% set(qdd_legend,'FontSize',6);
% grid on
	
annotation('textbox', [0 0.9 1 0.1], ...
    'String', 'Trend of Position, Joint Angle and Velocity', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center',....
    'FontSize',12)	

% Torque required moving between two stretch position

tau_1 = p560.rne(ql,qdl,qddl);
time = [0:5:11];
% time_hours = time./(60*60);


x2 = tau_1(1:11,:);
x = abs(x2);




% Torque with Process nosie

j = 0;

for i =1 : 1:11
     nl_r = randn(1,6);
    % nl_r = randn(N,6);
    scale = 0.01
    tau_pn_1(i,:) = p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:) )+ ...
               nl_r.*(p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:) ))*scale ;
    f_pn_1(i,:)= p560.friction(qdl(i,:))+...
                      nl_r.*p560.friction(qdl(i,:))*scale;
    i_pn_1(i,:)= p560.itorque(ql(i,:),qddl(i ,:))+...
                  nl_r.*p560.itorque(ql(i,:),qddl(i ,:))*scale;              
    c_pn_1(:,i) = (p560.coriolis(ql(i,:),qdl(i ,:))*qdl(i,:)')' +...
                  nl_r.*(p560.coriolis(ql(i,:),qdl(i ,:))*qdl(i,:)')'*scale; 
    g_pn_1(i,:) = p560.gravload(qdl(i,:))+....
                   nl_r.*p560.gravload(qdl(i,:))*scale;  
                      
%      L(1).Tc = [0.395+0.5/(1+exp(-((j/300000)^5))) -0.435-0.5/(1+exp(-((j/300000)^5)))];
%      L(2).Tc = [0.126+0.5/(1+exp(-((j/300000)^5))) -0.071-0.5/(1+exp(-((j/300000)^5)))];
%      L(3).Tc = [0.132+0.5/(1+exp(-((j/300000)^5))) -0.105-0.5/(1+exp(-((j/300000)^5)))];
     j = j +5  ;
    time(i) = j;
end
 

x1 = tau_pn_1(1:11,:);
fx1 = f_pn_1(1:11,:);
ix1 = i_pn_1(1:11,:);
cx1 = c_pn_1(:,1:11)';
gx1 = g_pn_1(1:11,:);

x = abs(x1);
 
 
% Torque with process noise and measurement noise

N = size(tau_pn_1(1:11,1),1);
% add 10% noise based on gaussian
 
nl =  randn(1, N); % noise with mean=0 and std=1;
 y1 = x1(:,1) + nl'.*x1(:,1)*scale ;
 y2 = x1(:,2) + nl'.*x1(:,2)*scale ;
 y3 = x1(:,3) + nl'.*x1(:,3)*scale ;
 y4 = x1(:,4) + nl'.*x1(:,4)*scale ;
 y5 = x1(:,5) + nl'.*x1(:,5)*scale ;
 y6 = x1(:,6) + nl'.*x1(:,6)*scale ;
 
tau_pn_mn_1 = cat(2,y1,y2,y3,y4,y5,y6);

y1 = fx1(:,1) + nl'.*fx1(:,1)*scale ;
 y2 = fx1(:,2) + nl'.*fx1(:,2)*scale ;
 y3 = fx1(:,3) + nl'.*fx1(:,3)*scale ;
 y4 = fx1(:,4) + nl'.*fx1(:,4)*scale ;
 y5 = fx1(:,5) + nl'.*fx1(:,5)*scale ;
 y6 = fx1(:,6) + nl'.*fx1(:,6)*scale ;
 
f_pn_mn_1 = cat(2,y1,y2,y3,y4,y5,y6);

y1 = ix1(:,1) + nl'.*ix1(:,1)*scale ;
 y2 = ix1(:,2) + nl'.*ix1(:,2)*scale ;
 y3 = ix1(:,3) + nl'.*ix1(:,3)*scale ;
 y4 = ix1(:,4) + nl'.*ix1(:,4)*scale ;
 y5 = ix1(:,5) + nl'.*ix1(:,5)*scale ;
 y6 = ix1(:,6) + nl'.*ix1(:,6)*scale ;
 
i_pn_mn_1 = cat(2,y1,y2,y3,y4,y5,y6);

y1 = cx1(:,1) + nl'.*cx1(:,1)*scale ;
 y2 = cx1(:,2) + nl'.*cx1(:,2)*scale ;
 y3 = cx1(:,3) + nl'.*cx1(:,3)*scale ;
 y4 = cx1(:,4) + nl'.*cx1(:,4)*scale ;
 y5 = cx1(:,5) + nl'.*cx1(:,5)*scale ;
 y6 = cx1(:,6) + nl'.*cx1(:,6)*scale ;
 
c_pn_mn_1 = cat(2,y1,y2,y3,y4,y5,y6);

y1 = gx1(:,1) + nl'.*gx1(:,1)*scale ;
 y2 = gx1(:,2) + nl'.*gx1(:,2)*scale ;
 y3 = gx1(:,3) + nl'.*gx1(:,3)*scale ;
 y4 = gx1(:,4) + nl'.*gx1(:,4)*scale ;
 y5 = gx1(:,5) + nl'.*gx1(:,5)*scale ;
 y6 = gx1(:,6) + nl'.*gx1(:,6)*scale ;
 
g_pn_mn_1 = cat(2,y1,y2,y3,y4,y5,y6);

% Torque after friction change for Axis 2.

L = p560.links
% L(2).Tc = [0.6 -0.5];
  p560.payload(2.5, [0,0,0.1]);

tau_2 = p560.rne(ql,qdl,qddl);
time = [0:5:11];
% time_hours = time./(60*60);


x2 = tau_2(1:11,:);
 
% Torque with Process nosie

j = 0;

for i =1 : 1:11
     nl_r = randn(1,6);
    % nl_r = randn(N,6);
    tau_pn_2(i,:) = p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:) )+ ...
               nl_r.*(p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:) ))*scale ;
           
    f_pn_2(i,:)= p560.friction(qdl(i,:))+...
                      nl_r.*p560.friction(qdl(i,:))*scale;
                  
    i_pn_1(i,:)= p560.itorque(ql(i,:),qddl(i ,:))+...
                  nl_r.*p560.itorque(ql(i,:),qddl(i ,:))*scale;              
    c_pn_1(:,i) = (p560.coriolis(ql(i,:),qdl(i ,:))*qdl(i,:)')' +...
                  nl_r.*(p560.coriolis(ql(i,:),qdl(i ,:))*qdl(i,:)')'*scale; 
    g_pn_1(i,:) = p560.gravload(qdl(i,:))+....
                   nl_r.*p560.gravload(qdl(i,:))*scale;  
              
%      L(1).Tc = [0.395+0.5/(1+exp(-((j/300000)^5))) -0.435-0.5/(1+exp(-((j/300000)^5)))];
%      L(2).Tc = [0.126+0.5/(1+exp(-((j/300000)^5))) -0.071-0.5/(1+exp(-((j/300000)^5)))];
%      L(3).Tc = [0.132+0.5/(1+exp(-((j/300000)^5))) -0.105-0.5/(1+exp(-((j/300000)^5)))];
     j = j +5  ;
    time(i) = j;
end
 

x2 = tau_pn_2(1:11,:);
fx2 =  f_pn_2(1:11,:);
ix2 = i_pn_1(1:11,:);
cx2 = c_pn_1(:,1:11)';
gx2 = g_pn_1(1:11,:);

 
 
% Torque with process noise and measurement noise

N = size(tau_pn_2(1:11,1),1);
% add 10% noise based on gaussian
 
nl =  randn(1, N); % noise with mean=0 and std=1;

 y1 = x2(:,1) + nl'.*x2(:,1)*scale ;
 y2 = x2(:,2) + nl'.*x2(:,2)*scale ;
 y3 = x2(:,3) + nl'.*x2(:,3)*scale ;
 y4 = x2(:,4) + nl'.*x2(:,4)*scale ;
 y5 = x2(:,5) + nl'.*x2(:,5)*scale ;
 y6 = x2(:,6) + nl'.*x2(:,6)*scale ;
 
tau_pn_mn_2 = cat(2,y1,y2,y3,y4,y5,y6);



 y1 = fx2(:,1) + nl'.*fx2(:,1)*scale ;
 y2 = fx2(:,2) + nl'.*fx2(:,2)*scale ;
 y3 = fx2(:,3) + nl'.*fx2(:,3)*scale ;
 y4 = fx2(:,4) + nl'.*fx2(:,4)*scale ;
 y5 = fx2(:,5) + nl'.*fx2(:,5)*scale ;
 y6 = fx2(:,6) + nl'.*fx2(:,6)*scale ;
 
f_pn_mn_2 = cat(2,y1,y2,y3,y4,y5,y6);

 y1 = ix2(:,1) + nl'.*ix2(:,1)*scale ;
 y2 = ix2(:,2) + nl'.*ix2(:,2)*scale ;
 y3 = ix2(:,3) + nl'.*ix2(:,3)*scale ;
 y4 = ix2(:,4) + nl'.*ix2(:,4)*scale ;
 y5 = ix2(:,5) + nl'.*ix2(:,5)*scale ;
 y6 = ix2(:,6) + nl'.*ix2(:,6)*scale ;
 
i_pn_mn_2 = cat(2,y1,y2,y3,y4,y5,y6);

 y1 = cx2(:,1) + nl'.*cx2(:,1)*scale ;
 y2 = cx2(:,2) + nl'.*cx2(:,2)*scale ;
 y3 = cx2(:,3) + nl'.*cx2(:,3)*scale ;
 y4 = cx2(:,4) + nl'.*cx2(:,4)*scale ;
 y5 = cx2(:,5) + nl'.*cx2(:,5)*scale ;
 y6 = cx2(:,6) + nl'.*cx2(:,6)*scale ;

 c_pn_mn_2 = cat(2,y1,y2,y3,y4,y5,y6);
 
  y1 = gx2(:,1) + nl'.*gx2(:,1)*scale ;
 y2 = gx2(:,2) + nl'.*gx2(:,2)*scale ;
 y3 = gx2(:,3) + nl'.*gx2(:,3)*scale ;
 y4 = gx2(:,4) + nl'.*gx2(:,4)*scale ;
 y5 = gx2(:,5) + nl'.*gx2(:,5)*scale ;
 y6 = gx2(:,6) + nl'.*gx2(:,6)*scale ;
 
 g_pn_mn_2 = cat(2,y1,y2,y3,y4,y5,y6);
 
 
 Toque_tot_1_err = tau_pn_mn_1 - (-f_pn_mn_1+i_pn_mn_1+c_pn_mn_1+g_pn_mn_1)
 
% Torque Lag - Cross correlation
taut_1 = ones(6);
for j = 1:6
    k=1
    for i = 1: 6 
    
        [c, lags] = xcorr(tau_pn_mn_1(:,j),tau_pn_mn_1(:,i));
        [m,id]=max(c);
        tau=lags(id);
        taut_1(j,k) = tau;
        k = k+1
    %plot(lags, c(1:end));
    end
end    

 
% torqueLag1 = {
%      '','MHT_1','MHT_2','MHT_3', 'MHT_4','MHT_5','MHT_6';
%      'MHT_1',taut(1,1),taut(1,2),taut(1,3),taut(1,4),taut(1,5),taut(1,6);
%     'MHT_2',taut(2,1),taut(2,2),taut(2,3),taut(2,4),taut(2,5),taut(2,6);
%     'MHT_3',taut(3,1),taut(3,2),taut(3,3),taut(3,4),taut(3,5),taut(3,6);
%     'MHT_4',taut(4,1),taut(4,2),taut(4,3),taut(4,4),taut(4,5),taut(4,6);
%     'MHT_5',taut(5,1),taut(5,2),taut(5,3),taut(5,4),taut(5,5),taut(5,6);
%     'MHT_6',taut(6,1),taut(6,2),taut(6,3),taut(6,4),taut(6,5),taut(6,6)};
% 
% disp(torqueLag1);

% Torque Lag for second case - friction change
taut_2 = ones(6);
for j = 1:6
    k=1
    for i = 1: 6 
    
        [c, lags] = xcorr(tau_pn_mn_2(:,j),tau_pn_mn_2(:,i));
        [m,id]=max(c);
        tau=lags(id);
        taut_2(j,k) = tau;
        k = k+1
    %plot(lags, c(1:end));
    end
end    

 
% Friction Torque Lag - Cross correlation
ft_1 = ones(6);
for j = 1:6
    k=1
    for i = 1: 6 
    
        [c, lags] = xcorr(f_pn_mn_1(:,j),f_pn_mn_1(:,i));
        [m,id]=max(c);
        tau=lags(id);
        ft_1(j,k) = tau;
        k = k+1
    %plot(lags, c(1:end));
    end
end    

 
% Friction Torque Lag for second case - friction change
ft_2 = ones(6);
for j = 1:6
    k=1
    for i = 1: 6 
    
        [c, lags] = xcorr(f_pn_mn_2(:,j),f_pn_mn_2(:,i));
        [m,id]=max(c);
        tau=lags(id);
        ft_2(j,k) = tau;
        k = k+1
    %plot(lags, c(1:end));
    end
end  


% Inertial Torque Lag - Cross correlation
it_1 = ones(6);
for j = 1:6
    k=1
    for i = 1: 6 
    
        [c, lags] = xcorr(i_pn_mn_1(:,j),i_pn_mn_1(:,i));
        [m,id]=max(c);
        tau=lags(id);
        it_1(j,k) = tau;
        k = k+1
    %plot(lags, c(1:end));
    end
end    

 
% Inertial Torque Lag for second case - friction change
it_2 = ones(6);
for j = 1:6
    k=1
    for i = 1: 6 
    
        [c, lags] = xcorr(i_pn_mn_2(:,j),i_pn_mn_2(:,i));
        [m,id]=max(c);
        tau=lags(id);
        it_2(j,k) = tau;
        k = k+1
    %plot(lags, c(1:end));
    end
end  

% Coriolis Torque Lag - Cross correlation
ct_1 = ones(6);
for j = 1:6
    k=1
    for i = 1: 6 
    
        [c, lags] = xcorr(c_pn_mn_1(:,j),c_pn_mn_1(:,i));
        [m,id]=max(c);
        tau=lags(id);
        ct_1(j,k) = tau;
        k = k+1
    %plot(lags, c(1:end));
    end
end    

 
% Coriolis Torque Lag for second case - friction change
ct_2 = ones(6);
for j = 1:6
    k=1
    for i = 1: 6 
    
        [c, lags] = xcorr(c_pn_mn_2(:,j),c_pn_mn_2(:,i));
        [m,id]=max(c);
        tau=lags(id);
        ct_2(j,k) = tau;
        k = k+1
    %plot(lags, c(1:end));
    end
end  

% Gravitational Torque Lag - Cross correlation
gt_1 = ones(6);
for j = 1:6
    k=1
    for i = 1: 6 
    
        [c, lags] = xcorr(g_pn_mn_1(:,j),g_pn_mn_1(:,i));
        [m,id]=max(c);
        tau=lags(id);
        gt_1(j,k) = tau;
        k = k+1
    %plot(lags, c(1:end));
    end
end    

 
% Gravitational Torque Lag for second case - friction change
gt_2 = ones(6);
for j = 1:6
    k=1
    for i = 1: 6 
    
        [c, lags] = xcorr(g_pn_mn_2(:,j),g_pn_mn_2(:,i));
        [m,id]=max(c);
        tau=lags(id);
        gt_2(j,k) = tau;
        k = k+1
    %plot(lags, c(1:end));
    end
end  



figure(2);
subplot(2,1,1);
plot(time_c, tau_pn_mn_1);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Overall Torque before friction change ','FontSize', 12);
xlabel('Time in seconds','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;

subplot(2,1,2);
plot(time_c, tau_pn_mn_2);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Overall Torque after friction change ','FontSize', 12);
xlabel('Time in seconds','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;

figure(3);
subplot(2,1,1);
plot( time_c,f_pn_mn_1);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Frictional Torque before friction change','FontSize', 12);
xlabel('Time in seconds','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;

subplot(2,1,2);
plot(time_c, f_pn_mn_2);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Frictional Torque after friction change','FontSize', 12);
xlabel('Time in seconds','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;


figure(4);
subplot(2,1,1);
plot(time_c, i_pn_mn_1);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Inertial Torque before friction change','FontSize', 12);
xlabel('Time in seconds','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;

subplot(2,1,2);
plot(time_c, i_pn_mn_2);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Inertial Torque after friction change ','FontSize', 12);
xlabel('Time in seconds','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;

figure(5);
subplot(2,1,1);
plot(time_c, c_pn_mn_1);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Coriolis Torque before friction change','FontSize', 12);
xlabel('Time in seconds','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;

subplot(2,1,2);
plot( time_c, c_pn_mn_2);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Coriolis Torque after friction change','FontSize', 12);
xlabel('Time in seconds','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;

figure(6);
subplot(2,1,1);
plot(time_c, g_pn_mn_1);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Gravity Torque before friction change ','FontSize', 12);
xlabel('Time in seconds','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;

subplot(2,1,2);
plot(time_c, g_pn_mn_2);
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend:Gravity Torque after friction change ','FontSize', 12);
xlabel('Time in seconds','FontSize', 10);
ylabel('Torque (Nm)','FontSize', 10);
qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',6);
grid on;


figure(7)
subplot(3,1,1);
plot(time_c,cat(2,tau_pn_mn_1(:,2),tau_pn_mn_2(:,2)));
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend:  Torque - Axis 2 ','FontSize', 10);
xlabel('Time in seconds','FontSize', 8);
ylabel('Torque (Nm)','FontSize', 8);
qdd_legend = legend('Before Friciton Change','After Friction Change');
set(qdd_legend,'FontSize',6);
grid on;

subplot(3,1,2);
plot(time_c,cat(2,f_pn_mn_1(:,2),f_pn_mn_2(:,2)));
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend:  Fricitonal Torque - Axis 2 ','FontSize',10);
xlabel('Time in seconds','FontSize', 8);
ylabel('Torque (Nm)','FontSize', 8);
qdd_legend = legend('Before Friciton Change','After Friction Change');
set(qdd_legend,'FontSize',6);
grid on;
subplot(3,1,3);
plot(time_c,cat(2,i_pn_mn_1(:,2),i_pn_mn_2(:,2)));
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend:  Inertial Torque - Axis 2 ','FontSize', 10);
xlabel('Time in seconds','FontSize', 8);
ylabel('Torque (Nm)','FontSize', 8);
qdd_legend = legend('Before Friciton Change','After Friction Change');
set(qdd_legend,'FontSize',6);
grid on;

figure(8)
subplot(2,1,1);
plot(time_c,cat(2,c_pn_mn_1(:,2),c_pn_mn_2(:,2)));
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend:  Coriolis Torque - Axis 2 ','FontSize', 8);
xlabel('Time in seconds','FontSize', 6);
ylabel('Torque (Nm)','FontSize', 6);
qdd_legend = legend('Before Friciton Change','After Friction Change');
set(qdd_legend,'FontSize',6);
grid on;

subplot(2,1,2);
plot(time_c,cat(2,g_pn_mn_1(:,2),g_pn_mn_2(:,2)));
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend:  Gravitational Torque - Axis 2 ','FontSize', 8);
xlabel('Time in seconds','FontSize', 6);
ylabel('Torque (Nm)','FontSize', 6);
qdd_legend = legend('Before Friciton Change','After Friction Change');
set(qdd_legend,'FontSize',6);
grid on;

figure(9)
subplot(2,1,1);
plot(time_c,cat(2,tau_pn_mn_1(:,2),f_pn_mn_1(:,2),i_pn_mn_1(:,2),c_pn_mn_1(:,2),g_pn_mn_1(:,2)));
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Torque - before friction change ','FontSize', 8);
xlabel('Time in seconds','FontSize', 6);
ylabel('Torque (Nm)','FontSize', 6);
qdd_legend = legend('Overall Torque','Frictional Torque', 'Inertial Torque', 'coriolis Torque', 'Gravitaional Torque');
set(qdd_legend,'FontSize',6);
grid on;

subplot(2,1,2);
plot(time_c,cat(2,tau_pn_mn_2(:,2),f_pn_mn_2(:,2),i_pn_mn_2(:,2),c_pn_mn_2(:,2),g_pn_mn_2(:,2)));
set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Trend: Torque - After friction change ','FontSize', 8);
xlabel('Time in seconds','FontSize', 6);
ylabel('Torque (Nm)','FontSize', 6);
qdd_legend = legend('Overall Torque','Frictional Torque', 'Inertial Torque', 'coriolis Torque', 'Gravitaional Torque');
set(qdd_legend,'FontSize',6);
grid on;


% figure(10);
% subplot(2,1,1);
% plot( torque_average_fc_pn_mn);
% set(gca,'PlotBoxAspectRatio',[5 2 1])
% title('Trend: Average Torque per hour during friction change (with process and measurement nosie','FontSize', 12);
% xlabel('Time in hours','FontSize', 10);
% ylabel('Average Torque (Nm) per hr','FontSize', 10);
% qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
% set(qdd_legend,'FontSize',6);
% grid on;

 figure(10)
 subplot(3,1,1);
%   plot(cell2mat(torqueLag1(2:end,2:end)),cell2mat(torqueLag2(2:end,2:end)));
bar(cat(2,taut_1(:,1),taut_2(:,1)));
 qdd_legend =  legend('Before change in friction','After change in friction' );
   set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Overall Torque: Cross Correlation - Lag Comparison','FontSize', 12);
xlabel('Axis','FontSize', 10);
ylabel('Lag','FontSize', 10);
set(qdd_legend,'FontSize',6);
grid on;
%  
 subplot(3,1,2);
%   plot(cell2mat(torqueLag1(2:end,2:end)),cell2mat(torqueLag2(2:end,2:end)));
bar(cat(2,ft_1(:,1),ft_2(:,1)));
 qdd_legend =  legend('Before change in friction','After change in friction' );
   set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Frictional Torque: Cross Correlation - Lag Comparison ','FontSize', 12);
xlabel('Axis','FontSize', 10);
ylabel('Lag','FontSize', 10);
set(qdd_legend,'FontSize',6);
grid on;
   
   
subplot(3,1,3);
%   plot(cell2mat(torqueLag1(2:end,2:end)),cell2mat(torqueLag2(2:end,2:end)));
bar(cat(2,it_1(:,1),it_2(:,1)));
  qdd_legend =  legend('Before change in friction','After change in friction' );
   set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Inertial Torque: Cross Correlation - Lag Comparison','FontSize', 12);
xlabel('Axis','FontSize', 10);
ylabel('Lag','FontSize', 10);
set(qdd_legend,'FontSize',6);
grid on;
   
figure(11)
 subplot(2,1,1);
%   plot(cell2mat(torqueLag1(2:end,2:end)),cell2mat(torqueLag2(2:end,2:end)));
bar(cat(2,ct_1(:,1),ct_2(:,1)));
  qdd_legend =  legend('Before change in friction','After change in friction');
   set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Coriolis Torque: Cross Correlation - Lag Comparison','FontSize', 12);
xlabel('Axis','FontSize', 10);
ylabel('Lag','FontSize', 10);
set(qdd_legend,'FontSize',6);
grid on;
%  
 subplot(2,1,2);
%   plot(cell2mat(torqueLag1(2:end,2:end)),cell2mat(torqueLag2(2:end,2:end)));
bar(cat(2,gt_1(:,1),gt_2(:,1)));
  qdd_legend =  legend('Before change in friction','After change in friction' );
   set(gca,'PlotBoxAspectRatio',[5 2 1])
title('Gravitational Torque: Cross Correlation - Lag Comparison ','FontSize', 12);
xlabel('Axis','FontSize', 10);
ylabel('Lag','FontSize', 10);
set(qdd_legend,'FontSize',6);
grid on;


 
