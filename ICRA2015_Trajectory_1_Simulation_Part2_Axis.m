    R =p560.nofriction();
    % 10 seconds - time step
     axis=1;
        %[T(:,:,axis) Q(:,:,axis) QD(:,:,axis)] = R.fdyn([10:10:86400],tau_fc_pn(:,:,axis));
        [T(:,:,axis) Q(:,:,axis) QD(:,:,axis)] = R.fdyn([0.001:0.001:43.2],tau_fc_pn(:,:,axis));

        QDD(:,:,axis) = R.accel(Q(:,:,axis), QD(:,:,axis),tau_fc_pn(:,:,axis));
    

    % Add Measurement noise

     
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
    
 
           tau_fc_pn_mn(:,:,axis) = R.rne(Q_mn(:,:,axis),QD_mn(:,:,axis),QDD_mn(:,:,axis));
    

     % matlabpool close;
     % profile off;