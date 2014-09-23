
clear lags;
clear c;

% % Read the data
%      KL_data = xlsread('Trajectory1_Axis1_FC_10pct_09142014.xlsx','KL_All','A2:F145');
   % entropy_data = xlsread('Entropy_08052014.xlsx','F_A2','A2:F13');
 permuted_kldiv_dist_hs = permute(kldiv_dist_hs,[2,1,3]);  
    
  for fc_axis = 1:6
    z =permuted_kldiv_dist_hs(:,:,fc_axis);
     
    min_KLD = kron(min(z),ones(120,1));
    max_KLD = kron(max(z),ones(120,1));
    
    KL_data_n(:,:,fc_axis) = (z- min_KLD)./(max_KLD -min_KLD);
    KL_data_n(isnan(KL_data_n))=0;
    KL_data_n(KL_data_n==0)=eps;
  end  
  
for fc_axis = 1:6 
   % fc_axis =1;
     j=0;
     i=0;
     k=1;
    for j = 1:6

        for i = 1: 6             
                     [c(:,:,k) lags(:,:,k)] = xcorr( (KL_data_n(:,j,fc_axis)),   (KL_data_n(:,i,fc_axis)),'unbiased');   %// Cross correlation
                  %   [c(:,:,k) lags(:,:,k)] = xcorr( zscore(permuted_kldiv_dist_hs(:,j,fc_axis)),   zscore(permuted_kldiv_dist_hs(:,i,fc_axis)),'unbiased'); 
            k = k+1;

        end

    end


    lags = reshape(lags,[239,36]);
    %lags = reshape(lags,[119,36]);
     c = reshape(c,[239,36]);
    %c = reshape(c,[119,36]);
    frow = 1 ;
    lrow =239;

    for i = 1 : 36
            [m,id]=max(c(frow:lrow,i));
            tauid=lags(frow-1+id);
            tauc =c(frow-1+id);
            id_1(i) = tauid;
            c_1(i) = tauc;
    end
  clear c;
  clear lags;
id_t(:,:,fc_axis) = cat(3, reshape(id_1,6,6));
c_t(:,:,fc_axis) = cat(3, reshape(c_1,6,6));
end