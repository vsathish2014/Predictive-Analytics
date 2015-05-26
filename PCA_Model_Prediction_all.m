 

% PCA model development using PLS toolbox
options = pca('options');  % constructs a options structure for PCA
options.plots = 'none';
options.preprocessing = preprocess('default','autoscale'); %structure array
 ConfLimit = 0.95;
 % Use 4 PC for 12 signals
 % Us 2 pC for 6 signal KL
 % Use 3 PC for 6 signal R_KL
%Load test case scenarios
  test_slno = readtable('Test_Cases.xlsx','Sheet',2); 
    test_slno = table2cell(test_slno); 
   no_pc = cell2mat(test_slno(1:36,4));
 
 n = 36;
 
%n=2;
%summary_stat =zeros(8,n);
elements_above_threshold= zeros(20,n);
for i = 1:n 
   
    training = detrend(eval(cell2str(test_slno(i,2))));
    test = detrend(eval(cell2str(test_slno(i,3))));
    noPCs = no_pc(i); % Number of PCs for model building
        
    
    model = pca(training,noPCs,options);
    % options.plots = 'final';  % this will plot charts automatically
    options.display = 'off';
    prediction    = pca(test,model,options);
    %    model_variance(:,:,i) = ssqtable(model,6);

    q_residual_model(1:39,i)  = model.ssqresiduals{1,1};
    q_residual_pred(1:20,i)  = prediction.ssqresiduals{1,1};
    q_confLimit(:,i) = residuallimit(model ,ConfLimit);
    q_confLimit_pt99(:,i) = residuallimit(model ,0.99);
    q_confLimit_pt90(:,i) = residuallimit(model ,0.9);
    summary_stat_all = summary(q_residual_pred(:,i));
    size_elements_above_threshold = size(find(q_residual_pred(:,i)>q_confLimit(:,i)));
   elements_above_threshold(:,i) =  cat(1,find(q_residual_pred(:,i)>q_confLimit(:,i)), zeros(20-size_elements_above_threshold(1,1),1));
   
    first_pt_outside_threshold(:,i) =  elements_above_threshold(1,i) ;     
    count_elements_above_threshold(:,i) = nnz(elements_above_threshold(:,i)); % find non zero elements
    summary_stat(1:5,i) = summary_stat_all.data(1:5,1);
    
end



summary_stat = cat(1,summary_stat,q_confLimit,first_pt_outside_threshold,count_elements_above_threshold);
q_residual_pred_withLimit = cat(1,q_residual_pred,q_confLimit,q_confLimit_pt99,q_confLimit_pt90);
summary_stat_t = summary_stat';

        % Writing data to a file
        col_header_1 ={'Q-Res Avg','Q-Red Stddev','No of samples','Min',...
            'Max','Q_Residual_0.95','First day goes beyond threshod','No of points above threshold'};
        stat_print = fullfile('C:\Users\INSAV3\Predictive Analytics\DataSets\ETFA-Data\Results', 'Stat_Results.xlsx');
        xlswrite(stat_print,col_header_1,'summary_stat','A1');
        xlswrite(stat_print, summary_stat_t,'summary_stat','A2');
         residual_print = fullfile('C:\Users\INSAV3\Predictive Analytics\DataSets\ETFA-Data\Results', 'Pred_residuals.xlsx');
         xlswrite(residual_print , q_residual_pred_withLimit,'Pred_residual','A2');