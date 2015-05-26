% %Signal-to-noise ratio=2
% t=[0:512]/512; %define a time vector
% signal=sqrt(2)*cos(2*pi*5*t); %define a signal sequence (average power=1 W)
% noise=sqrt(0.5)*randn(1,length(t)); %define a noise sequence (average power=0.5 W)
% sn=signal+noise; %compute the signal+noise sequence
% subplot(2,1,1);plot(t,sn);grid %plot the signal+noise sequence
% %Signal-to-noise ratio=20
% signal2=sqrt(20)*cos(2*pi*5*t); %define a signal sequence (average power=10 W)
% sn2=signal2+noise; %computer the signal+noise sequence
% subplot(2,1,2);plot(t,sn2);grid %plot the signal+noise sequence
% %legend(‘snr=20’,’snr=2’); %add legend to plot 

data = csvread('C:\Users\INSAV3\Predictive Analytics\DataSets\ETFA-Data\Results\Sample_Signal.csv',1,0);
figure(1);

subplot(2,1,1);
plot(data(:,1),'LineWidth',2); grid
set(gca,'xtick',[])
set(gca,'xticklabel',[])
set(gca,'ytick',[])
set(gca,'yticklabel',[])
subplot(2,1,2);
plot(data(:,2),'r','LineWidth',2); grid
set(gca,'ytick',[])
set(gca,'yticklabel',[])
set(gca,'xtick',[])
set(gca,'xticklabel',[])
ylim([0 1]);
% subplot(3,1,3);
% plot(data(:,1));
% hold on
% plot(data(:,2),'r');
% set(gca,'xtick',[])
% set(gca,'ytick',[]);
% set(gca,'yticklabel',[])
set(gca,'xticklabel',[])
