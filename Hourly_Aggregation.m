j =1
for i = 1:720:86400
   
    test(j) = mean(tau(i:i+719,1))
    j = j +1;
end
    
y1 = mean(reshape(x,720,[]))';

% k = 1
% for l = 1 : 4: 100
%     test_avg(k,1) = mean(tau(l:l+3,1))
%     k = k +1;
% end

x = tau(:,1)
y  = mean(reshape(x,4,[]))'
 
for m = 1:120
    
    test_avg(m,1) = y(m*180,1);
    
end