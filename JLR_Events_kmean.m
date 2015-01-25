% SISL10h Clusters

clc;
clear;
close all;

% Dock all the charts  as tabs
 set(0,'DefaultFigureWindowStyle','docked')
 
 

% Read the data
 
    
         data =readtable('JLR_SeqClustering_50056.xlsx','Sheet',14,'Range','B1:K26');
      
 %data = table2cell(data(,3:end)); 
 data = table2cell(data); 
 data = cell2mat(data);
idx3 = kmeans(data,20,'Distance','sqEuclidean');   
%idx3 = kmeans(data,2,'Distance','correlation'); 
         
  figure;
[silh3,h] = silhouette(data,idx3,'sqEuclidean');
%[silh3,h] = silhouette(data,idx3,'correlation');
% h = gca;
% h.Children.EdgeColor = [.8 .8 1];
xlabel 'Silhouette Value';
ylabel 'Cluster';
% Silhoutte criteria to find the optimal clusters
E = evalclusters(data,'kmeans','silhouette','klist',[1:20]);
figure(2);
plot(E);

% % Read the data
%  
%     
%          data_c =readtable('JLR_SeqClustering_50056.xlsx','Sheet',13,'Range','L1:M196');
%           data_c = table2cell(data_c); 
%  data_c = cell2mat(data_c);
%  figure(4);
%  plot(data_c(:,1),data_c(:,2),'ok','MarkerFaceColor','k')
%  %scatter(data_c(:,1),data_c(:,2),50,idx3,'filled');

