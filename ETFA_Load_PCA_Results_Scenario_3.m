% Load KL distances
% Mdodifed to consider only varying test data points
clear all;
clc;
no_test= 5;
files = dir('*.xlsx');
for file = files'

    %k = strcat('data','_',s1);
    dist_data_All_Trg = readtable(file.name,'Sheet',2,'Range','A1:DM41'); 
    dist_data_All_Trg = table2cell(dist_data_All_Trg);
    dist_data_All_Trg = cell2mat(dist_data_All_Trg);
    
    dist_data_All_Test = readtable(file.name,'Sheet',3,'Range','A1:DM6'); 
    dist_data_All_Test = table2cell(dist_data_All_Test);
    dist_data_All_Test = cell2mat(dist_data_All_Test);
    
    
    diff_data_All_Trg = readtable(file.name,'Sheet',4,'Range','A1:DM41'); 
    diff_data_All_Trg = table2cell(diff_data_All_Trg);
    diff_data_All_Trg = cell2mat(diff_data_All_Trg);
    
    diff_data_All_Test = readtable(file.name,'Sheet',5,'Range','A1:DM6'); 
    diff_data_All_Test = table2cell(diff_data_All_Test);
    diff_data_All_Test = cell2mat(diff_data_All_Test);
    
    
    
    data_All_Trg = readtable(file.name,'Sheet',6,'Range','A1:HZ41'); 
    data_All_Trg = table2cell(data_All_Trg);
    data_All_Trg = cell2mat(data_All_Trg);
    
    data_All_Test = readtable(file.name,'Sheet',7,'Range','A1:HZ6'); 
    data_All_Test = table2cell(data_All_Test);
    data_All_Test = cell2mat(data_All_Test);
    
    
    
    %strcat('data','_',k) = data;
    s1 = cellstr(file.name) ;
    k = s1{1};
    name = genvarname(k);     
    l1 = strfind(name,'All');
    l2 =strfind(name,'IRB');
    name1 = name(1,l1+4:l2-2);
    
    dsName_dist_All_Trg = strcat(name1,'_dist_All','_Trg');
    dsName_dist_All_Test = strcat(name1,'_dist_All','_Test');
    dsName_diff_All_Trg = strcat(name1,'_diff_All','_Trg');
    dsName_diff_All_Test = strcat(name1,'_diff_All','_Test');
    dsName_All_Trg = strcat(name1,'_All','_Trg');
    dsName_All_Test = strcat(name1,'_All','_Test');
     
    dsName_dist_All_Trg = genvarname(dsName_dist_All_Trg);
    dsName_dist_All_Test = genvarname(dsName_dist_All_Test); 
    dsName_diff_All_Trg = genvarname(dsName_diff_All_Trg);
    dsName_diff_All_Test = genvarname(dsName_diff_All_Test); 
    dsName_All_Trg = genvarname(dsName_All_Trg);
    dsName_All_Test = genvarname(dsName_All_Test); 
     
    eval([dsName_dist_All_Trg,'=dist_data_All_Trg;']);
    eval([dsName_dist_All_Test,'=dist_data_All_Test;']);    
    eval([dsName_diff_All_Trg,'=diff_data_All_Trg;']);
    eval([dsName_diff_All_Test,'=diff_data_All_Test;']);
    eval([dsName_All_Trg,'=data_All_Trg;']);
    eval([dsName_All_Test,'=data_All_Test;']);
      
end

%%% PCA model development using PLS toolbox
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
   no_pc = cell2mat(test_slno(:,4));
 
 n = 273;
 
%n=2;
%summary_stat =zeros(8,n);
elements_above_threshold= zeros(no_test,n);
for i = 1:n 
   
    training = detrend(eval(cell2str(test_slno(i,2))));
    test = detrend(eval(cell2str(test_slno(i,3))));
    noPCs = no_pc(i); % Number of PCs for model building
        
    
    model = pca(training,noPCs,options);
    % options.plots = 'final';  % this will plot charts automatically
    options.display = 'off';
    % Revise the model to have 90% variance explained in  the model
    temp = ssqtable(model,20);
    temp1 = temp(:,7:26);
    temp2 = cell2str(temp1);
    temp3 = str2num(temp2);;
    temp4 = reshape(temp3,4,20)';
    noPCs = min(find(temp4(:,4)>90));   
    model = pca(training,noPCs,options);
    
%     % Revise based on optimal number of PCs
%     noPCs = choosecomp(model);
%     model = pca(training,noPCs,options);
    
    prediction    = pca(test,model,options);
    %    model_variance(:,:,i) = ssqtable(model,6);

    q_residual_model(1:40,i)  = model.ssqresiduals{1,1};
    q_residual_pred(1:no_test,i)  = prediction.ssqresiduals{1,1};
    q_confLimit(:,i) = residuallimit(model ,ConfLimit);
    q_confLimit_pt99(:,i) = residuallimit(model ,0.99);
    q_confLimit_pt90(:,i) = residuallimit(model ,0.9);
    summary_stat_all = summary(q_residual_pred(:,i));
    size_elements_above_threshold = size(find(q_residual_pred(:,i)>q_confLimit(:,i)));
   elements_above_threshold(:,i) =  cat(1,find(q_residual_pred(:,i)>q_confLimit(:,i)), zeros(no_test-size_elements_above_threshold(1,1),1));
   
    first_pt_outside_threshold(:,i) =  elements_above_threshold(1,i) ;     
    count_elements_above_threshold(:,i) = nnz(elements_above_threshold(:,i)); % find non zero elements
    summary_stat(1:5,i) = summary_stat_all.data(1:5,1);
    
%     
%     % hotelling T squared
%     t_squared_model(1:40,i) = model.tsqs{1,1};
%     t_squared_prediction(1:15,i) = prediction.tsqs{1,1};
%      t_confLimit(:,i) = tsqlim(model ,ConfLimit);
    
end

% Identify the Q-Residual for the first point above threshold
for j = 1:n
    if elements_above_threshold(1,j) > 0
    first_pt_q_residual(:,j) = q_residual_pred(elements_above_threshold(1,j),j);
    else
      first_pt_q_residual(:,j) =0;  
    end
end

% Normalize the first_pt_q_residual by dividing the q_limit
first_pt_q_residual_norm = first_pt_q_residual./ q_confLimit;

% Average of residual
Avg_residual = mean(q_residual_pred);

%Max of residual
Max_residual = max(q_residual_pred);

% std devialtion of Q q residual
Std_residual = std(q_residual_pred);

% Cov of Q_residual
CoV_Q_residual = Std_residual./Avg_residual;

% % Averagae of t squared
% Avg_tsq = mean(t_squared_prediction);
% %Max of t squared
% Max_tsq = max(t_squared_prediction);
% %Std deviation of t squared
% Std_tsq = std(t_squared_prediction);


test_results = cat(2,CoV_Q_residual',...
                   first_pt_outside_threshold',  count_elements_above_threshold');
                      
                  
%Print the file to excel                  
stat_print = fullfile('C:\Users\INSAV3\Predictive Analytics\DataSets\ETFA-Data\Results', 'TestCase_Results.xlsx');
      
xlswrite(stat_print, test_results,'Results','G2');

                  
                  