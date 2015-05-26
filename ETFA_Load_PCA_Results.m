% Load KL distances
clear all;
clc;
files = dir('*.xlsx');
for file = files'

    %k = strcat('data','_',s1);
    data_KL_Trg = readtable(file.name,'Sheet',4); 
    data_KL_Trg = table2cell(data_KL_Trg);
    data_KL_Trg = cell2mat(data_KL_Trg);
    
    data_KL_Test = readtable(file.name,'Sheet',5); 
    data_KL_Test = table2cell(data_KL_Test);
    data_KL_Test = cell2mat(data_KL_Test);
    
    data_R_KL_Trg = readtable(file.name,'Sheet',6); 
    data_R_KL_Trg = table2cell(data_R_KL_Trg);
    data_R_KL_Trg = cell2mat(data_R_KL_Trg);
    
    data_R_KL_Test = readtable(file.name,'Sheet',7); 
    data_R_KL_Test = table2cell(data_R_KL_Test);
    data_R_KL_Test = cell2mat(data_R_KL_Test);
    
    
    data_C_KL_Trg = readtable(file.name,'Sheet',8); 
    data_C_KL_Trg = table2cell(data_C_KL_Trg);
    data_C_KL_Trg = cell2mat(data_C_KL_Trg);
    
    data_C_KL_Test = readtable(file.name,'Sheet',9); 
    data_C_KL_Test = table2cell(data_C_KL_Test);
    data_C_KL_Test = cell2mat(data_C_KL_Test);
    
    %strcat('data','_',k) = data;
    s1 = cellstr(file.name) ;
    k = s1{1};
    name = genvarname(k);     
    l1 = strfind(name,'KL');
    l2 =strfind(name,'IRB');
    name1 = name(1,l1+3:l2-2);
    dsName_KL_Trg = strcat(name1,'_KL','_Trg');
    dsName_KL_Test = strcat(name1,'_KL','_Test');
    dstName_R_KL_Trg = strcat(name1,'_R_KL','_Trg');
    dsName_R_KL_Test = strcat(name1,'_R_KL','_Test');
    dsName_C_KL_Trg = strcat(name1,'_C_KL','_Trg');
    dsName_C_KL_Test = strcat(name1,'_C_KL','_Test');
    
    dsName_KL_Trg = genvarname(dsName_KL_Trg);
    dsName_KL_Test = genvarname(dsName_KL_Test);
    dstName_R_KL_Trg = genvarname(dstName_R_KL_Trg);
    dsName_R_KL_Test = genvarname(dsName_R_KL_Test);
    dsName_C_KL_Trg = genvarname(dsName_C_KL_Trg);
    dsName_C_KL_Test = genvarname(dsName_C_KL_Test);
     
    eval([dsName_KL_Trg,'=data_KL_Trg;']);
    eval([dsName_KL_Test,'=data_KL_Test;']);
    eval([dstName_R_KL_Trg,'=data_R_KL_Trg;']);
    eval([dsName_R_KL_Test,'=data_R_KL_Test;']);
    eval([dsName_C_KL_Trg,'=data_C_KL_Trg;']);
    eval([dsName_C_KL_Test,'=data_C_KL_Test;']);
 
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

% Identify the Q-Residual for the first point above threshold
for j = 1:36
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


test_results = cat(2,Avg_residual',Max_residual',Std_residual',first_pt_outside_threshold',...
                      count_elements_above_threshold',first_pt_q_residual_norm');

                  
%Print the file to excel                  
stat_print = fullfile('C:\Users\INSAV3\Predictive Analytics\DataSets\ETFA-Data\Results', 'TestCase_Results.xlsx');
      
xlswrite(stat_print, test_results,'Results','F2');

                  
                  