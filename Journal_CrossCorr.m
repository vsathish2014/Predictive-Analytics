
% clear lags;
% clear c;

% % Read the data
for p=1:8
    sheetName = strcat('Dataset',int2str(p));
      %AvgSpeed_data(:,:,p) = xlsread('Test_data_all_robots_woKL.xlsx',sheetName,'A2:F21');
       AvgSpeed_data(:,:,p) = xlsread('Test_data_all_robots_woKL.xlsx',sheetName,'G2:L21');
end
%    % entropy_data = xlsread('Entropy_08052014.xlsx','F_A2','A2:F13');
%  permuted_kldiv_dist_hs = permute(kldiv_dist_hs,[2,1,3]);  
%     
  for dataSet = 1:8
    z =AvgSpeed_data(:,:,dataSet);
     
    min_AvgSpeed = kron(min(z),ones(20,1));
    max_AvgSpeed = kron(max(z),ones(20,1));
    
    AvgSpeed_data_n(:,:,dataSet) = (z- min_AvgSpeed)./(max_AvgSpeed -min_AvgSpeed);
    AvgSpeed_data_n(isnan(AvgSpeed_data_n))=0;
    AvgSpeed_data_n(AvgSpeed_data_n==0)=eps;
  end  
%   
 for dataSet = 1:8
   % fc_axis =1;
     j=0;
     i=0;
     k=1;
    for j = 1:6

        for i = 1: 6             
                    % [c(:,:,k) lags(:,:,k)] = xcorr( (KL_data_n(:,j,fc_axis)),   (KL_data_n(:,i,fc_axis)),'unbiased');   %// Cross correlation
                     [c(:,:,k) lags(:,:,k)] = xcorr( (AvgSpeed_data_n(:,j,dataSet)),   (AvgSpeed_data_n(:,i,dataSet)),'coeff');
                      %[c(:,:,k) lags(:,:,k)] = xcorr( zscore(KL_data(:,j,fc_axis)),   zscore(KL_data_n(:,i,fc_axis)),'coeff');
                     %   [c(:,:,k) lags(:,:,k)] = xcorr( zscore(permuted_kldiv_dist_hs(:,j,fc_axis)),   zscore(permuted_kldiv_dist_hs(:,i,fc_axis)),'unbiased'); 
            k = k+1;

        end

    end


    lags = reshape(lags,[39,36]);
    %lags = reshape(lags,[119,36]);
     c = reshape(c,[39,36]);
    %c = reshape(c,[119,36]);
    frow = 1 ;
    lrow =39;

    for i = 1 : 36
            [m,id]=max(c(frow:lrow,i));
            tauid=lags(frow-1+id);
            tauc =c(frow-1+id);
            id_1(i) = tauid;
            c_1(i) = tauc;
    end
  clear c;
  clear lags;
id_t(:,:,dataSet) = cat(3, reshape(id_1,6,6));
c_t(:,:,dataSet) = cat(3, reshape(c_1,6,6));
end