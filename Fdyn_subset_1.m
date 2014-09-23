       tau_fc_pn_1 = tau_fc_pn(1:10:end,:,1)
        [T1(:,:) Q2(:,:) QD2(:,:)] = R.fdyn([0.1:0.1:86.4],tau_fc_pn_1(:,:));
        QDD2(:,:) = R.accel(Q2(:,:), QD2(:,:),tau_fc_pn_1(:,:));