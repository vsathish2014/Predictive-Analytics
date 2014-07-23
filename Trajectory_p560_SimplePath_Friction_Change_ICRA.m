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

[lrow_p lcol_p] = size(ql);
  

% % Torque required moving between two stretch position
% 

% Torque after friction change for Axis 2.

L = p560.links
%   L(1).Tc = [0.6 -0.5];
%  L(3).Tc = [0.6 -0.5];
% L(2).Tc = [0.15   -0.1] % [0.1260   -0.0710]
tau_1 = p560.rne(ql,qdl,qddl);
time = [0:5:simDuration];
 time_minutes = time./(60);


x1 = tau_1(1:11,:);
 
% Torque with Process nosie

j = 0;
scale = 0.025;

for i =1 : 1:lrow_p
     nl_r = randn(1,6);
    % nl_r = randn(N,6);
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
              
%       L(1).Tc = [0.395+0.5/(1+exp(-((j/2500)^4)))-0.25 -0.435-0.5/(1+exp(-((j/2500)^4)))+0.25];
        L(2).Tc = [0.126+0.5/(1+exp(-((j/2500)^4)))-0.25 -0.071-0.5/(1+exp(-((j/2500)^4)))+0.25];
%      L(3).Tc = [0.132+0.5/(1+exp(-((j/300000)^5))) -0.105-0.5/(1+exp(-((j/300000)^5)))];
     j = j +5  ;
    time(i) = j;
end
 

x  = tau_pn_1(:,:);
fx =  f_pn_1(:,:);
ix = i_pn_1(:,:);
cx = c_pn_1(:,:)';
gx = g_pn_1(:,:);

 
 
% Torque with process noise and measurement noise

N = size(tau_pn_1(1:lrow_p,1),1);
% add 10% noise based on gaussian
 
nl =  randn(1, N); % noise with mean=0 and std=1;

 y1 = x(:,1) + nl'.*x(:,1)*scale ;
 y2 = x(:,2) + nl'.*x(:,2)*scale ;
 y3 = x(:,3) + nl'.*x(:,3)*scale ;
 y4 = x(:,4) + nl'.*x(:,4)*scale ;
 y5 = x(:,5) + nl'.*x(:,5)*scale ;
 y6 = x(:,6) + nl'.*x(:,6)*scale ;
 
tau_pn_mn_1 = cat(2,y1,y2,y3,y4,y5,y6);



 y1 = fx(:,1) + nl'.*fx(:,1)*scale ;
 y2 = fx(:,2) + nl'.*fx(:,2)*scale ;
 y3 = fx(:,3) + nl'.*fx(:,3)*scale ;
 y4 = fx(:,4) + nl'.*fx(:,4)*scale ;
 y5 = fx(:,5) + nl'.*fx(:,5)*scale ;
 y6 = fx(:,6) + nl'.*fx(:,6)*scale ;
 
f_pn_mn_1 = cat(2,y1,y2,y3,y4,y5,y6);

 y1 = ix(:,1) + nl'.*ix(:,1)*scale ;
 y2 = ix(:,2) + nl'.*ix(:,2)*scale ;
 y3 = ix(:,3) + nl'.*ix(:,3)*scale ;
 y4 = ix(:,4) + nl'.*ix(:,4)*scale ;
 y5 = ix(:,5) + nl'.*ix(:,5)*scale ;
 y6 = ix(:,6) + nl'.*ix(:,6)*scale ;
 
i_pn_mn_1 = cat(2,y1,y2,y3,y4,y5,y6);

 y1 = cx(:,1) + nl'.*cx(:,1)*scale ;
 y2 = cx(:,2) + nl'.*cx(:,2)*scale ;
 y3 = cx(:,3) + nl'.*cx(:,3)*scale ;
 y4 = cx(:,4) + nl'.*cx(:,4)*scale ;
 y5 = cx(:,5) + nl'.*cx(:,5)*scale ;
 y6 = cx(:,6) + nl'.*cx(:,6)*scale ;

 c_pn_mn_1 = cat(2,y1,y2,y3,y4,y5,y6);
 
  y1 = gx(:,1) + nl'.*gx(:,1)*scale ;
 y2 = gx(:,2) + nl'.*gx(:,2)*scale ;
 y3 = gx(:,3) + nl'.*gx(:,3)*scale ;
 y4 = gx(:,4) + nl'.*gx(:,4)*scale ;
 y5 = gx(:,5) + nl'.*gx(:,5)*scale ;
 y6 = gx(:,6) + nl'.*gx(:,6)*scale ;
 
 g_pn_mn_1 = cat(2,y1,y2,y3,y4,y5,y6);
 
 
 Toque_tot_1_err = tau_pn_mn_1 - (-f_pn_mn_1+i_pn_mn_1+c_pn_mn_1+g_pn_mn_1)
 
% Torque Lag - Cross correlation
tauid_1 = ones(6);
for j = 1:6
    k=1
    for i = 1: 6 
    
        [tc1, tlags1] = xcorr(tau_pn_mn_1(:,j),tau_pn_mn_1(:,i) );
        [m,id]=max(tc1);
        tauid=tlags1(id);
        tauc =tc1(id);
        tauid_1(j,k) = tauid;
        tauc_1(j,k) = tauc;
        k = k+1
    %plot(lags, c(1:end));
    end
end    

tauid_2 = ones(6);
for j = 1:6
    k=1
    for i = 1: 6 
    
        [tc2, tlags2] = xcorr(tau_pn_mn_1(351:721,j),tau_pn_mn_1(351:721,i) );
        [m,id]=max(tc2);
        tauid=tlags2(id);
        tauc =tc2(id);
        tauid_2(j,k) = tauid;
        tauc_2(j,k) = tauc;
        k = k+1
    %plot(lags, c(1:end));
    end
end  


 
% torqueLag1 = {
%      '',' T_1',' T_2',' T_3', ' T_4','T_5','T_6';
%      'T_1',tauid(1,1),tauid(1,2),tauid(1,3),tauid(1,4),tauid(1,5),tauid(1,6);
%     'T_2',tauid(2,1),tauid(2,2),tauid(2,3),tauid(2,4),tauid(2,5),tauid(2,6);
%     'T_3',tauid(3,1),tauid(3,2),tauid(3,3),tauid(3,4),tauid(3,5),tauid(3,6);
%     'T_4',tauid(4,1),tauid(4,2),tauid(4,3),tauid(4,4),tauid(4,5),tauid(4,6);
%     'T_5',tauid(5,1),tauid(5,2),tauid(5,3),tauid(5,4),tauid(5,5),tauid(5,6);
%     'T_6',tauid(6,1),tauid(6,2),tauid(6,3),tauid(6,4),tauid(6,5),tauid(6,6)};
% 
% disp(torqueLag1);

 
% Friction Torque Lag - Cross correlation
ft_1 = ones(6);
for j = 1:6
    k=1
    for i = 1: 6 
    
        [fc1, flags1] = xcorr(f_pn_mn_1(1:350,j),f_pn_mn_1(1:350,i));
        [m,id]=max(fc1);
        tauid=flags1(id);
        tauc = fc1(id);
        ftid_1(j,k) = tauid;
        ftc_1(j,k) = tauc;
        k = k+1
    %plot(lags, c(1:end));
    end
end    

ft_2 = ones(6);
for j = 1:6
    k=1
    for i = 1: 6 
    
        [fc2, flags2] = xcorr(f_pn_mn_1(351:721,j),f_pn_mn_1(351:721,i));
        [m,id]=max(fc2);
        tauid=flags2(id);
        tauc = fc2(id);
        ftid_2(j,k) = tauid;
        ftc_2(j,k) = tauc;
        k = k+1
    %plot(lags, c(1:end));
    end
end    

 time_minutes = time./(60);
