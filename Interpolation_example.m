 x={ 1  2  3  4  5  6  7  8 9 10}
y={ 0.3850 NaN  3.0394 NaN  0.6475  1.0000  1.5000  NaN  1.1506  0.58}
x=cell2mat(x);y=cell2mat(y);
xi=x(find(~isnan(y)));yi=y(find(~isnan(y)))
result=interp1(xi,yi,x,'linear');