
 
% PCA model development using PLS toolbox
options = pca('options');  % constructs a options structure for PCA
options.plots = 'none';
options.preprocessing = preprocess('default','autoscale'); %structure array
ConfLimit = 0.95; % Confidence Limit for threshold


 
model_1  = pca(x5283944_KL_Trg,2,options);
options.plots = 'final';
options.display = 'off';
pred_1    = pca(x5283944_KL_Test,model_1,options);

q_residual_model_1  = model_1.ssqresiduals{1,1};
q_residual_pred_1  = pred_1.ssqresiduals{1,1};
q_confLimit_1 = residuallimit(model_1 ,ConfLimit);
summary_stat_1 = summary(q_residual_pred_1);
elements_above_threshold_1 = find(q_residual_pred_1>q_confLimit_1);
first_pt_outside_threshold = 20-elements_above_threshold_1(1);
size_above_threshold = size(elements_above_threshold_1);
count_elements_above_threshold_1 = size_above_threshold(1,1);
summary_stat = summary_stat_1.data(1:5,1);
summary_stat = cat(1,summary_stat,first_pt_outside_threshold,count_elements_above_threshold_1);


%-------------------------------------------------
% Now we'll show how you might apply the model to new
% data, but we'll use the same data set.

%