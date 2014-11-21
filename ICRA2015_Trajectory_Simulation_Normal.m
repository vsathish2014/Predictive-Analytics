 

    clear;
    clc;
    profile on
    matlabpool open 3;

    mdl_puma560
      p560.payload(2.5, [0,0,0.1]);     
      
% Initial and final postion of trajectory:

    trajectory = 3;
    
    switch trajectory
        
        case 1
    
            q_1 = [-2.7925   0.2036   -1.5126   -1.9199   -1.7453    0.0000];
            q_2 = [0.0690   -0.0582   -3.1125   -1.9199   -1.7453    0.0000];
        
        case 2
            q_1 = [ 0    0   0   0   0    0];
            q_2 = [-2.7925   -0.7854    0.7854   -1.9199   -1.7453   -4.6426];
            
        case 3
            q_1=    [0         0   -1.5708         0         0         0];
            q_2 = [-0.8964    3.0252   -1.6290    1.5493   -0.7326    1.3183];
    end
            
            
    Tq_1 = p560.fkine(q_1);
    Tq_2 = p560.fkine(q_2);


    path = [Tq_1(1:3,4)'; Tq_2(1:3,4)'];


 
      t = [0:10:30]';
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
    simDuration = 360*24*5; % in time step of 10 seconds
    
         for cycles = 1:(simDuration/(lrow_c-1))-1
          ql = cat(1,ql,q_c(2:lrow_c,:));
          qdl = cat(1,qdl,qd_c(2:lrow_c,:));
          qddl =cat(1,qddl, qdd_c(2:lrow_c,:));

         end

 

    j = 0;
    axis =1; 
    L = p560.links;
     simActualDuration = 3600*24*5;
    time = [0:10:simActualDuration];
     time_minutes = time./(60);
    [lrow_p lcol_p] = size(ql);
 
   
            tau_fc(:,: ) = p560.rne(ql ,qdl , qddl  ) ;

            f_fc(:,: )= p560.friction(qdl ) ;
     
       

            
    % Add disturbance to torque - gaussian

    
            N = size(tau_fc(1:lrow_p,1 ),1);
        % add 10% noise based on gaussian
        scale = 0.01  ;
        nl =  randn(1, N); % noise with mean=0 and std=1;

         y1 = tau_fc(:,1 ) + nl'.*tau_fc(:,1 )*scale ;
         y2 = tau_fc(:,2 ) + nl'.*tau_fc(:,2 )*scale ;
         y3 = tau_fc(:,3) + nl'.*tau_fc(:,3 )*scale ;
         y4 = tau_fc(:,4) + nl'.*tau_fc(:,4 )*scale ;
         y5 = tau_fc(:,5) + nl'.*tau_fc(:,5 )*scale ;
         y6 = tau_fc(:,6) + nl'.*tau_fc(:,6)*scale ;

        tau_fc_pn(:,:) = cat(2,y1,y2,y3,y4,y5,y6);

        %clear y1,y2,y3,y4,y5,y6;

         y1 = f_fc(:,1) + nl'.*f_fc(:,1)*scale ;
         y2 = f_fc(:,2) + nl'.*f_fc(:,2)*scale ;
         y3 = f_fc(:,3) + nl'.*f_fc(:,3)*scale ;
         y4 = f_fc(:,4) + nl'.*f_fc(:,4)*scale ;
         y5 = f_fc(:,5) + nl'.*f_fc(:,5)*scale ;
         y6 = f_fc(:,6) + nl'.*f_fc(:,6)*scale ;

        f_fc_pn(:,:) = cat(2,y1,y2,y3,y4,y5,y6);
     
    
% Forward dynamics - with a robot model (no friction)
    R =p560.nofriction();
    % 10 seconds - time step
   
        [T(:,:) Q(:,:) QD(:,:)] = R.fdyn([0.001:0.001:43.2],tau_fc_pn(:,:));
        QDD(:,:) = R.accel(Q(:,:), QD(:,:),tau_fc_pn(:,:));
    

    % Add Measurement noise to Q, QD, and QDD

   
            N = size(Q(1:lrow_p,1),1);
        % add 10% noise based on gaussian
        scale = 0.01  ;
        nl =  randn(1, N); % noise with mean=0 and std=1;

         y1 = Q(:,1) + nl'.*0.0001*1 ;
         y2 = Q(:,2) + nl'.*0.0001*1 ;
         y3 = Q(:,3) + nl'.*0.0001*1 ;
         y4 = Q(:,4) + nl'.*0.0001*1 ;
         y5 = Q(:,5) + nl'.*0.0001*1 ;
         y6 = Q(:,6) + nl'.*0.0001*1 ;

        Q_mn(:,:) = cat(2,y1,y2,y3,y4,y5,y6);

       %clear y1,y2,y3,y4,y5,y6;

        y1 = QD(:,1) + nl'.*0.0001*(1/0.5) ;
         y2 = QD(:,2) + nl'.*0.0001*(1/0.5) ;
         y3 = QD(:,3) + nl'.*0.0001*(1/0.5) ;
         y4 = QD(:,4) + nl'.*0.0001*(1/0.5) ;
         y5 = QD(:,5) + nl'.*0.0001*(1/0.5) ;
         y6 = QD(:,6) + nl'.*0.0001*(1/0.5) ;

        QD_mn(:,:) = cat(2,y1,y2,y3,y4,y5,y6);
        
        %clear y1,y2,y3,y4,y5,y6;
        
         y1 = QDD(:,1) + nl'.*0.0001*(1/0.25) ;
         y2 = QDD(:,2) + nl'.*0.0001*(1/0.25) ;
         y3 = QDD(:,3) + nl'.*0.0001*(1/0.25) ;
         y4 = QDD(:,4) + nl'.*0.0001*(1/0.25) ;
         y5 = QDD(:,5) + nl'.*0.0001*(1/0.25) ;
         y6 = QDD(:,6) + nl'.*0.0001*(1/0.25) ;

        QDD_mn(:,:) = cat(2,y1,y2,y3,y4,y5,y6);
        %clear y1,y2,y3,y4,y5,y6;
    

   % Inverse dynamics
       tau_fc_pn_mn(:,:) = R.rne(Q_mn(:,:),QD_mn(:,:),QDD_mn(:,:));
      

      matlabpool close;
      profile off;
 