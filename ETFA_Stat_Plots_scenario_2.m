% Plots
clear all, 
clc;

% Load file
Results_data = readtable('TestCase_Results_m.xlsx','Sheet',1); 
Results_data = table2cell(Results_data); 
Results_data = cell2mat(Results_data(:,1:12));

% sort based on Training Type and then robot condition, then signal Type
Results_data = sortrows(Results_data,[1,2,3]);
OTM_F_ST1 = Results_data(find(Results_data(:,1)==1 & Results_data(:,2)==1 & Results_data(:,3)==1) ,:); 
OTM_N_ST1 = Results_data(find(Results_data(:,1)==1 & Results_data(:,2)==1 & Results_data(:,3)==2) ,:);
OTO_F_ST1 = Results_data(find(Results_data(:,1)==2 & Results_data(:,2)==1 & Results_data(:,3)==1) ,:);
OTO_N_ST1 = Results_data(find(Results_data(:,1)==2 & Results_data(:,2)==1 & Results_data(:,3)==2) ,:);

OTM_F_ST2 = Results_data(find(Results_data(:,1)==1 & Results_data(:,2)==2 & Results_data(:,3)==1) ,:); 
OTM_N_ST2 = Results_data(find(Results_data(:,1)==1 & Results_data(:,2)==2 & Results_data(:,3)==2) ,:);
OTO_F_ST2 = Results_data(find(Results_data(:,1)==2 & Results_data(:,2)==2 & Results_data(:,3)==1) ,:);
OTO_N_ST2 = Results_data(find(Results_data(:,1)==2 & Results_data(:,2)==2 & Results_data(:,3)==2) ,:);

OTM_F_ST3 = Results_data(find(Results_data(:,1)==1 & Results_data(:,2)==3 & Results_data(:,3)==1) ,:); 
OTM_N_ST3 = Results_data(find(Results_data(:,1)==1 & Results_data(:,2)==3 & Results_data(:,3)==2) ,:);
OTO_F_ST3 = Results_data(find(Results_data(:,1)==2 & Results_data(:,2)==3 & Results_data(:,3)==1) ,:);
OTO_N_ST3 = Results_data(find(Results_data(:,1)==2 & Results_data(:,2)==3 & Results_data(:,3)==2) ,:);



for plotno= 1:6
figure(plotno);
y_labels ={'Average Q Residual','Max Q Residual','Std deviation Q Residual',...
           'Q Residual(normalized) First sample', 'Time(days) of first sample above threshold',...
           'Number of Samples above threshold'} ;
%

%    subplot(2,2,plotno)
 y = [mean(OTM_F_ST1(:,6+plotno)) mean(OTM_N_ST1(:,6+plotno)) 
     mean(OTO_F_ST1(:,6+plotno)) mean(OTO_N_ST1(:,6+plotno))
     
     mean(OTM_F_ST2(:,6+plotno)) mean(OTM_N_ST2(:,6+plotno)) 
     mean(OTO_F_ST2(:,6+plotno)) mean(OTO_N_ST2(:,6+plotno))
     
     mean(OTM_F_ST3(:,6+plotno)) mean(OTM_N_ST3(:,6+plotno)) 
     mean(OTO_F_ST3(:,6+plotno)) mean(OTO_N_ST3(:,6+plotno))];
     
     stderror_mean = [std(OTM_F_ST1(:,6+plotno))/sqrt(length(OTM_F_ST1(:,6+plotno))) std(OTM_N_ST1(:,6+plotno))/sqrt(length(OTM_N_ST1(:,6+plotno))) 
                  std(OTO_F_ST1(:,6+plotno))/sqrt(length(OTO_F_ST1(:,6+plotno)))  std(OTO_N_ST1(:,6+plotno))/sqrt(length(OTO_N_ST1(:,6+plotno)))
                  
                  std(OTM_F_ST2(:,6+plotno))/sqrt(length(OTM_F_ST2(:,6+plotno))) std(OTM_N_ST2(:,6+plotno))/sqrt(length(OTM_N_ST2(:,6+plotno))) 
                  std(OTO_F_ST2(:,6+plotno))/sqrt(length(OTO_F_ST2(:,6+plotno)))  std(OTO_N_ST2(:,6+plotno))/sqrt(length(OTO_N_ST2(:,6+plotno)))
                  
                  std(OTM_F_ST3(:,6+plotno))/sqrt(length(OTM_F_ST3(:,6+plotno))) std(OTM_N_ST3(:,6+plotno))/sqrt(length(OTM_N_ST3(:,6+plotno))) 
                  std(OTO_F_ST3(:,6+plotno))/sqrt(length(OTO_F_ST3(:,6+plotno)))  std(OTO_N_ST3(:,6+plotno))/sqrt(length(OTO_N_ST3(:,6+plotno)))];
                  
                 
  % bar_handle =bar(y,'group');
  bar_handle = barwitherr(stderror_mean,y,'group');
  
  if plotno == 5  
     ylim([0 10]);
  elseif plotno ==6
     ylim([0 30]);
  elseif plotno ==1
    ylim([0 5]);
  else
      ylim([0 3*10^41]);
  end
  set(bar_handle(1),'FaceColor',[1 0 0])
set(bar_handle(2),'FaceColor',[0 0 1]) 
   ylabel(y_labels(plotno),'FontSize',12)
  % title(statTitle_3,'FontSize',14)
    set(gca,'XTick',[1:6],'FontSize',7);
   % set(gca,'xticklabel',{'OTM-F-ST1 OTM-N-ST1','OTO-F-ST1 OTO-N-ST1','OTM-F-ST2 OTM-F-ST2','OTO-F-ST2 OTO-N-ST2','OTM-F-ST3 OTM-F-ST3','OTO-F-ST3 OTO-N-ST3'},'FontSize',10);
    set(gca,'xticklabel',{'OTM-F OTM-N','OTO-F OTO-N','OTM-F OTM-N','OTO-F OTO-N','OTM-F OTM-N','OTO-F OTO-N'},'FontSize',10);

    set(gcf,'color','w');
    
end    
    
