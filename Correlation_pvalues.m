% Correlation  with p values

clc;
clear;
close all;

% Dock all the charts  as tabs
 set(0,'DefaultFigureWindowStyle','docked') 

% Read the data
 
    
         data =readtable('L10h_Events_Trend.xlsx','Sheet',2,'Range','B1:Z319');
      
 data = table2cell(data); 
 for k = 1:numel(data)
  if isnan(data{k})
    data{k} = 0;
  end
end
 data_1 = cell2mat(data);
 
 [r,p] = corrcoef(data_1)  % Compute sample correlation and p-values.
[i,j] = find(p<0.000001);  % Find significant correlations.
[i,j]                % Display their (row,col) indices.

 