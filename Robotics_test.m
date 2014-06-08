clc;
clear all;
close all;

theta1 = 0;
theta2 = 0;
theta3 = 0;
theta4 = 0;

d1 =0.22; d2 = 0.22; d3 = 0.15; d4 = 0.10;

M1_RPM = 10;    % motor RPM
M2_RPM = 10;
M3_RPM = 10;
M4_RPM = 10;
M5_RPM = 10;

M1_G = 30;     % motor gear ratio
M2_G = 30;
M3_G = 30;
M4_G = 30;
M5_G = 30;

L1=link([ 0 0.22 0 0  0]);
L2=link([ 0 0.22 0 0  0]);  
L3=link([ -pi/2 0	0 0 0]); 
L4=link([pi/2 0	0 0.15 0]); 
L5=link([0 0 0 0 0]); 

L1.qlim = [-pi/2 pi/2];
L2.qlim = [-pi/2 pi/2];
L3.qlim = [-pi/2 pi/2];
L4.qlim = [-pi/2 pi/2];
L5.qlim = [-pi/2 pi/2];

L1.I = [0.02 0 0; 0 0.21 0; 0 0 0.23];
L2.I = [0.27 0 0; 0 0.61 0; 0 0 0.43];
L3.I = [0.06 0 0;0 0.06 0; 0 0 0];
L4.I = [0.00 0 0;0 0.00 0; 0 0 0];
L5.I = [0.06 0 0;0 0.06 0; 0 0 0];

L1.r = [0.1 0 0];   % COG vecotrs
L2.r = [0.1 0 0];
L3.r = [0 0 0];
L4.r = [0.1 0 0];   
L5.r = [0 0 0];


L1.m = 0.2; % link mass
L2.m = 0.2;
L3.m = 2.2;
L4.m = 0;
L5.m = 0.1;

L1.G = 1;   % gear ratio
L2.G = 1;
L3.G = 1;
L4.G = 1;
L5.G = 1;

L1.Jm = 1;  % motor inertia 
L2.Jm = 1;
L3.Jm = 1;
L4.Jm = 1;
L5.Jm = 1;

bot = robot({L1 L2 L3 L4 L5})

bot.gravity = [0 9.81 0]    % add gravity
bot.base = [1 0 0 0;        % change base orientation
            0 0 1 0;
            0 -1 0 0;
            0 0 0 1];


T1 = transl(-0.20, 0, -0.20);         % go from this position
T2 = transl(-0.20, 0, 0.20);          % to this position


M = [1 0 1 1 1 1];

q0 = [ 0 0 0 0 0];

q1 = ikine(bot,T1,q0,M)   % take inverse kinematics of two positions
q2 = ikine(bot,T2,q0,M)

t=(0:0.1:50)';

vel_max = [M1_RPM/(M1_G * 60) M2_RPM/(M2_G * 60) M3_RPM/(M3_G * 60) M4_RPM/(M4_G * 60) M5_RPM/(M5_G * 60)];
vel_max = vel_max.*(2*pi)

[pos,vel,acc]=jtraj(q1,q2,t,[0 0 0 0 0]', vel_max');   % take position, velocity and acceleration for the movement between two points(velocity constrains are applied)

figure;
plot(bot, pos);   %plot the trajectory