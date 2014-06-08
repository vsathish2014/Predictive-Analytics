clc;
clear;

% Read the data
    data1 = xlsread('MotorFailure_44060208_raw_d0.xlsx','Axis_1_2_CCorr','A2:I10000');
   [num1 txt1 raw1] = xlsread('MotorFailure_44060208_raw_d0.xlsx','Axis_1_2_CCorr','A2:I10000');
   [num2 txt2 raw2] = xlsread('MotorFailure_44060208_raw_d0.xlsx','Axis_1_2_CCorr','A1:A1');

%  y1 = data1(1:549,3);
%  y2 = data1(1:549,6);
  y1 = data1(:,3);
 y2 = data1(:,6);

%// Calling CCF function
 
 CCF = ccf_fft(y1,y2);
 plot(CCF.X,CCF.C)
 title ('Correlation Coeff ');
 xlabel('Samples');