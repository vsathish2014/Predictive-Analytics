load clown
[U,S,V] = svd(X,0);
ranks = [1 2 5 10 20 rank(X)];
for k=ranks(:)'
Xhat = (U(:,1:k)*S(1:k,1:k)*V(:,1:k)');
image(Xhat);
end