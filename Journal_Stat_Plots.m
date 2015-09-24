% Plots
% clear all, 
% clc;

% Load file
Results_data = readtable('TestCase_Results_OTM_Diff_DS10.xlsx','Sheet',1); 
Results_data = table2cell(Results_data); 
Results_data = cell2mat(Results_data(:,1:9));

% sort based on Training Type and then robot condition, then signal Type
Results_data = sortrows(Results_data,[1,2,3]);
 
OTM_F_ST2 = Results_data(find(Results_data(:,1)==1 & Results_data(:,2)==2 & Results_data(:,3)==1) ,:); 
OTM_N_ST2 = Results_data(find(Results_data(:,1)==1 & Results_data(:,2)==2 & Results_data(:,3)==2) ,:);
  
clear h
for plotno= 1:3
h(plotno) = figure(plotno);
y_labels ={'Coeff of Variation: Q Residual',...
            'Lead time (days)',...
           'Number of Samples above threshold'} ;
%

%    subplot(2,2,plotno)
 y = [ 
     mean(OTM_F_ST2(:,6+plotno)) mean(OTM_N_ST2(:,6+plotno)) 
       
      ];
     
     stderror_mean = [       
                  std(OTM_F_ST2(:,6+plotno))/sqrt(length(OTM_F_ST2(:,6+plotno))) std(OTM_N_ST2(:,6+plotno))/sqrt(length(OTM_N_ST2(:,6+plotno))) 
                    
                    ];
                  
                 
  % bar_handle =bar(y,'group');
  bar_handle = barwitherr(stderror_mean,y,'group');
  
  if plotno == 2  
     ylim([0 20]);
  elseif plotno ==3
     ylim([0 30]);
  elseif plotno ==1
    ylim([0 4]);
 
  end
%   set(bar_handle(1),'FaceColor',[1 0 0])
% %  set(bar_handle(2),'FaceColor',[0 0  1]) 
   ylabel(y_labels(plotno),'FontSize',12)
  % title(statTitle_3,'FontSize',14)
    set(gca,'XTick',[1:2],'FontSize',7);
   % set(gca,'xticklabel',{'OTM-F-ST1 OTM-N-ST1','OTO-F-ST1 OTO-N-ST1','OTM-F-ST2 OTM-F-ST2','OTO-F-ST2 OTO-N-ST2','OTM-F-ST3 OTM-F-ST3','OTO-F-ST3 OTO-N-ST3'},'FontSize',10);
   set(gca,'xticklabel',{ 'Normal','Failure' },'FontSize',10);

    set(gcf,'color','w');
   % legend('Failure', 'Normal');
     set(gca,'box','off');
     legend('boxoff');
   % Save the file 
 %saveas(h(plotno),sprintf('figure_%d.fig',plotno))
  
 savefig(h,'OTM_DS10_ThreeDaysBeforeFailure_var90.fig') 
  
end    
    
