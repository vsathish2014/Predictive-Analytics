
clear lags;
clear c;

% Read the data
     entropy_data = xlsread('C1_Entropy_F_50p_NF_Noise_2pt5p_18082014.xlsx','All_F_A1','A2:F13');
   % entropy_data = xlsread('Entropy_08052014.xlsx','F_A2','A2:F13');
    
    
    min_entropy = kron(min(entropy_data),ones(12,1));
    max_entropy = kron(max(entropy_data),ones(12,1));
    
    entropy_data_n = (entropy_data- min_entropy)./(max_entropy -min_entropy);
    
    
 j=0;
 i=0;
 k=1;
for j = 1:6
    
    for i = 1: 6             
           % [c(:,:,k) lags(:,:,k)] = xcorr(zscore(f_pn_mn_1(:,j)), zscore(f_pn_mn_1(:,i)),'unbiased');   %// Cross correlation
             %  [c(:,:,k) lags(:,:,k)] = xcorr(zscore(entropy_data(:,j)), zscore(entropy_data(:,i)),'unbiased');   %// Cross correlation
                [c(:,:,k) lags(:,:,k)] = xcorr( (entropy_data_n(:,j)),   (entropy_data_n(:,i)),'unbiased');   %// Cross correlation
           %   [c(:,:,k) lags(:,:,k)] = xcorr( (entropy_data(:,j)),   (entropy_data(:,i)),'unbiased');   %// Cross correlation

           %   [c(:,:,k) lags(:,:,k)] = xcorr(zscore(tau_pn_mn_3(:,j)), zscore(tau_pn_mn_3(:,i)),'unbiased'); 
           % [c(:,:,k) lags(:,:,k)] = xcorr(f_pn_mn_1(:,j), f_pn_mn_1(:,i),'unbiased'); 
         % [c(:,:,k) lags(:,:,k)] = xcorr( f_pn_mn_1(:,j),  f_pn_mn_1(:,i),'coeff');   %// Cross correlation
        k = k+1;
         
    end
    
end


lags = reshape(lags,[23,36]);
%lags = reshape(lags,[119,36]);
 c = reshape(c,[23,36]);
%c = reshape(c,[119,36]);
frow = 9;
lrow =15;

for i = 1 : 36
        [m,id]=max(c(frow:lrow,i));
        tauid=lags(frow-1+id);
        tauc =c(frow-1+id);
        id_1(i) = tauid;
        c_1(i) = tauc;
end

id_1 = reshape(id_1,6,6);
c_1 = reshape(c_1,6,6);
% figure(10);
% subplot(2,2,1);
% %plot(lags(:,2),c(:,2),'b*-.');
% plot(lags(:,2),c(:,2),'b*');
% title('Cross Corr Axis 1 with Axis 2');
% xlabel('Lag','FontSize',10);
% ylabel('Correlation coeff.','FontSize',10);
% %figure(9);
% subplot(2,2,2);
% %plot(lags2,c2,'b*-.');
% plot(lags(:,3),c(:,3),'b*');
% xlabel('Lag','FontSize',10);
% ylabel('Correlation coeff.','FontSize',10);
% title('Cross Corr Axis 1 with Axis 3');
% %figure(10);
% subplot(2,2,3);
%  
% plot(lags(:,4),c(:,4),'b*');
% title('Cross Corr Axis 1 with Axis 4');
% xlabel('Lag','FontSize',10);
% ylabel('Correlation coeff.','FontSize',10);
% %figure(11);
% subplot(2,2,4);
% plot(lags(:,5),c(:,5),'b*');
% title('Cross Corr Axis 1 with Axis 5');
% xlabel('Lag','FontSize',10);
% ylabel('Correlation coeff.','FontSize',10);
% 
% % figure(9);
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