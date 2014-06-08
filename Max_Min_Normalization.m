clc;
clear;

% Read the data
    data1 = xlsread('MotionHist_SelectedContollers_d0.xlsx','S_MotionHist_32592728_ROB_1','A2:R10000');
   [num1 txt1 raw1] = xlsread('MotionHist_SelectedContollers_d0.xlsx','S_MotionHist_32592728_ROB_1','A1:R10000');
   [num2 txt2 raw2] = xlsread('MotionHist_SelectedContollers_d0.xlsx','S_MotionHist_32592728_ROB_1','A1:A1');
[maxRows maxCols] = size(data1);
 % max min normalization 
 for nCols = 1 :18
     y_max  = max(data1(:,nCols));
     y_min  = min(data1(:,nCols));
     
      
        y_norm(:,nCols) = (data1(:,nCols)- y_min) /(y_max -y_min);
 end
 
     