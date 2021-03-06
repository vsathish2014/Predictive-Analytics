
% convert histogram infor to expectation
clear entropy_i;
clear entropy_sum;
Weight_vector = [0.05; 0.15 ; 0.25 ; 0.35 ; 0.45 ; 0.55 ; 0.65 ; 0.75; 0.85; 0.95 ;1.05;1.15;1.25;1.35];

expectation = bincounts(:,:)' * Weight_vector(:,1);

std_dev = std(bincounts);
entropy_i = -bincounts.*log(bincounts)
entropy_sum = nansum(entropy_i);


figure(3);
plot(expectation);
%axis([0,12,0.5,1]);
set(gca,'PlotBoxAspectRatio',[5 2 1]) 
 
set(gca,'Title',text('String','Expectation vs samples','FontSize',16)); 
 
xlabel('samples','FontSize',14);
ylabel('Expectation','FontSize',14);

figure(4);
plot(entropy_sum);
%axis([0,12,1,3.5]);
set(gca,'PlotBoxAspectRatio',[5 2 1]) 
 
set(gca,'Title',text('String','Entropy vs samples','FontSize',16)); 
 
xlabel('samples','FontSize',14);
ylabel('Entropy','FontSize',14);

% figure(4);
% plot(std_dev);