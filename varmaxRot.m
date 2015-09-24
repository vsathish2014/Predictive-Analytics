% Upload the csv file 
loading =csvread('test5_1.csv', 1, 1, [1,1,91,4]);

% Rotated loading using varimax 
vloads = varimax(loading,options);
LFA = factoran(loading,1,'Rotate','none');
[L3,T] = rotatefactors(LFA(:,1),...
                       'method','promax',...
                       'power',2);