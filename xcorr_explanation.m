clear all; 
clear lags;
clear c;

% % Read the data
      data = xlsread('XCORR_example.xlsx','Sheet2','A2:F25');
   % entropy_data = xlsread('Entropy_08052014.xlsx','F_A2','A2:F13');
% permuted_kldiv_dist_hs = permute(kldiv_dist_hs,[2,1,3]);  
%       data = table2cell(data(:,3:end)); 
%  data_new = cell2mat(data);
 
   
    z =data;
   % z = SISL10h_all(2:61,:);
   %z = avgTorque_all(2:61,:);
    
    [cRows_m cCols_m] = size(z);
     
    min_KLD = kron(min(z),ones(cRows_m,1));
    max_KLD = kron(max(z),ones(cRows_m,1));
    
    KL_data_n(:,:) = (z- min_KLD)./(max_KLD -min_KLD);
    KL_data_n(isnan(KL_data_n))=0;
    KL_data_n(KL_data_n==0)=eps;
  
  
 k = 1;
    for j = 1:6

        for i = 1: 6             
                    % [c(:,:,k) lags(:,:,k)] = xcorr( (KL_data_n(:,j,fc_axis)),   (KL_data_n(:,i,fc_axis)),'unbiased');   %// Cross correlation
                    % [c(:,:,k) lags(:,:,k)] = xcorr( (KL_data_n(:,j)),   (KL_data_n(:,i)),'coeff');
                                [c(:,:,k) lags(:,:,k)] = xcorr( (z(:,j)),   (z(:,i)),'coeff');
                     %   [c(:,:,k) lags(:,:,k)] = xcorr( zscore(permuted_kldiv_dist_hs(:,j,fc_axis)),   zscore(permuted_kldiv_dist_hs(:,i,fc_axis)),'unbiased'); 
          
                     k = k+1;
        end

    end

    lags = reshape(lags,[2*cRows_m-1,36]);
    %lags = reshape(lags,[119,36]);
     c = reshape(c,[2*cRows_m-1,36]);
    %c = reshape(c,[119,36]);
    frow = 1 ;
    lrow =2*cRows_m-1;

    for i = 1 : 36
            [m,id]=max(c(frow:lrow,i));
            tauid=lags(frow-1+id);
            tauc =c(frow-1+id);
            id_1(i) = tauid;
            c_1(i) = tauc;
    end
 % clear c;
 % clear lags;
id_t(:,:) =   reshape(id_1,6,6);
c_t(:,:) =  reshape(c_1,6,6);
