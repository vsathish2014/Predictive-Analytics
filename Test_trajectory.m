clear;
clc;
profile on
mdl_puma560
  p560.payload(0, [0,0,0.1]);
  L = p560.links
T1 = transl(0.4, 0.2, 0)* trotx(pi);
T2 = transl(0.4, -0.2, 0.2)* trotx(pi);
 

% Initial and Joint corodinate vectors associated with the above poses are
q1 = p560.ikine6s(T1);
q2 = p560.ikine6s(T2);
 

% Motion to occur over a time period 2 seconds in 50  ms time steps

t = [0:1:2]';

[q, qd, qdd] = jtraj(qr,q2,t);
tau = p560.rne(q,qd,qdd)