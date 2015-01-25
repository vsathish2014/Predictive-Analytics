clc;
clear;
close all;
% Dock all the charts  as tabs
 set(0,'DefaultFigureWindowStyle','docked')
 
 
%Read distrubitions      
        data =readtable('07_Events_L10h_Analysis_all_d4.xlsx','Sheet',12,'Range','B1:AT194');
      
      
 data = table2cell(data); 
 data = cell2mat(data);
 
 
        for counter = 2:45
                 distance(counter) = kldiv(data(:,2)' ,data(:,counter)'+eps);
        end
   % kldiv_dist(axis,:,fc_axis) = distance(end,:);
   distance = distance';
   
   idx_events = kmeans(distance,2,'Distance','sqEuclidean'); 
     figure(1);
[silh4,h1] = silhouette(distance,idx_events,'sqEuclidean');
% h = gca;
% h.Children.EdgeColor = [.8 .8 1];
xlabel 'Silhouette Value';
ylabel 'Cluster';

  
E1 = evalclusters(distance,'kmeans','silhouette','klist',[1:10]);
figure(5);
plot(E1);

% Confusion matrix

o_p_labels =  readtable('07_Events_L10h_Analysis_all_d4.xlsx','Sheet',11,'Range','GP1:GT45');
 o_p_labels = table2cell(o_p_labels); 
 o_p_labels = cell2mat(o_p_labels);
 o_labels = o_p_labels(:,1);
 p_labels = o_p_labels(:,5);
 c = confusionmat(o_labels,p_labels);
   
