%         [tc1, tlags1] = xcorr(f_pn_mn_1(1:200,2),f_pn_mn_1(520:719,2),'coeff' );
%         [m,id]=max(tc1);
%         tauid=tlags1(id);
%         tauc =tc1(id);
   %  for i = 1 : 720 
        test = f_pn_mn_1(1:650,2);
        [tc1, tlags1] = xcorr(zscore(test),'unbiased'  );
        [m,id]=max(tc1);
       % if m>1
       %     display(i)
       % end
            
        tauid=tlags1(id);
        tauc =tc1(id);
        plot(tlags1,tc1,'b*');
    % end
     
   