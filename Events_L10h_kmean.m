% SISL10h Clusters

clc;
clear;
close all;

% Dock all the charts  as tabs
 set(0,'DefaultFigureWindowStyle','docked')
 
 

% Read the data dayily sheet
    
        % data =readtable('07_Events_L10h_Analysis_all_d2.xlsx','Sheet',5,'Range','C1:DY198');
 
% Read consolidated sheet
        data =readtable('07_Events_L10h_Analysis_all_d5.xlsx','Sheet',8,'Range','B1:LG152');
% % Read events with more than 40 coccurence         
% %         data =readtable('07_Events_L10h_Analysis_all_d2.xlsx','Sheet',5,'Range','C1:AT198');
%       
      
 %data = table2cell(data(:,3:end)); 
 data = table2cell(data); 
 data = cell2mat(data);
[rowMax colMax] =size(data);
 o_labels =  readtable('07_Events_L10h_Analysis_all_d5.xlsx','Sheet',8,'Range','LK1:LK152');
 o_labels = table2cell(o_labels); 
 o_labels = cell2mat(o_labels);
 j = 1;
 for col_id =1:colMax
   
    idx3 = kmeans(data(:,1:col_id),2,'Distance','sqEuclidean');    
    p_labels = idx3;
    idx_all(:,j)= idx3;
    c  = confusionmat(o_labels,p_labels);
    accuracy = (c(1,1)+c(2,2))/sum(sum(c));
    c_all(:,:,j) = c;
    accuracy_all(j,1) = accuracy;
    j = j +1;
   
 end
 
 figure(1);
  plot(accuracy_all);
  xlabel 'Number of attributes -Event type';
  ylabel 'Accuracy'
  
 j = 1; 
for col_id =1:colMax
   
    idx3 = kmeans(data(:, col_id),2,'Distance','sqEuclidean');    
    p_labels = idx3;
    idx_all_1(:,j)= idx3;
    c  = confusionmat(o_labels,p_labels);
    accuracy = (c(1,1)+c(2,2))/sum(sum(c));
    c_all_1(:,:,j) = c;
    accuracy_all_1(j,1) = accuracy;
    j = j +1;
   
 end
 
 figure(2);
 x_l =  readtable('07_Events_L10h_Analysis_all_d5.xlsx','Sheet',8,'Range','LO1:LO319');
 x_l = table2cell(x_l); 
 x_l = cell2mat(x_l);
  plot(accuracy_all_1);
  xlabel 'Number of attributes -Event type';
  ylabel 'Accuracy with each attribute'
 
 
%   figure;
% [silh3,h] = silhouette(data,idx3,'sqEuclidean');
% % h = gca;
% % h.Children.EdgeColor = [.8 .8 1];
% xlabel 'Silhouette Value';
% ylabel 'Cluster';
% 
%  figure(2);
% [silh3,h] = silhouette(data,idx3,'sqEuclidean');
% % h = gca;
% % h.Children.EdgeColor = [.8 .8 1];
% xlabel 'Silhouette Value';
% ylabel 'Cluster';
% % Silhoutte criteria to find the optimal clusters
% E = evalclusters(data,'kmeans','silhouette','klist',[1:10]);
% figure(3);
% plot(E)

% % Confusion matrix
% 
% o_labels =  readtable('07_Events_L10h_Analysis_all_d5.xlsx','Sheet',6,'Range','MT1:MT175');
%  o_labels = table2cell(o_labels); 
%  o_labels = cell2mat(o_labels);
%  
%  p_labels = idx3;
%  c = confusionmat(o_labels,p_labels);
 
%  % Event groups  - cluster
 
%  event_group = readtable('07_Events_L10h_Analysis_all_d4.xlsx','Sheet',14,'Range','B1:X194');
%   event_group = table2cell(event_group); 
%  event_group = cell2mat(event_group);
%  
%  idx_events = kmeans(event_group,6,'Distance','sqEuclidean');         
%          
%   figure(4);
% [silh4,h1] = silhouette(event_group,idx_events,'sqEuclidean');
% % h = gca;
% % h.Children.EdgeColor = [.8 .8 1];
% xlabel 'Silhouette Value';
% ylabel 'Cluster';
% 
%   
% E1 = evalclusters(event_group,'kmeans','silhouette','klist',[1:10]);
% figure(5);
% plot(E1)
 
 