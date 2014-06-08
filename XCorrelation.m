clc;
clear;

% Read the data
    data1 = xlsread('MotorFailure_44060208_raw_d0.xlsx','Axis_1_2_CCorr','A2:I10000');
   [num1 txt1 raw1] = xlsread('MotorFailure_44060208_raw_d0.xlsx','Axis_1_2_CCorr','A2:I10000');
   [num2 txt2 raw2] = xlsread('MotorFailure_44060208_raw_d0.xlsx','Axis_1_2_CCorr','A1:A1');

 y1 = data1(:,3);
 y2 = data1(:,6);
   %// Normalize signals to zero mean and unit variance
s1 = (y1- mean(y1)) / std(y1);
s2 = (y2 - mean(y2)) / std(y2);
%// Compute time lag between signals
%c = xcorr(s1, s2);   %// Cross correlation

 

[c, lags] = xcorr(s1,s2)
[m,i]=max(c);
tau=lags(i);
plot(lags, c(1:end));
%lag = mod(find(c == max(c)), length(s2)) %// Find the position of the peak


