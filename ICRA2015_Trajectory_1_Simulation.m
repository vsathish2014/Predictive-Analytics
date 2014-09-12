clear;
clc;
profile on
matlabpool open 3;

mdl_puma560
  p560.payload(2.5, [0,0,0.1]);
  
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
  
% Calculate torque with friction change

% Torque with Process nosie

j = 0;
axis =1; 
L = p560.links;
time = [0:5:simDuration];
 time_minutes = time./(60);
[lrow_p lcol_p] = size(ql);

for axis = 1:6
    for i =1 : 1:lrow_p

        tau_fc(i,:,axis) = p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:) ) ;

        f_fc(i,:,axis)= p560.friction(qdl(i,:)) ;
    %                   
    %     i_fc(i,:)= p560.itorque(ql(i,:),qddl(i ,:)) ;
    %     
    %     c_fc(:,i) = (p560.coriolis(ql(i,:),qdl(i ,:))*qdl(i,:)')'  ; 
    %     
    %     g_fc(i,:) = p560.gravload(qdl(i,:)) ;  


     % friction change 10% 

            switch axis
                case 1

                      L(1).Tc = [0.395+0.5/(1+exp(-((j/4791.5)^4)))-0.25 -0.435-0.5/(1+exp(-((j/4791.5)^4)))+0.25];

                case 2

                      L(2).Tc = [0.126+0.5/(1+exp(-((j/6387.7)^4)))-0.25 -0.071-0.5/(1+exp(-((j/6387.7)^4)))+0.25];

                case 3

                      L(3).Tc = [0.132+0.5/(1+exp(-((j/6313.7)^4)))-0.25 -0.105-0.5/(1+exp(-((j/6313.7)^4)))+0.25];

                case 4

                      L(4).Tc =  [11.2e-3+0.5/(1+exp(-((j/11701)^4)))-0.25 -16.9e-3-0.5/(1+exp(-((j/11701)^4)))+0.25];

                case 5

                      L(5).Tc = [11.2e-3+0.5/(1+exp(-((j/12271)^4)))-0.25 -16.9e-3-0.5/(1+exp(-((j/12271)^4)))+0.25];   

                case 6

                      L(6).Tc = [3.96e-3+0.5/(1+exp(-((j/15174)^4)))-0.25 -10.5e-3-0.5/(1+exp(-((j/15174)^4)))+0.25];
            end

        j = j +5  ;
        time(i) = j;
    end
end
% Add disturbance to torque - gaussian

parfor axis = 1:6
        N = size(tau_fc(1:lrow_p,1,axis),1);
    % add 10% noise based on gaussian
    scale = 0.01  ;
    nl =  randn(1, N); % noise with mean=0 and std=1;

     y1 = tau_fc(:,1,axis) + nl'.*tau_fc(:,1,axis)*scale ;
     y2 = tau_fc(:,2,axis) + nl'.*tau_fc(:,2,axis)*scale ;
     y3 = tau_fc(:,3,axis) + nl'.*tau_fc(:,3,axis)*scale ;
     y4 = tau_fc(:,4,axis) + nl'.*tau_fc(:,4,axis)*scale ;
     y5 = tau_fc(:,5,axis) + nl'.*tau_fc(:,5,axis)*scale ;
     y6 = tau_fc(:,6,axis) + nl'.*tau_fc(:,6,axis)*scale ;

    tau_fc_pn(:,:,axis) = cat(2,y1,y2,y3,y4,y5,y6);

    %clear y1,y2,y3,y4,y5,y6;

     y1 = f_fc(:,1,axis) + nl'.*f_fc(:,1,axis)*scale ;
     y2 = f_fc(:,2,axis) + nl'.*f_fc(:,2,axis)*scale ;
     y3 = f_fc(:,3,axis) + nl'.*f_fc(:,3,axis)*scale ;
     y4 = f_fc(:,4,axis) + nl'.*f_fc(:,4,axis)*scale ;
     y5 = f_fc(:,5,axis) + nl'.*f_fc(:,5,axis)*scale ;
     y6 = f_fc(:,6,axis) + nl'.*f_fc(:,6,axis)*scale ;

    f_fc_pn(:,:,axis) = cat(2,y1,y2,y3,y4,y5,y6);
end

R =p560.nofriction();
parfor axis =1:6
    [T(:,:,axis) Q(:,:,axis) QD(:,:,axis)] = R.fdyn([5:5:3600],tau_fc_pn(:,:,axis));
    QDD(:,:,axis) = R.accel(Q(:,:,axis), QD(:,:,axis),tau_fc_pn(:,:,axis));
end

% Add Measurement noise

parfor axis = 1:6
        N = size(Q(1:lrow_p,1,axis),1);
    % add 10% noise based on gaussian
    scale = 0.01  ;
    nl =  randn(1, N); % noise with mean=0 and std=1;

     y1 = Q(:,1,axis) + nl'.*Q(:,1,axis)*scale ;
     y2 = Q(:,2,axis) + nl'.*Q(:,2,axis)*scale ;
     y3 = Q(:,3,axis) + nl'.*Q(:,3,axis)*scale ;
     y4 = Q(:,4,axis) + nl'.*Q(:,4,axis)*scale ;
     y5 = Q(:,5,axis) + nl'.*Q(:,5,axis)*scale ;
     y6 = Q(:,6,axis) + nl'.*Q(:,6,axis)*scale ;

    Q_mn(:,:,axis) = cat(2,y1,y2,y3,y4,y5,y6);

   %clear y1,y2,y3,y4,y5,y6;

    y1 = QD(:,1,axis) + nl'.*QD(:,1,axis)*1.5*scale ;
     y2 = QD(:,2,axis) + nl'.*QD(:,2,axis)*1.5*scale ;
     y3 = QD(:,3,axis) + nl'.*QD(:,3,axis)*1.5*scale ;
     y4 = QD(:,4,axis) + nl'.*QD(:,4,axis)*1.5*scale ;
     y5 = QD(:,5,axis) + nl'.*QD(:,5,axis)*1.5*scale ;
     y6 = QD(:,6,axis) + nl'.*QD(:,6,axis)*1.5*scale ;

    QD_mn(:,:,axis) = cat(2,y1,y2,y3,y4,y5,y6);
    %clear y1,y2,y3,y4,y5,y6;
    
     y1 = QDD(:,1,axis) + nl'.*QDD(:,1,axis)*2*scale ;
     y2 = QDD(:,2,axis) + nl'.*QDD(:,2,axis)*2*scale ;
     y3 = QDD(:,3,axis) + nl'.*QDD(:,3,axis)*2*scale ;
     y4 = QDD(:,4,axis) + nl'.*QDD(:,4,axis)*2*scale ;
     y5 = QDD(:,5,axis) + nl'.*QDD(:,5,axis)*2*scale ;
     y6 = QDD(:,6,axis) + nl'.*QDD(:,6,axis)*2*scale ;

    QDD_mn(:,:,axis) = cat(2,y1,y2,y3,y4,y5,y6);
    %clear y1,y2,y3,y4,y5,y6;
end

   parfor axis = 1:6
       tau_fc_pn_mn(:,:,axis) = R.rne(Q_mn(:,:,axis),QD_mn(:,:,axis),QDD_mn(:,:,axis));
   end
   
  matlabpool close;
  profile off;