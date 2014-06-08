% ABB Trajecotry example
clear;
clc;
profile on
mdl_puma560
  p560.payload(0, [0,0,0.1]);
  
path = [ 0.5 -0.5 -0.5 ; 0.5 0.5 -0.5; -0.5 0.5 -0.5; -0.5 -0.5 -0.5;0.5 -0.5 -0.5 ];
p = mstraj(path,[0.5 0.5 0.3],[],[0.5 -0.5 -0.5],0.2,0.2);

Tp = transl(0.5*p);
Tp = homtrans(transl(0.5, 0, 0),Tp);
q = p560.ikine6s(Tp);
p560.plot(q);
%plot(q(:,1));
tau = p560.rne(q,qz,qz);


