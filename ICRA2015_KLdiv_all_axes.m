clc;
clear all;
 
plot_trajectory = 3;
plot_fc_pct = 20;
% fc_axis = 1
switch plot_trajectory
    case 1 
        switch plot_fc_pct
            case 10
                load ICRA2015_Tajectory1_FC_10pct_22092014_5_days_All.mat
            case 20
                load ICRA2015_Tajectory1_FC_20pct_22092014_5_days_All.mat
        end
    case 2 
        switch plot_fc_pct
            case 10
                load ICRA2015_Tajectory2_FC_10pct_22092014_5_days_All.mat

            case 20
                load ICRA2015_Tajectory2_FC_20pct_22092014_5_days_All.mat
        end
    case 3 
        switch plot_fc_pct
            case 10
                load ICRA2015_Tajectory3_FC_10pct_21092014_5_days_All.mat

            case 20
                load ICRA2015_Tajectory3_FC_20pct_21092014_5_days_All.mat

        end       
     
end

% Sample the signal - hourly 
    time_hours = [1:6:120];
    % tau_fc_pn_mn = tau_fc_pn_mn(:,:,2);
    
    tau_fc_pn_mn_2(:,:,:) = tau_fc_pn_mn(2:end,:,:);    
      
    tau_fc_pn_mn_hs = tau_fc_pn_mn_2(4:360:end,:,:);
    
     




% KL Divergence
for fc_axis = 1:6 
    for axis = 1 : 6
        %axis = 1;
%         max_tau_1 = 97.6;
%         max_tau_2 = 186.4;
%         max_tau_3 = 89.4;
%         max_tau_4 = 24.2;
%         max_tau_5 = 20.1;
%         max_tau_6 = 21.3;

        max_tau_1 = max(abs(tau_fc_pn_mn(2:6,1,fc_axis)));
        max_tau_2 = max(abs(tau_fc_pn_mn(2:6,2,fc_axis)));
        max_tau_3 = max(abs(tau_fc_pn_mn(2:6,3,fc_axis)));
        max_tau_4 = max(abs(tau_fc_pn_mn(2:6,4,fc_axis)));
        max_tau_5 = max(abs(tau_fc_pn_mn(2:6,5,fc_axis)));
        max_tau_6 = max(abs(tau_fc_pn_mn(2:6,6,fc_axis)));
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
        %clear bincounts
        clear bincounts1
        clear bincounts2
        edges = edges(:,:);
        size_edges = size(edges);
        no_bins = size_edges(1,1);
        k=1;
        %sampling size 
        s = 60;
        for i = 1:s:43200
            bincounts1(:,:,k)=histc(  abs(tau_fc_pn_mn(i:i+s-1,axis,fc_axis)),edges);
            k =k +1;
        end
             bincounts2 = reshape(bincounts1,no_bins,43200/s);
             
             bincounts(:,:,axis) = bincounts2./repmat(sum(bincounts2),size(bincounts2,1),1);

             bincounts(isnan(bincounts))=0;
      % Compared with sample taken after one hour  - need to check        
            for counter = 1:720
                 distance(counter) = kldiv(bincounts(:,2,axis)' ,bincounts(:,counter,axis)'+eps);
            end
    kldiv_dist(axis,:,fc_axis) = distance(end,:);
    end
% entropy_sum = reshape(entropy_sum,720,6);
% x_axis = [1:720]
clear distance;
    x_axis = [1:120];
    kldiv_dist_hs(:,:,fc_axis) = kldiv_dist(:,1:6:end,fc_axis);
end
figure(1);
plot(x_axis,kldiv_dist_hs(:,:,1),'LineWidth',2);
% axis([0,12,.5,2]);
set(gca,'PlotBoxAspectRatio',[5 2 1]) ;
 
set(gca,'Title',text('String','KL Divergence Vs Samples','FontSize',14)); 
 qdd_legend = legend('Axis 1','Axis 2','Axis 3','Axis 4','Axis 5','Axis 6');
set(qdd_legend,'FontSize',10);
xlabel('samples','FontSize',12);
ylabel('K-L distance','FontSize',12);
set(gca,'XTick',[0:10:120]);

% Writing KL distance to fie

 permuted_kldiv_dist_hs = permute(kldiv_dist_hs,[2,1,3]); 

 col_header ={'Axis_1','Axis_2','Axis_3','Axis_4','Axis_5','Axis_6'};
 
 switch plot_fc_pct
     case 10

        tau_print = fullfile('c:\results', 'Traj_3_KLD_fc_10pct.xlsx');
        xlswrite(tau_print,col_header,'KLD_fc_1','A1');
        xlswrite(tau_print,permuted_kldiv_dist_hs(:,:,1),'KLD_fc_1','A2');
        xlswrite(tau_print,col_header,'KLD_fc_2','A1');
        xlswrite(tau_print,permuted_kldiv_dist_hs(:,:,2),'KLD_fc_2','A2');
        xlswrite(tau_print,col_header,'KLD_fc_3','A1');
        xlswrite(tau_print,permuted_kldiv_dist_hs(:,:,3),'KLD_fc_3','A2');
        xlswrite(tau_print,col_header,'KLD_fc_4','A1');
        xlswrite(tau_print,permuted_kldiv_dist_hs(:,:,4),'KLD_fc_4','A2');
        xlswrite(tau_print,col_header,'KLD_fc_5','A1');
        xlswrite(tau_print,permuted_kldiv_dist_hs(:,:,5),'KLD_fc_5','A2');
        xlswrite(tau_print,col_header,'KLD_fc_6','A1');
        xlswrite(tau_print,permuted_kldiv_dist_hs(:,:,6),'KLD_fc_6','A2');
        
     case 20
         tau_print = fullfile('c:\results', 'Traj_3_KLD_fc_20pct.xlsx');
        xlswrite(tau_print,col_header,'KLD_fc_1','A1');
        xlswrite(tau_print,permuted_kldiv_dist_hs(:,:,1),'KLD_fc_1','A2');
        xlswrite(tau_print,col_header,'KLD_fc_2','A1');
        xlswrite(tau_print,permuted_kldiv_dist_hs(:,:,2),'KLD_fc_2','A2');
        xlswrite(tau_print,col_header,'KLD_fc_3','A1');
        xlswrite(tau_print,permuted_kldiv_dist_hs(:,:,3),'KLD_fc_3','A2');
        xlswrite(tau_print,col_header,'KLD_fc_4','A1');
        xlswrite(tau_print,permuted_kldiv_dist_hs(:,:,4),'KLD_fc_4','A2');
        xlswrite(tau_print,col_header,'KLD_fc_5','A1');
        xlswrite(tau_print,permuted_kldiv_dist_hs(:,:,5),'KLD_fc_5','A2');
        xlswrite(tau_print,col_header,'KLD_fc_6','A1');
        xlswrite(tau_print,permuted_kldiv_dist_hs(:,:,6),'KLD_fc_6','A2');

 end     

