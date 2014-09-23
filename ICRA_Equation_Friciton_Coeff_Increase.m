syms i;
x1_p = 0.395+0.5/(1+exp(-((3600/i)^4)))-0.25-1.5*.395;
x1_p_sol = solve(x1_p);
 max(double(x1_sol(2)));
 % For 50%
x1_p_est = 0.395+0.5/(1+exp(-((3600/2975.5)^4)))-0.25;
 x1_n_est = -0.435-0.5/(1+exp(-((3600/2975.5)^4)))+0.25;
 
% For 25%
x1_p_est = 0.395+0.5/(1+exp(-((3600/3765.5)^4)))-0.25;
 x1_n_est = -0.435-0.5/(1+exp(-((3600/3765.5)^4)))+0.25;
% For 10 %
x1_p_est = 0.395+0.5/(1+exp(-((3600/4791.5)^4)))-0.25;
 x1_n_est = -0.435-0.5/(1+exp(-((3600/4791.5)^4)))+0.25; 
 
 
 syms j
 x2_p = 0.126+0.5/(1+exp(-((3600/j)^4)))-0.25-1.5*0.126;
 x2_p_sol = solve(x2_p);
  max(double(x2_p_sol(1)));
 % For 10 %
  x2_p_est =  0.126+0.5/(1+exp(-((3600/6387.7)^4)))-0.25;
  x2_n_est = -0.071-0.5/(1+exp(-((3600/6387.7)^4)))+0.25;
  % For 50%
   x2_p_est =  0.126+0.5/(1+exp(-((3600/4249.4)^4)))-0.25;
  x2_n_est = -0.071-0.5/(1+exp(-((3600/4249.4)^4)))+0.25;
 
  
   syms k
 x3_p = 0.132+0.5/(1+exp(-((3600/k)^4)))-0.25-1.5*0.132;
 x3_p_sol = solve(x3_p);
  max(double(x3_p_sol(1)));
% For 10%
  x3_p_est =  0.132+0.5/(1+exp(-((3600/6313.7)^4)))-0.25;
  x3_n_est = -0.105-0.5/(1+exp(-((3600/6313.7)^4)))+0.25;
 % For 50%
  x3_p_est =  0.132+0.5/(1+exp(-((3600/4198)^4)))-0.25;
  x3_n_est = -0.105-0.5/(1+exp(-((3600/4198)^4)))+0.25;
 
  % L(4) : [11.2e-3, -16.9e-3]
     syms l
 x4_p = 11.2e-3+0.5/(1+exp(-((3600/l)^4)))-0.25-1.1*11.2e-3;
 x4_p_sol = solve(x4_p);
  max(double(x4_p_sol(1)));
% For 10%
  x4_p_est =  11.2e-3+0.5/(1+exp(-((3600/11701)^4)))-0.25;
  x4_n_est = -16.9e-3-0.5/(1+exp(-((3600/11701)^4)))+0.25;
  
 % L(5) : [9.26e-3, -14.5e-3] 
 syms m
 x5_p = 9.26e-3+0.5/(1+exp(-((3600/m)^4)))-0.25-1.1*9.26e-3;
 x5_p_sol = solve(x5_p);
  max(double(x5_p_sol(1)));
% For 10%
  x5_p_est =  11.2e-3+0.5/(1+exp(-((3600/12271)^4)))-0.25;
  x5_n_est = -16.9e-3-0.5/(1+exp(-((3600/12271)^4)))+0.25;
  
  
  % L(6)  : [3.96e-3, -10.5e-3]
  syms m
 x6_p = 3.96e-3+0.5/(1+exp(-((3600/m)^4)))-0.25-1.1*3.96e-3;
 x6_p_sol = solve(x6_p);
  max(double(x5_p_sol(1)));
% For 10%
  x6_p_est =  3.96e-3+0.5/(1+exp(-((3600/15174)^4)))-0.25;
  x6_n_est = -10.5e-3-0.5/(1+exp(-((3600/15174)^4)))+0.25;
  
  
  % Friction change 10 % and  5days duration:
  % For 10 %
  syms i;
x1_p = 0.395+0.5/(1+exp(-((432000/i)^4)))-0.25-1.1*.395;
x1_p_sol = solve(x1_p);
 max(double(x1_p_sol(2)));
  
L(1).Tc = [0.395+0.5/(1+exp(-((432000/574970)^4)))-0.25 -0.435-0.5/(1+exp(-((432000/574970)^4)))+0.25; 
 
 
 syms j
 x2_p = 0.126+0.5/(1+exp(-((432000/j)^4)))-0.25-1.1*0.126;
 x2_p_sol = solve(x2_p);
  max(double(x2_p_sol(1)));
 % For 10 %
  L(2).Tc =  [0.126+0.5/(1+exp(-((432000/766530)^4)))-0.25 -0.071-0.5/(1+exp(-((432000/766530)^4)))+0.25]
  
 
  
   syms k
 x3_p = 0.132+0.5/(1+exp(-((432000/k)^4)))-0.25-1.1*0.132;
 x3_p_sol = solve(x3_p);
  max(double(x3_p_sol(1)))
 
 L(3).Tc =  [0.132+0.5/(1+exp(-((432000/757650)^4)))-0.25 -0.105-0.5/(1+exp(-((432000/757650)^4)))+0.25]
  
 
  % L(4) : [11.2e-3, -16.9e-3]
     syms l
 x4_p = 11.2e-3+0.5/(1+exp(-((432000/l)^4)))-0.25-1.1*11.2e-3;
 x4_p_sol = solve(x4_p);
  max(double(x4_p_sol(1)))
L(4).Tc =  [11.2e-3+0.5/(1+exp(-((432000/1404100)^4)))-0.25 -16.9e-3-0.5/(1+exp(-((432000/1404100)^4)))+0.25];
  
 % L(5) : [9.26e-3, -14.5e-3] 
 syms m
 x5_p = 9.26e-3+0.5/(1+exp(-((432000/m)^4)))-0.25-1.1*9.26e-3;
 x5_p_sol = solve(x5_p);
  max(double(x5_p_sol(1))) 
% For 10%
 L(5).Tc =  [9.26e-3+0.5/(1+exp(-((432000/1472500)^4)))-0.25 -14.5e-3-0.5/(1+exp(-((432000/1472500)^4)))+0.25];
  % [9.26e-3, -14.5e-3]
  
  % L(6)  : [3.96e-3, -10.5e-3]
  syms m
 x6_p = 3.96e-3+0.5/(1+exp(-((432000/m)^4)))-0.25-1.1*1.96e-3;
 x6_p_sol = solve(x6_p);
  max(double(x5_p_sol(1)))
% For 10%
  L(6).Tc =  [3.96e-3+0.5/(1+exp(-((432000/147250)^4)))-0.25 -10.5e-3-0.5/(1+exp(-((432000/147250)^4)))+0.25]
  
  
 % Friction change 20 % and  5days duration:
  % For 20 %
  syms i;
x1_p = 0.395+0.5/(1+exp(-((432000/i)^4)))-0.25-1.2*.395;
x1_p_sol = solve(x1_p);
 max(double(x1_p_sol(2)));
  
L(1).Tc = [0.395+0.5/(1+exp(-((j/480310)^4)))-0.25 -0.435-0.5/(1+exp(-((j/480310)^4)))+0.25]; 
 
 
 syms j
 x2_p = 0.126+0.5/(1+exp(-((432000/j)^4)))-0.25-1.2*0.126;
 x2_p_sol = solve(x2_p);
  max(double(x2_p_sol(1)));
 % For 20 %
  L(2).Tc =  [0.126+0.5/(1+exp(-((j/644160)^4)))-0.25 -0.071-0.5/(1+exp(-((j/644160)^4)))+0.25]
  
 
  
   syms k
 x3_p = 0.132+0.5/(1+exp(-((432000/k)^4)))-0.25-1.2*0.132;
 x3_p_sol = solve(x3_p);
  max(double(x3_p_sol(1)))
 
 L(3).Tc =  [0.132+0.5/(1+exp(-((j/636660)^4)))-0.25 -0.105-0.5/(1+exp(-((j/636660)^4)))+0.25];
  
 
  % L(4) : [11.2e-3, -16.9e-3]
     syms l
 x4_p = 11.2e-3+0.5/(1+exp(-((432000/l)^4)))-0.25-1.2*11.2e-3;
 x4_p_sol = solve(x4_p);
  max(double(x4_p_sol(1)))
L(4).Tc =  [11.2e-3+0.5/(1+exp(-((j/1180700)^4)))-0.25 -16.9e-3-0.5/(1+exp(-((j/1180700)^4)))+0.25];
  
 % L(5) : [9.26e-3, -14.5e-3] 
 syms m
 x5_p = 9.26e-3+0.5/(1+exp(-((432000/m)^4)))-0.25-1.2*9.26e-3;
 x5_p_sol = solve(x5_p);
  max(double(x5_p_sol(1))) 
% For 20%
 L(5).Tc =  [9.26e-3+0.5/(1+exp(-((j/1238200)^4)))-0.25 -14.5e-3-0.5/(1+exp(-((j/1238200)^4)))+0.25];
  
  
  % L(6)  : [3.96e-3, -10.5e-3]
  syms m
 x6_p = 3.96e-3+0.5/(1+exp(-((432000/m)^4)))-0.25-1.2*1.96e-3;
 x6_p_sol = solve(x6_p);
  max(double(x6_p_sol(1)))
% For 20%
  L(6).Tc =  [3.96e-3+0.5/(1+exp(-((j/1238200)^4)))-0.25 -10.5e-3-0.5/(1+exp(-((j/1238200)^4)))+0.25];

  
  
  
  
  
  