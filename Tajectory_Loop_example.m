p_test = mstraj(path,[0.5 0.5 0.3],[],[0.5 -0.5 -0.5],0.2,0.2);
Tp_test = transl(0.5*p_test);
Tp_test = homtrans(transl(0.5, 0, 0),Tp_test);
q_test = p560.ikine6s(Tp_test);
p560.plot(q_test);

for i = 1:4
    p560.plot(q_test)
end
