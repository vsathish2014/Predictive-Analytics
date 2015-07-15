%%
% Mdodifed to consider only varying test data points
clear all;
clc;
 
files = dir('*.xlsx');
for file = files'

    %k = strcat('data','_',s1);
    Traj1_Trg = readtable(file.name,'Sheet',1,'Range','A1:F121'); 
    Traj1_Trg = table2cell(Traj1_Trg);
    Traj1_Trg = cell2mat(Traj1_Trg);
    
    Traj1_fc1_Test = readtable(file.name,'Sheet',2,'Range','A1:F121'); 
    Traj1_fc1_Test = table2cell(Traj1_fc1_Test);
    Traj1_fc1_Test = cell2mat(Traj1_fc1_Test);
    
    Traj1_fc2_Test = readtable(file.name,'Sheet',3,'Range','A1:F121'); 
    Traj1_fc2_Test = table2cell(Traj1_fc2_Test);
    Traj1_fc2_Test = cell2mat(Traj1_fc2_Test);
    
    Traj1_fc3_Test = readtable(file.name,'Sheet',4,'Range','A1:F121'); 
    Traj1_fc3_Test = table2cell(Traj1_fc3_Test);
    Traj1_fc3_Test = cell2mat(Traj1_fc3_Test);

    Traj1_fc4_Test = readtable(file.name,'Sheet',5,'Range','A1:F121'); 
    Traj1_fc4_Test = table2cell(Traj1_fc4_Test);
    Traj1_fc4_Test = cell2mat(Traj1_fc4_Test);
  
    Traj1_fc5_Test = readtable(file.name,'Sheet',6,'Range','A1:F121'); 
    Traj1_fc5_Test = table2cell(Traj1_fc5_Test);
    Traj1_fc5_Test = cell2mat(Traj1_fc5_Test);    
   
    Traj1_fc6_Test = readtable(file.name,'Sheet',7,'Range','A1:F121'); 
    Traj1_fc6_Test = table2cell(Traj1_fc6_Test);
    Traj1_fc6_Test = cell2mat(Traj1_fc6_Test);    
    
    
    
    %strcat('data','_',k) = data;
    s1 = cellstr(file.name) ;
    k = s1{1};
    name = genvarname(k);     
    l1 = strfind(name,'KLD');
    l2 = strfind(name,'pct');
  %  l2 =strfind(name,'IRB');
    name1 = name(1,l1-3:l1-2);
    name2 = name(1,l2-3:l2-1);
    
    dsName_Trg = strcat('Traj',name1,'_Trg');
    dsName_fc1_Test = strcat('Traj', name1,'_fc1',name2,'_Test');
    dsName_fc2_Test = strcat('Traj', name1,'_fc2',name2,'_Test');
    dsName_fc3_Test = strcat('Traj', name1,'_fc3',name2,'_Test');
    dsName_fc4_Test = strcat('Traj', name1,'_fc4',name2,'_Test');
    dsName_fc5_Test = strcat('Traj', name1,'_fc5',name2,'_Test');
    dsName_fc6_Test = strcat('Traj', name1,'_fc6',name2,'_Test');
     
    dsName_Trg = genvarname(dsName_Trg);
    dsName_fc1_Test = genvarname(dsName_fc1_Test); 
    dsName_fc2_Test = genvarname(dsName_fc2_Test);
    dsName_fc3_Test = genvarname(dsName_fc3_Test);
    dsName_fc4_Test = genvarname(dsName_fc4_Test);
    dsName_fc5_Test = genvarname(dsName_fc5_Test);
    dsName_fc6_Test = genvarname(dsName_fc6_Test);
     
    eval([dsName_Trg,'=Traj1_Trg;']);
    eval([dsName_fc1_Test,'=Traj1_fc1_Test;']);    
    eval([dsName_fc2_Test,'=Traj1_fc2_Test;']);
    eval([dsName_fc3_Test,'=Traj1_fc3_Test;']);
    eval([dsName_fc4_Test,'=Traj1_fc4_Test;']);
    eval([dsName_fc5_Test,'=Traj1_fc5_Test;']);
    eval([dsName_fc6_Test,'=Traj1_fc6_Test;']);
      
end
%%
%%% PCA model development using PLS toolbox
options = pca('options');  % constructs a options structure for PCA
options.plots = 'none';
options.preprocessing = preprocess('default','autoscale'); %structure array
 ConfLimit = 0.95;
 
%Load test case scenarios
  test_slno = readtable('Test_Cases.xlsx','Sheet',1); 
    test_slno = table2cell(test_slno); 
   no_pc = cell2mat(test_slno(:,4));
 
 n = 36;
 
%n=2;
%summary_stat =zeros(8,n);
elements_above_threshold= zeros(120,n);
q_residual_model= zeros(120,n);
q_residual_pred = zeros(120,n);

for i = 1:n 
   
%     training = detrend(eval(cell2str(test_slno(i,2))));
%     test = detrend(eval(cell2str(test_slno(i,3))));
%     noPCs = no_pc(i); % Number of PCs for model building

    training =  eval(cell2str(test_slno(i,2)));
    test =  eval(cell2str(test_slno(i,3)));
    noPCs = no_pc(i); % Number of PCs for model building
    
    model = pca(training,noPCs,options);
    % options.plots = 'final';  % this will plot charts automatically
    options.display = 'off';
    % Revise the model to have 75% variance explained in  the model
    temp = ssqtable(model,120);
    temp1 = temp(:,7:12);
    temp2 = cell2str(temp1);
    temp3 = str2num(temp2);
    temp4 = reshape(temp3,4,6)';
    noPCs = min(find(temp4(:,4)>75));   
    model = pca(training,noPCs,options);
    
%     % Revise based on optimal number of PCs
%     noPCs = choosecomp(model);
%     model = pca(training,noPCs,options);
    
    prediction    = pca(test,model,options);
    %    model_variance(:,:,i) = ssqtable(model,6);

    q_residual_model(1:120,i)  = model.ssqresiduals{1,1};
    q_residual_pred(1:120,i)  = prediction.ssqresiduals{1,1};
    q_confLimit(:,i) = residuallimit(model ,ConfLimit);
    q_confLimit_pt99(:,i) = residuallimit(model ,0.99);
    q_confLimit_pt90(:,i) = residuallimit(model ,0.9);
    summary_stat_all = summary(q_residual_pred(:,i));
    size_elements_above_threshold = size(find(q_residual_pred(:,i)>q_confLimit(:,i)));
   elements_above_threshold(:,i) =  cat(1,find(q_residual_pred(:,i)>q_confLimit(:,i)), zeros(120-size_elements_above_threshold(1,1),1));
   
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

% % Normalize the first_pt_q_residual by dividing the q_limit
% first_pt_q_residual_norm = first_pt_q_residual./ q_confLimit;
% 
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

 q_residual_c = cat(1,q_residual_model,q_residual_pred);
                      
                  
%Print the file to excel                  
stat_print = fullfile('C:\Users\INSAV3\Predictive Analytics\DataSets\CASE\Datasets\Results', 'TestCase_Results.xlsx');
      
xlswrite(stat_print, test_results,'Results','G2');

stat_print2 = fullfile('C:\Users\INSAV3\Predictive Analytics\DataSets\CASE\Datasets\Results', 'Q_residual_Results.xlsx');
      
xlswrite(stat_print2, q_residual_c,'q_residual','a2');                 
                  