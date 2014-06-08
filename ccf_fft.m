function CCF=ccf_fft(X1,X2)
%--------------------------------------------------------------------------
% ccf_fft function                                              timeseries
% Description: Calculate the normalized cross correlation function of
%              two evenly spaced timeseries using fft.
% Input  : - First series. Either Y or [X,Y].
%            Second series. Either Y or [X,Y].
% Output : - Structure containing the following fields:
%            .X - The lag
%            .C - The normalized cross correlation.
% Tested : Matlab R2011b
%     By : Eran O. Ofek                    Dec 2013
%    URL : http://weizmann.ac.il/home/eofek/matlab/
% Example: R=randn(100,1); CCF=ccf_fft(R,R); plot(CCF.X,CCF.C)
% Reliable: 2
%--------------------------------------------------------------------------
Col.X = 1;
Col.Y = 2;
[N1,C1] = size(X1);
[N2,C2] = size(X2);

if (C1==1),
   X1 = [(1:1:N1).', X1];
end
if (C2==1),
   X2 = [(1:1:N2).', X2];
end
D = diff(X1(:,Col.X));
D = D(1);

N = max(N1,N2);

   

Norm = N.*std(X1(:,Col.Y)).*std(X2(:,Col.Y));
CCF.C = ifft(fft(X1(:,Col.Y),N).*conj(fft(X2(:,Col.Y),N))) ./Norm;
CCF.X = (0:1:N-1).'.*D;
