 

    clear;
    clc;
    profile on
    matlabpool open 3;

    mdl_puma560
      p560.payload(2.5, [0,0,0.1]);
% Initial and final postion of trajectory:
    q_1=    [0         0   -1.5708         0         0         0];
    q_2 = [-0.8964    3.0252   -1.6290    1.5493   -0.7326    1.3183];

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

    % Calculate torque with friction change using Inverse dynamic equation

    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%  Friction Change 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        fc_pct = 10;

    j = 0;
    axis =1; 
    L = p560.links;
     simActualDuration = 3600*24*5;
    time = [0:10:simActualDuration];
     time_minutes = time./(60);
    [lrow_p lcol_p] = size(ql);

    for axis = 1:6
        for i =1 : 1:lrow_p

            tau_fc(i,:,axis) = p560.rne(ql(i,:),qdl(i ,:), qddl(i ,:) ) ;

            f_fc(i,:,axis)= p560.friction(qdl(i,:)) ;
     
       

                switch axis
                    case 1
                            
                         switch fc_pct
                            case 10    
                             %   L(1).Tc = [0.395+0.5/(1+exp(-((j/4791.5)^4)))-0.25 -0.435-0.5/(1+exp(-((j/4791.5)^4)))+0.25];
                            % L(1).Tc =   [0.395+0.5/(1+exp(-((j/114990)^4)))-0.25 -0.435-0.5/(1+exp(-((j/114990)^4)))+0.25];
                                L(1).Tc = [0.395+0.5/(1+exp(-((j/574970)^4)))-0.25 -0.435-0.5/(1+exp(-((j/574970)^4)))+0.25];
                            case 20
                                L(1).Tc = [0.395+0.5/(1+exp(-((j/480310)^4)))-0.25 -0.435-0.5/(1+exp(-((j/480310)^4)))+0.25];   
                         end       
                             
                    case 2
                         switch fc_pct
                            case 10
                         % L(2).Tc = [0.126+0.5/(1+exp(-((j/6387.7)^4)))-0.25 -0.071-0.5/(1+exp(-((j/6387.7)^4)))+0.25];
                         % L(2).Tc = [0.126+0.5/(1+exp(-((j/153310)^4)))-0.25 -0.071-0.5/(1+exp(-((j/153310)^4)))+0.25];
                              L(2).Tc =  [0.126+0.5/(1+exp(-((j/766530)^4)))-0.25 -0.071-0.5/(1+exp(-((j/766530)^4)))+0.25];
                             case 20
                                L(2).Tc =  [0.126+0.5/(1+exp(-((j/644160)^4)))-0.25 -0.071-0.5/(1+exp(-((j/644160)^4)))+0.25];
                         end       
                    case 3
                         switch fc_pct
                            case 10
                          %L(3).Tc = [0.132+0.5/(1+exp(-((j/6313.7)^4)))-0.25 -0.105-0.5/(1+exp(-((j/6313.7)^4)))+0.25];
                          %L(3).Tc = [0.132+0.5/(1+exp(-((j/151530)^4)))-0.25 -0.105-0.5/(1+exp(-((j/151530)^4)))+0.25];
                                L(3).Tc =  [0.132+0.5/(1+exp(-((j/757650)^4)))-0.25 -0.105-0.5/(1+exp(-((j/757650)^4)))+0.25];
                            case 20  
                                L(3).Tc =  [0.132+0.5/(1+exp(-((j/636660)^4)))-0.25 -0.105-0.5/(1+exp(-((j/636660)^4)))+0.25];
                         end       
                    case 4
                         switch fc_pct
                            case 10
                          %L(4).Tc =  [11.2e-3+0.5/(1+exp(-((j/11701)^4)))-0.25 -16.9e-3-0.5/(1+exp(-((j/11701)^4)))+0.25];
                          % L(4).Tc = [11.2e-3+0.5/(1+exp(-((j/280830)^4)))-0.25 -16.9e-3-0.5/(1+exp(-((j/280830)^4)))+0.25];
                                 L(4).Tc =  [11.2e-3+0.5/(1+exp(-((j/1404100)^4)))-0.25 -16.9e-3-0.5/(1+exp(-((j/1404100)^4)))+0.25];
                             case 20
                                 L(4).Tc =  [11.2e-3+0.5/(1+exp(-((j/1180700)^4)))-0.25 -16.9e-3-0.5/(1+exp(-((j/1180700)^4)))+0.25];                                 
                         end        
                    case 5
                         switch fc_pct
                            case 10
                          %L(5).Tc = [11.2e-3+0.5/(1+exp(-((j/12271)^4)))-0.25 -16.9e-3-0.5/(1+exp(-((j/12271)^4)))+0.25];   
                          %  L(5).Tc = [11.2e-3+0.5/(1+exp(-((j/294500)^4)))-0.25 -16.9e-3-0.5/(1+exp(-((j/294500)^4)))+0.25];
                                 L(5).Tc =  [0.00926+0.5/(1+exp(-((j/1472500)^4)))-0.25 -14.5e-3-0.5/(1+exp(-((j/1472500)^4)))+0.25];
                             case 20
                                 L(5).Tc =  [0.00926+0.5/(1+exp(-((j/1238200)^4)))-0.25 -14.5e-3-0.5/(1+exp(-((j/1238200)^4)))+0.25];
                                 
                         end        
                    case 6
                         switch fc_pct
                            case 10
                         % L(6).Tc = [3.96e-3+0.5/(1+exp(-((j/15174)^4)))-0.25 -10.5e-3-0.5/(1+exp(-((j/15174)^4)))+0.25];
                         %L(6).Tc = [3.96e-3+0.5/(1+exp(-((j/364180)^4)))-0.25 -10.5e-3-0.5/(1+exp(-((j/364180)^4)))+0.25];
                                L(6).Tc =  [3.96e-3+0.5/(1+exp(-((j/1472500)^4)))-0.25 -10.5e-3-0.5/(1+exp(-((j/1472500)^4)))+0.25];
                             case 20
                               L(6).Tc =  [3.96e-3+0.5/(1+exp(-((j/1530500)^4)))-0.25 -10.5e-3-0.5/(1+exp(-((j/1530500)^4)))+0.25];  
                         end        
                end

            j = j +10  ;
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
    
% Forward dynamics - with a robot model (no friction)
    R =p560.nofriction();
    % 10 seconds - time step
    parfor axis =1:6
        [T(:,:,axis) Q(:,:,axis) QD(:,:,axis)] = R.fdyn([0.001:0.001:43.2],tau_fc_pn(:,:,axis));
        QDD(:,:,axis) = R.accel(Q(:,:,axis), QD(:,:,axis),tau_fc_pn(:,:,axis));
    end

    % Add Measurement noise to Q, QD, and QDD

    parfor axis = 1:6
            N = size(Q(1:lrow_p,1,axis),1);
        % add 10% noise based on gaussian
        scale = 0.01  ;
        nl =  randn(1, N); % noise with mean=0 and std=1;

         y1 = Q(:,1,axis) + nl'.*0.0001*1 ;
         y2 = Q(:,2,axis) + nl'.*0.0001*1 ;
         y3 = Q(:,3,axis) + nl'.*0.0001*1 ;
         y4 = Q(:,4,axis) + nl'.*0.0001*1 ;
         y5 = Q(:,5,axis) + nl'.*0.0001*1 ;
         y6 = Q(:,6,axis) + nl'.*0.0001*1 ;

        Q_mn(:,:,axis) = cat(2,y1,y2,y3,y4,y5,y6);

       %clear y1,y2,y3,y4,y5,y6;

        y1 = QD(:,1,axis) + nl'.*0.0001*10 ;
         y2 = QD(:,2,axis) + nl'.*0.0001*10 ;
         y3 = QD(:,3,axis) + nl'.*0.0001*10 ;
         y4 = QD(:,4,axis) + nl'.*0.0001*10 ;
         y5 = QD(:,5,axis) + nl'.*0.0001*10 ;
         y6 = QD(:,6,axis) + nl'.*0.0001*10 ;

        QD_mn(:,:,axis) = cat(2,y1,y2,y3,y4,y5,y6);
        
        %clear y1,y2,y3,y4,y5,y6;
        
         y1 = QDD(:,1,axis) + nl'.*0.0001*100 ;
         y2 = QDD(:,2,axis) + nl'.*0.0001*100 ;
         y3 = QDD(:,3,axis) + nl'.*0.0001*100 ;
         y4 = QDD(:,4,axis) + nl'.*0.0001*100 ;
         y5 = QDD(:,5,axis) + nl'.*0.0001*100 ;
         y6 = QDD(:,6,axis) + nl'.*0.0001*100 ;

        QDD_mn(:,:,axis) = cat(2,y1,y2,y3,y4,y5,y6);
        %clear y1,y2,y3,y4,y5,y6;
    end

       parfor axis = 1:6
           tau_fc_pn_mn(:,:,axis) = R.rne(Q_mn(:,:,axis),QD_mn(:,:,axis),QDD_mn(:,:,axis));
       end

      matlabpool close;
      profile off;
 