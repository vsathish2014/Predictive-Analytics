clear ;
clc;

fileID = fopen('JLR_Data_all.csv');

while not(feof(fileID))
    
        C = textscan(fileID,'%s %s  %f32', 'Delimiter', ',');
end
fclose(fileID);


%celldisp(C)
% %format short g
% %M = [datenum(a{1}) a{2}]

JLR_Data = cat(2, C{1},C{2},num2cell(C{3}));
 JLR_Data(1,1)=cellstr('OPCVM6'); % To address the problem with some special character
 

[maxRows maxCols] = size(JLR_Data); 
 
 
 
delta = datenum(2015, 2, 17, 10,10, 01) - datenum(2015, 2, 17, 10,10, 00) % 1 second in terms of datenum;


% Create machine ID : 
m = 1;
seqmachineID=0;
for m = 1: maxRows
        if m > 1 && strcmp(JLR_Data(m-1,1),JLR_Data(m,1))
           seqmachineID = seqmachineID;
        elseif m==1
            seqmachineID = seqmachineID+1;
            
        else
            seqmachineID = seqmachineID+1;
        end
     machineID(m) = seqmachineID;
   
end

eventdateno = datenum(JLR_Data(:,2));
eventcode =  JLR_Data(:,3) ;
eventcode =cell2mat(eventcode);


JLR_Data_1 = cat(2, double(machineID'), eventdateno,double(eventcode) );

% Create sequence number after every 30 minutes or change of Machine

r_i = 1;
timeCounter =1;
time_1 = JLR_Data_1(r_i,2);
for r_i = 1:maxRows;
    
    if r_i==1
        timeCounter = 1;
        
    
    elseif   JLR_Data_1(r_i,1)==JLR_Data_1(r_i-1,1)  
        if (JLR_Data_1(r_i,2)- time_1)/(delta*60) < 30
            timeCounter = timeCounter  ;
        else
            time_1 = JLR_Data_1(r_i,2);
            timeCounter = timeCounter+1;
        end
    elseif    JLR_Data_1(r_i,1)~=JLR_Data_1(r_i-1,1)    
            time_1 = JLR_Data_1(r_i,2);
            timeCounter = timeCounter+1;
        
     end
    seqTime(r_i) = timeCounter;
    
end

JLR_Data_2 = cat(2, double(machineID'), eventdateno,double(eventcode), double( seqTime' ));


% Create sequence number  within in 30 minutes bin

r_j = 1;
eventCount =1;
for r_j = 1:maxRows
    if  r_j==1
        eventCount =1
    elseif  JLR_Data_2(r_j,4)== JLR_Data_2(r_j-1,4)
        eventCount = eventCount+1;
    else
        eventCount =1;
    end
    seqWtime(r_j) = eventCount;
end

JLR_Data_3 = cat(2, double(machineID'), eventdateno,double(eventcode), double( seqTime' ), double( seqWtime' ));


% Create time diff from Targeted Event
 
r_k = 1;
timeCounter=1;
time_diff = zeros(1,1);
double(time_diff) 
for r_k = 1:maxRows
    seq = JLR_Data_3(r_k,4);
    if  r_k < maxRows && JLR_Data_3(r_k,5)> JLR_Data_3(r_k+1,5) 
        time_t = JLR_Data_3(r_k,2);
        
        w = r_k;
        while JLR_Data_3(w,4)==seq                    
            w = w-1;            
        end
        time_d = (time_t - JLR_Data_3(w+1:r_k,2))/(delta*60);
        time_diff = cat(1, time_diff,time_d);
    end
end   
 


% % 30 minutes before TE
% x = 1;
% timeCounter=1;
% JLR_TE = zeros(1,5);
% double(JLR_TE) 
% for x = 1:maxRows
%     seq = JLR_Data_2(x,4);
%     if JLR_Data_2(x,3)==TE
%         time_t1 = JLR_Data_2(x,2);        
%         y = x;
%         while (time_t1 - JLR_Data_2(y,2))/(delta*60) <30    
%             if JLR_Data_2(y,4)~=seq
%                 break;
%             end
%             y = y-1;            
%         end
%         
%         JLR_TE = cat(1,JLR_TE(:,:),JLR_Data_2(y+1:x,:)); 
%  
%     end
% end   
% 
% 

%  
% % 
% % cell2csv('test4.csv',JLR_Data); % write the file to CSV
% 
% %  dlmwrite('g.txt',JLR_50056,'delimiter', ',');
% 
% 
% z = 1;
% newbCountTE=0;
% for z = 1: maxRowsT
%     if JLR_TE(z,3)==TE
%        newbCountTE= 1;
%     else
%         newbCountTE = newbCountTE+1;
%     end
%   newseq_bTE_all(z) = newbCountTE;
%    
% end
%   
%  newseq_bTE_all =  newseq_bTE_all'
% 
% 
% % reverse Sequence No 
%  z = 1;
% rnewbCountTE=0;
%  
% rnewseq_bTE_all = zeros(1,1);
% for z = 1: maxRowsT
%     if JLR_TE(z,3)==TE        
%         k = z;
%         seq =  JLR_TE(z,4);
%         while  JLR_TE(k,4)==seq
%             if k>2
%              k = k-1;
%             else
%                 k =1;
%                 break;
%             end
%         end
%         temp = [ z-k:-1:1]';
%         rnewseq_bTE_all = cat(1,rnewseq_bTE_all,temp);
%         
%     end
% end
%  
% 
% 
% % Set flag for first occurence of an event in sequence
% flag = zeros(maxRowsT,1);
% for a =1:maxRowsT
%     seq1 = JLR_TE(a,4);
%     eventcode =JLR_TE(a,3);
%     flag_d = 0;
%     for b = 1:maxRowsT
%         if (JLR_TE(b,3)==eventcode) && JLR_TE(b,4)==seq1 && flag_d==0
%             flag(b)= 1;
%             flag_d =1;
% %         elseif flag_d==1 && (JLR_50056(b,3)==eventcode) && JLR_50056(b,4)==seq1 
% %             flag(b)=flag(b)+1;
%         end
%     end
% end
%        
% JLR_TE_1 = cat(2,JLR_TE,rnewseq_bTE_all,time_diff,flag);
% 
% % Writing data to a file
%  col_header ={'MachineID','EventLogDate','EventCode','Seq_TE','O_Seq_BTE','Seq_BTE','Time_to_TE','FO_Flag'};
%  fileName = strcat('JLR_Targeted_Event_',num2str(TE));
%         tau_print = fullfile('C:\ABB\4-DM\JLR\Analysis', fileName);
%         xlswrite(tau_print,col_header,'RawData','A1');
%         xlswrite(tau_print,JLR_TE_1(2:end,:),'RawData','A2');
