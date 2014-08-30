% Create histgram
clear distance;
axis = 1;
% max_tau_1 = 97.6;
% max_tau_2 = 186.4;
% max_tau_3 = 89.4;
% max_tau_4 = 24.2;
% max_tau_5 = 20.1;
% max_tau_6 = 21.3;

max_tau_1 = max(abs(tau_pn_mn_1(2:13,1)));
max_tau_2 = max(abs(tau_pn_mn_1(2:13,2)));
max_tau_3 = max(abs(tau_pn_mn_1(2:13,3)));
max_tau_4 = max(abs(tau_pn_mn_1(2:13,4)));
max_tau_5 = max(abs(tau_pn_mn_1(2:13,5)));
max_tau_6 = max(abs(tau_pn_mn_1(2:13,6)));
switch axis
    case 1
        max_tau = max_tau_1;
    case 2
        max_tau = max_tau_2;
    case 3
         max_tau = max_tau_3;
    case 4
        max_tau = max_tau_4;
    case 5
        max_tau = max_tau_5;
    case 6
        max_tau = max_tau_6;
end
     

edges = [0; 0.1*max_tau;0.2*max_tau;0.3*max_tau;0.4*max_tau;0.5*max_tau;0.6*max_tau; ...
    0.7*max_tau;0.8*max_tau;0.9*max_tau;1.0*max_tau;1.1*max_tau];
%;1.1*max_tau
clear bincounts
clear bincounts1
clear bincounts2
edges = edges(:,:);
size_edges = size(edges);
no_bins = size_edges(1,1);
k=1;
%sampling size 
s = 60;
for i = 1:s:720
bincounts1(:,:,k)=histc(  abs(tau_pn_mn_1(i:i+s-1,axis)),edges);
k =k +1;

end
 bincounts2 = reshape(bincounts1,no_bins,720/s);
  bincounts = bincounts2./repmat(sum(bincounts2),size(bincounts2,1),1);




% convert histogram infor to expectation
clear entropy_i;
clear entropy_sum;
%Weight_vector = [0.05; 0.15 ; 0.25 ; 0.35 ; 0.45 ; 0.55 ; 0.65 ; 0.75; 0.85; 0.95 ;1.025;1.075];
Weight_vector = [0.05; 0.15 ; 0.25 ; 0.35 ; 0.45 ; 0.55 ; 0.65 ; 0.75; 0.85; 0.95 ;1.05;1.15];
expectation = bincounts(:,:)' * Weight_vector(1:12,1);

std_dev = std(bincounts);
entropy_i = -bincounts.*log(bincounts)
entropy_sum = nansum(entropy_i);


figure(3);
plot(expectation);
% axis([0,12,0.5,2]);
set(gca,'PlotBoxAspectRatio',[5 2 1]) 
 
set(gca,'Title',text('String','Expectation vs samples','FontSize',16)); 
 
xlabel('samples','FontSize',14);
ylabel('Expectation','FontSize',14);

figure(4);
plot(entropy_sum);
%  axis([0,12,.5,2]);
set(gca,'PlotBoxAspectRatio',[5 2 1]) 
 
set(gca,'Title',text('String','Entropy vs samples','FontSize',16)); 
 
xlabel('samples','FontSize',14);
ylabel('Entropy','FontSize',14);

figure(5);
%plot(time_minutes, tau_pn_mn_1);
plot( tau_pn_mn_3(:,1),'LineWidth',2);
set(gca,'PlotBoxAspectRatio',[5 2 1])
set(gca,'Title',text('String','Overall Torque - Joint configuration 7 - Axis 1','FontSize',16)); 
 
xlabel('Time in minutes','FontSize', 14);
ylabel('Torque (Nm)','FontSize', 14);
%qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
%set(qdd_legend,'FontSize',10);
grid on;

% figure(4);
% plot(std_dev);
for counter = 1:12
distance(counter) = kldiv(bincounts(:,1)',bincounts(:,counter)'+eps)
end
kldiv_dist = distance(end,:);