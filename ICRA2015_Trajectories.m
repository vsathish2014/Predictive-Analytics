
% trajectory 1
    q_1 = [-2.7925   0.2036   -1.5126   -1.9199   -1.7453    0.0000];
    q_2 = [0.0690   -0.0582   -3.1125   -1.9199   -1.7453    0.0000];

      t = [0:10:30]';
    % Half cycle information
    [q_c1 qd_c1 qdd_c1] = jtraj(q_1,q_2,t);
% Cartesian postion of end efector    
    Tq1 = p560.fkine(q_c1);
    
    
    figure(1);
    subplot(1,2,1)
  %  subaxis(1,2,1, 'Spacing', 0.05, 'Padding', 0, 'Margin', 0.075);
    plot3(Tq1(:,1),Tq1(:,2),Tq1(:,3),'color','k','Linewidth',2);
    title('Top view - Trajectory 1','FontSize',14);
      axis image
    ylim([-1 1])
    xlim([-1 1])
    zlim([-1 1])
    
    set(gca,'FontSize',12);
    az =0;
    el = 90;
    view(az,el);
    subplot(1,2,2);
  %    subaxis(1,2,2, 'Spacing', 0.03, 'Padding', 0, 'Margin', 0.05);
    plot3(Tq1(:,1),Tq1(:,2),Tq1(:,3),'color','k','Linewidth',2);
     title('Side view - Trajectory 1','FontSize',14);
       set(gca,'YTick',[-1:0.2:1]);
         axis image;
       ylim([-1 1])
       xlim([-1 1])
       zlim([-1 1]) 
    view (0,0);
    set(gca,'FontSize',12);
  
    
    % Trajecotry 2:
   q_1 = [ 0    0   0   0   0    0];
   q_2 = [-2.7925   -0.7854    0.7854   -1.9199   -1.7453   -4.6426];

         t = [0:10:30]';
    % Half cycle information
    [q_c2 qd_c2 qdd_c2] = jtraj(q_1,q_2,t);
   
    % Cartesian postion of end efector    
    Tq2 = p560.fkine(q_c2);

    
    
    figure(2);
    subplot(1,2,1);
    plot3(Tq2(:,1),Tq2(:,2),Tq2(:,3),'color','k','Linewidth',2);
    % subaxis(1,2,1, 'Spacing', 0, 'Padding', 0, 'Margin', 0);
    title('Top view - Trajectory 2','FontSize',14);
    %set(gca,'YTick',[-1:0.2:1]);
    axis image;
      ylim([-1 1]);
    xlim([-1 1]);
    zlim([-1 1]);
    az =0;
    el = 90;
    view(az,el);
     set(gca,'FontSize',12);
     
    subplot(1,2,2);
    plot3(Tq2(:,1),Tq2(:,2),Tq2(:,3),'color','k','Linewidth',2);
    % subaxis(1,2,2, 'Spacing', 0.03, 'Padding', 0, 'Margin', 0.05);
     title('Side view - Trajectory 2','FontSize',14);
     axis image;
       ylim([-1 1])
    xlim([-1 1])
    zlim([-1 1])
    view (0,0);
     set(gca,'FontSize',12);
    
    % Trjecotry 3
    
  % q_1 = [-2.6201    0.0582   -1.3963   -1.0752   -0.3879    0.6305];
    q_1=    [0         0   -1.5708         0         0         0];
    q_2 = [-0.8964    3.0252   -1.6290    1.5493   -0.7326    1.3183];
    
   % q_2 = [2.2754    2.7344   -1.9199    0.6443    0.9050   -1.0890];
    
          t = [0:10:30]';
    % Half cycle information
    [q_c3 qd_c3 qdd_c3] = jtraj(q_1,q_2,t);
   
    % Cartesian postion of end efector    
    Tq3 = p560.fkine(q_c3);

    
    
    figure(3);
   % setappdata(gcf, 'SubplotDefaultAxesLocation', [0, 0, 1, 1]);
    subplot(1,2,1);
    plot3(Tq3(:,1),Tq3(:,2),Tq3(:,3),'color','k','Linewidth',2);
   %  subaxis(1,2,1, 'Spacing', 0.03, 'Padding', 0, 'Margin', 0.05);
    title('Top view - Trajectory 3','FontSize',14);
    axis image;
      ylim([-1 1])
    xlim([-1 1])
    zlim([-1 1])
    az =0;
    el = 90;
    view(az,el);
     set(gca,'FontSize',12);
     
    subplot(1,2,2);
   %  setappdata(gcf, 'SubplotDefaultAxesLocation', [0, 0, 1, 1]);
    plot3(Tq3(:,1),Tq3(:,2),Tq3(:,3),'color','k','Linewidth',2);
  %   subaxis(1,2,2, 'Spacing', 0.03, 'Padding', 0, 'Margin', 0.05);
     title('Side view - Trajectory 3','FontSize',14);
     axis image;
       ylim([-1 1])
    xlim([-1 1])
    zlim([-1 1])
    view (0,0);
     set(gca,'FontSize',12);
    
    
