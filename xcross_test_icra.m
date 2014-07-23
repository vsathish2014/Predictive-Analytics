
clear lags;
clear c;
%  y1 = tau_pn_mn_1(1:end,1);
%  y2 = tau_pn_mn_1(1:end,2);
%  y3 = tau_pn_mn_1(1:end,3);
%  y4 = tau_pn_mn_1(1:end,4);
%  y5 = tau_pn_mn_1(1:end,5);
%  y6 = tau_pn_mn_1(1:end,6);
  y1 = f_pn_mn_1(1:end,1);
 y2 = f_pn_mn_1(1:end,2);
 y3 = f_pn_mn_1(1:end,3);
 y4 = f_pn_mn_1(1:end,4);
 y5 = f_pn_mn_1(1:end,5);
 y6 = f_pn_mn_1(1:end,6);
 s1 = (y1- mean(y1)) / std(y1);
s2 = (y2 - mean(y2)) / std(y2);
s3 = (y3 - mean(y3)) / std(y3);
s4 = (y4 - mean(y4)) / std(y4);
s5 = (y5 - mean(y5)) / std(y5);
s6 = (y6 - mean(y6)) / std(y6);
% Compute time lag between signals
k=1;
for j = 1:6
    
    for i = 1: 6             
          %[c(:,:,k) lags(:,:,k)] = xcorr(zscore(f_pn_mn_1(:,j)), zscore(f_pn_mn_1(:,i)),'unbiased');   %// Cross correlation
             [c(:,:,k) lags(:,:,k)] = xcorr(zscore(tau_pn_mn_3(:,j)), zscore(tau_pn_mn_3(:,i)),'unbiased'); 
          
         % [c(:,:,k) lags(:,:,k)] = xcorr( f_pn_mn_1(:,j),  f_pn_mn_1(:,i),'coeff');   %// Cross correlation
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

%lags = reshape(lags,[1441,36]);
lags = reshape(lags,[119,36]);
%c = reshape(c,[1441,36]);
c = reshape(c,[119,36]);
frow = 20;
lrow =100;
for i = 1 : 36
        [m,id]=max(c(frow:lrow,i));
        tauid=lags(frow-1+id);
        tauc =c(frow-1+id);
        id_1(i) = tauid;
        c_1(i) = tauc;
end

id_1 = reshape(id_1,6,6);
c_1 = reshape(c_1,6,6);
figure(8);
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