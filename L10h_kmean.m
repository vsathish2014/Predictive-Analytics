% SISL10h Clusters

clc;
clear;
close all;

% Dock all the charts  as tabs
 set(0,'DefaultFigureWindowStyle','docked')
 
 

% Read the data
 
    
         data =readtable('07_Events_L10h_Analysis_all_d5.xlsx','Sheet',1,'Range','F1:G196');
      
 data = table2cell(data); 
 data = cell2mat(data(:,:));

 figure(1)
 boxplot(data(:,2));
% hb = boxplot(data, 'whisker');
% set(gca,'NextPlot','add')
hOutliers = findobj(gcf,'Tag','Outliers');
hOutliersX = findobj(gcf,'Tag','OutliersX');
yy = get(hOutliers,'YData')
yz =get(hOutliersX,'YData')

outliers = cat(2, yy, yz);

outlier_ind = find(ismember(data(:,2),outliers'));
data(outlier_ind,:) =[];
data_i =data;
data = data(:,2);

idx3 = kmeans(data,2,'Distance','sqEuclidean');         
         
  figure(2);
[silh3,h] = silhouette(data,idx3,'sqEuclidean');
% h = gca;
% h.Children.EdgeColor = [.8 .8 1];
xlabel 'Silhouette Value';
ylabel 'Cluster';
% Silhoutte criteria to find the optimal clusters
E = evalclusters(data,'kmeans','silhouette','klist',[1:10]);
figure(3);
plot(E)

 