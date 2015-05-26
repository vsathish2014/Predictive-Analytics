% Plots
clear all, 
clc;

% Load file
Results_data = readtable('TestCase_Results_m.xlsx','Sheet',1); 
Results_data = table2cell(Results_data); 
Results_data = cell2mat(Results_data(:,1:11));

% sort based on Training Type and then robot condition
Results_data = sortrows(Results_data,[1,3]);

OTM_F_Results =  Results_data(1:12,1:11);
OTM_N_Results = Results_data(13:24,1:11 );
OTO_F_Results =  Results_data(25:30,1:11) ;
OTO_N_Results = Results_data(31:36,1:11) ;

figure(1);
subplot(2,2,1)
 y = [mean(OTM_F_Results(:,6)) mean(OTM_N_Results(:,6)) 
     mean(OTO_F_Results(:,6)) mean(OTO_N_Results(:,6))];
     stderror_mean = [std(OTM_F_Results(:,6))/sqrt(length(OTM_F_Results(:,6))) std(OTM_N_Results(:,6))/sqrt(length(OTM_N_Results(:,6))) 
                  std(OTO_F_Results(:,6))/sqrt(length(OTO_F_Results(:,6)))  std(OTO_N_Results(:,6))/sqrt(length(OTO_N_Results(:,6)))];
  % bar_handle =bar(y,'group');
  bar_handle = barwitherr(stderror_mean,y,'group');
    ylim([0 4*10^5]);
  set(bar_handle(1),'FaceColor',[1 0 0])
set(bar_handle(2),'FaceColor',[0 0 1]) 
   ylabel('Average Q Residual','FontSize',12)
  % title(statTitle_3,'FontSize',14)
    set(gca,'XTick',[1:2],'FontSize',7);
    set(gca,'xticklabel',{'OTM-Failure OTM-Normal','OTO-Failure OTO-Normal'},'FontSize',10);
    set(gcf,'color','w');

  subplot(2,2,2)
 y = [mean(OTM_F_Results(:,7)) mean(OTM_N_Results(:,7)) 
     mean(OTO_F_Results(:,7)) mean(OTO_N_Results(:,7))];
     stderror_max = [std(OTM_F_Results(:,7))/sqrt(length(OTM_F_Results(:,7))) std(OTM_N_Results(:,7))/sqrt(length(OTM_N_Results(:,7))) 
                  std(OTO_F_Results(:,7))/sqrt(length(OTO_F_Results(:,7)))  std(OTO_N_Results(:,7))/sqrt(length(OTO_N_Results(:,7)))];
  % bar_handle =bar(y,'group');
  bar_handle = barwitherr(stderror_max,y,'group');
  % ylim([0 4*10^5]);
  set(bar_handle(1),'FaceColor',[1 0 0])
set(bar_handle(2),'FaceColor',[0 0 1]) 
   ylabel('Max Q Residual','FontSize',12)
  % title(statTitle_3,'FontSize',14)
    set(gca,'XTick',[1:2],'FontSize',7);
    set(gca,'xticklabel',{'OTM-Failure OTM-Normal','OTO-Failure OTO-Normal'},'FontSize',10);
    set(gcf,'color','w');  
 
   subplot(2,2,3)
 y = [mean(OTM_F_Results(:,8)) mean(OTM_N_Results(:,8)) 
     mean(OTO_F_Results(:,8)) mean(OTO_N_Results(:,8))];
     stderror_std = [std(OTM_F_Results(:,8))/sqrt(length(OTM_F_Results(:,8))) std(OTM_N_Results(:,8))/sqrt(length(OTM_N_Results(:,8))) 
                  std(OTO_F_Results(:,8))/sqrt(length(OTO_F_Results(:,8)))  std(OTO_N_Results(:,8))/sqrt(length(OTO_N_Results(:,8)))];
  % bar_handle =bar(y,'group');
  bar_handle = barwitherr(stderror_std,y,'group');
   ylim([0 4*10^5]);
  set(bar_handle(1),'FaceColor',[1 0 0])
set(bar_handle(2),'FaceColor',[0 0 1]) 
   ylabel('Std deviation Q Residual','FontSize',12)
  % title(statTitle_3,'FontSize',14)
    set(gca,'XTick',[1:2],'FontSize',7);
    set(gca,'xticklabel',{'OTM-Failure OTM-Normal','OTO-Failure OTO-Normal'},'FontSize',10);
    set(gcf,'color','w');     
    
     subplot(2,2,4)
 y = [mean(OTM_F_Results(:,11)) mean(OTM_N_Results(:,11)) 
     mean(OTO_F_Results(:,11)) mean(OTO_N_Results(:,11))];
     stderror_r_TFA = [std(OTM_F_Results(:,11))/sqrt(length(OTM_F_Results(:,11))) std(OTM_N_Results(:,11))/sqrt(length(OTM_N_Results(:,11))) 
                  std(OTO_F_Results(:,11))/sqrt(length(OTO_F_Results(:,11)))  std(OTO_N_Results(:,11))/sqrt(length(OTO_N_Results(:,11)))];
  % bar_handle =bar(y,'group');
  bar_handle = barwitherr(stderror_r_TFA,y,'group');
  %  ylim([0 4*10^5]);
  set(bar_handle(1),'FaceColor',[1 0 0])
set(bar_handle(2),'FaceColor',[0 0 1]) 
   ylabel('Q Residual(normalized) First sample','FontSize',12)
  % title(statTitle_3,'FontSize',14)
    set(gca,'XTick',[1:2],'FontSize',7);
    set(gca,'xticklabel',{'OTM-Failure OTM-Normal','OTO-Failure OTO-Normal'},'FontSize',10);
    set(gcf,'color','w');     
    
    
figure(2);
subplot(1,2,1)
 y = [mean(OTM_F_Results(:,9)) mean(OTM_N_Results(:,9)) 
     mean(OTO_F_Results(:,9)) mean(OTO_N_Results(:,9))];
     stderror_mean = [std(OTM_F_Results(:,9))/sqrt(length(OTM_F_Results(:,9))) std(OTM_N_Results(:,9))/sqrt(length(OTM_N_Results(:,9))) 
                  std(OTO_F_Results(:,9))/sqrt(length(OTO_F_Results(:,9)))  std(OTO_N_Results(:,9))/sqrt(length(OTO_N_Results(:,9)))];
  % bar_handle =bar(y,'group');
  bar_handle = barwitherr(stderror_mean,y,'group');
    ylim([0 20]);
  set(bar_handle(1),'FaceColor',[1 0 0])
set(bar_handle(2),'FaceColor',[0 0 1]) 
   ylabel('Time(days) of first sample above threshold','FontSize',12)
  % title(statTitle_3,'FontSize',14)
    set(gca,'XTick',[1:2],'FontSize',7);
    set(gca,'xticklabel',{'OTM-Failure OTM-Normal','OTO-Failure OTO-Normal'},'FontSize',10);
    set(gcf,'color','w');

  subplot(1,2,2)
 y = [mean(OTM_F_Results(:,10)) mean(OTM_N_Results(:,10)) 
     mean(OTO_F_Results(:,10)) mean(OTO_N_Results(:,10))];
     stderror_max = [std(OTM_F_Results(:,10))/sqrt(length(OTM_F_Results(:,10))) std(OTM_N_Results(:,10))/sqrt(length(OTM_N_Results(:,10))) 
                  std(OTO_F_Results(:,10))/sqrt(length(OTO_F_Results(:,10)))  std(OTO_N_Results(:,10))/sqrt(length(OTO_N_Results(:,10)))];
  % bar_handle =bar(y,'group');
  bar_handle = barwitherr(stderror_max,y,'group');
    ylim([0 20]);
  set(bar_handle(1),'FaceColor',[1 0 0])
set(bar_handle(2),'FaceColor',[0 0 1]) 
   ylabel('Number of Samples above threshold','FontSize',12)
  % title(statTitle_3,'FontSize',14)
    set(gca,'XTick',[1:2],'FontSize',7);
    set(gca,'xticklabel',{'OTM-Failure OTM-Normal','OTO-Failure OTO-Normal'},'FontSize',10);
    set(gcf,'color','w'); 
      