
clear lags;
clear c;
clear id_1;
clear c_1;
min_torque = kron(min(tau_pn_mn_1),ones(721,1));
max_torque = kron(max(tau_pn_mn_1),ones(721,1));
    
    torque_data_n = (tau_pn_mn_1- min_torque)./(max_torque -min_torque);
    
    
 j=0;
 i=0;
  % Compute time lag between signals
k=1;
for j = 1:6
    
    for i = 1: 6             
      %// Cross correlation
               % [c(:,:,k) lags(:,:,k)] = xcorr( (torque_data_n(:,j)),   (torque_data_n(:,i)),'unbiased');    %// Cross correlation
                 [c(:,:,k) lags(:,:,k)] = xcorr(zscore(tau_pn_mn_1(:,j)), zscore(tau_pn_mn_1(:,i)),'unbiased'); 
        k = k+1;
         
    end
    
end




% 
% % Compute time lag autocorelation
% [sc1 slags1] = xcorr(y1,y1,'coeff');   %// Cross correlation
% [sc2 slags2] =xcorr(y2,y2,'coeff');
% [sc3 slags3] = xcorr(y3 ,y3,'coeff');
% [sc4 slags4] = xcorr(y4,y4, 'coeff');
% [sc5 slags5] = xcorr(y5 ,y5,'coeff');
% [sc6 slags6] = xcorr(y6,y6, 'coeff');

lags = reshape(lags,[1441,36]);
%lags = reshape(lags,[119,36]);
 c = reshape(c,[1441,36]);
%c = reshape(c,[119,36]);
frow = 420;
lrow =1020;

for i = 1 : 36
        [m,id]=max(c(frow:lrow,i));
        tauid=lags(frow-1+id);
        tauc =c(frow-1+id);
        id_1(i) = tauid;
        c_1(i) = tauc;
end

id_1 = reshape(id_1,6,6);
c_1 = reshape(c_1,6,6);
figure(10);
subplot(2,2,1);
%plot(lags(:,2),c(:,2),'b*-.');
plot(lags(:,2),c(:,2),'b*');
title('Cross Corr Axis 1 with Axis 2');
xlabel('Lag','FontSize',10);
ylabel('Correlation coeff.','FontSize',10);
%figure(9);
subplot(2,2,2);
%plot(lags2,c2,'b*-.');
plot(lags(:,3),c(:,3),'b*');
xlabel('Lag','FontSize',10);
ylabel('Correlation coeff.','FontSize',10);
title('Cross Corr Axis 1 with Axis 3');
%figure(10);
subplot(2,2,3);
 
plot(lags(:,4),c(:,4),'b*');
title('Cross Corr Axis 1 with Axis 4');
xlabel('Lag','FontSize',10);
ylabel('Correlation coeff.','FontSize',10);
%figure(11);
subplot(2,2,4);
plot(lags(:,5),c(:,5),'b*');
title('Cross Corr Axis 1 with Axis 5');
xlabel('Lag','FontSize',10);
ylabel('Correlation coeff.','FontSize',10);

% figure(9);
% %subplot(3,2,5);
% plot(lags5,c5,'b*');
% title('Cross Corr Axis 1 with Axis 6');
% xlabel('Lag','FontSize',10);
% ylabel('Correlation coeff.','FontSize',10);
% 
% figure(10);
% subplot(2,2,1);
% plot(slags1,sc1,'b*');
% title('Auto Corr Axis 1  ');
% xlabel('Lag','FontSize',10);
% ylabel('Correlation coeff.','FontSize',10);
% %figure(9);
% subplot(2,2,2);
% %plot(lags2,c2,'b*-.');
% plot(slags2,sc2,'b*');
% xlabel('Lag','FontSize',10);
% ylabel('Correlation coeff.','FontSize',10);
% title('Auto Corr Axis 2');
% %figure(10);
% subplot(2,2,3);
%  
% plot(slags3,sc3,'b*');
% title('Auto Corr Axis 3');
% xlabel('Lag','FontSize',10);
% ylabel('Correlation coeff.','FontSize',10);
% %figure(11);
% subplot(2,2,4);
% plot(slags4,sc4,'b*');
% title('Auto Corr Axis 4');
% xlabel('Lag','FontSize',10);
% ylabel('Correlation coeff.','FontSize',10);
% 
% figure(11);
% subplot(2,1,1);
% plot(slags5,sc5,'b*');
% title('Auto Corr Axis 5');
% xlabel('Lag','FontSize',10);
% ylabel('Correlation coeff.','FontSize',10);
% subplot(2,1,2);
% plot(slags6,sc6,'b*');
% title('Auto Corr Axis 6');
% xlabel('Lag','FontSize',10);
% ylabel('Correlation coeff.','FontSize',10);