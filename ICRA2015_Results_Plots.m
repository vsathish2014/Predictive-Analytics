clc;
clear;
figure(1);
Robot_axes =[1,2,3,4,5,6];
TMAX = [60,80;
         0,0;
         0,85;
         0,0;
         0,0;
         0,0]    ;    
    
bar(TMAX,'group'); 
%title('Fault Detection time (hrs) -Task1','FontSize',14);
set(gca,'PlotBoxAspectRatio',[5 2 1])
xlabel('Axes','FontSize',28);
ylabel('Detection time (hrs)','FontSize',28);
q_legend = legend('Friction increase: 10%','Friction increase: 20%');
set(gca,'fontsize',24);
 
% for i1=1:6
%     t1=text( Robot_axes(1,i1),TMAX(i1,1),num2str(TMAX(i1,1),'%0.0f'),'HorizontalAlignment',...
%     'right','VerticalAlignment','bottom','FontSize',18)
%      t2=text( Robot_axes(1,i1),TMAX(i1,2),num2str(TMAX(i1,2),'%0.0f'),'HorizontalAlignment',....
%      'left','VerticalAlignment','bottom','FontSize',18)
% end
 
set(q_legend,'FontSize',18);
grid on;
 

figure(2);
Robot_axes =[1,2,3,4,5,6];
TMAX = [98,80;
         97,92;
         93,93;
         100,92;
         100,108;
         103,113]    ;    
    
bar(TMAX,'group'); 
%title('Fault Detection time (hrs) -Task2','FontSize',14);
set(gca,'PlotBoxAspectRatio',[5 2 1])
xlabel('Axes','FontSize',28);
ylabel('Detection time (hrs)','FontSize',28);
q_legend = legend('Friction increase: 10%','Friction increase: 20%');
set(gca,'fontsize',24);
 
% for i1=1:6
%     t1=text( Robot_axes(1,i1),TMAX(i1,1),num2str(TMAX(i1,1),'%0.0f'),'HorizontalAlignment',...
%     'right','VerticalAlignment','bottom','FontSize',18)
%      t2=text( Robot_axes(1,i1),TMAX(i1,2),num2str(TMAX(i1,2),'%0.0f'),'HorizontalAlignment',....
%      'left','VerticalAlignment','bottom','FontSize',18)
% end
 
set(q_legend,'FontSize',18);
grid on;
 

figure(3);
Robot_axes =[1,2,3,4,5,6];
TMAX = [89,70;
         0,0;
         0,0;
         0,0;
         0,0;
         95,103]    ;    
    
bar(TMAX,'group'); 
%title('Fault Detection time (hrs) -Task3','FontSize',14);
set(gca,'PlotBoxAspectRatio',[5 2 1])
xlabel('Axes','FontSize',28);
ylabel('Detection time (hrs)','FontSize',28);
q_legend = legend('Friction increase: 10%','Friction increase: 20%');
set(gca,'fontsize',24);
 
% for i1=1:6
%     t1=text( Robot_axes(1,i1),TMAX(i1,1),num2str(TMAX(i1,1),'%0.0f'),'HorizontalAlignment',...
%     'right','VerticalAlignment','bottom','FontSize',18)
%      t2=text( Robot_axes(1,i1),TMAX(i1,2),num2str(TMAX(i1,2),'%0.0f'),'HorizontalAlignment',....
%      'left','VerticalAlignment','bottom','FontSize',18)
% end
 
set(q_legend,'FontSize',18);
grid on;



figure(4);
Robot_axes =[1,2,3,4,5,6];
TMAX = [-28.13,25.61,24.99;
         67.72,54.05,-58.38;
         14.02,-4.93,-6.76;
         -0.79,0.89,-2.2;
         -2.2,3.11,1.15;
         0,0.35,-0.82]    ;    
    
bar(TMAX,'group'); 

set(gca,'PlotBoxAspectRatio',[5 2 1])
xlabel('Axes','FontSize',28);
ylabel('Average Torque (Nm)','FontSize',28);
q_legend = legend('Task 1','Task 2','Task 3');
set(gca,'fontsize',24);
 
for i1=1:6
    t1=text( Robot_axes(1,i1),TMAX(i1,1),num2str(TMAX(i1,1),'%0.1f'),'HorizontalAlignment',...
    'right','VerticalAlignment','bottom','FontSize',18)
     t2=text( Robot_axes(1,i1),TMAX(i1,2),num2str(TMAX(i1,2),'%0.1f'),'HorizontalAlignment',....
     'left','VerticalAlignment','bottom','FontSize',18)
     t3=text( Robot_axes(1,i1),TMAX(i1,3),num2str(TMAX(i1,3),'%0.1f'),'HorizontalAlignment',....
     'left','VerticalAlignment','bottom','FontSize',18)
end
 
set(q_legend,'FontSize',18);
grid on;
 


