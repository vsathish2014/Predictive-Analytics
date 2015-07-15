clear ;
clc;
%%
fileID = fopen('JLRData.csv');

while not(feof(fileID))
    
        C = textscan(fileID,'%s %f32  %f32  %s %s %s %s  ', 'Delimiter', ',','CollectOutput',1, 'HeaderLines',1);
end
fclose(fileID);
%%

%celldisp(C)
% %format short g
% %M = [datenum(a{1}) a{2}]

JLR_Data = cat(2, C{1},C{2},num2cell(C{3}));
% JLR_Data(1,1)=cellstr('OPCVM6'); % To address the problem with some special character
 

[maxRows maxCols] = size(JLR_Data); 
 
% Trageted EVent 
 TE = 38101; % SMB Communication Failue
% = 20253 ; % External device temperature high, DRV1
%TE = 50361 ; % Brake release error
%TE = 50204 ; % Motion Supervision

k = 1;
CountTE=0;
for k = 1: maxRows
    if k > 1 && cell2mat(JLR_Data(k-1,3))==TE
       CountTE = CountTE+1;
    elseif k==1
        CountTE = 1;
    else
        CountTE = CountTE;
    end
  seq_TE_all(k) = CountTE;
   
end


JLR_Data_1 = cat(2,JLR_Data,num2cell(seq_TE_all'));
l = 1;
CountBTE=1;
for l = 1: maxRows
        if l > 1 && cell2mat(JLR_Data_1(l-1,4))==cell2mat(JLR_Data_1(l,4))
           CountBTE = CountBTE+1;
        elseif l == maxRows
            CountBTE = CountBTE;
        else 
            CountBTE = 1;
        end
     seq_bTE_all(l) = CountBTE;
   
end



%JLR_Data_1 = cat(2,JLR_Data,num2cell(eventNo'),num2cell(Seq_50056'),num2cell(seq_50056_all'), num2cell(seq_b50056_all'));

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


JLR_Data_2 = cat(2, double(machineID'), eventdateno,double(eventcode),double(seq_TE_all'),double(seq_bTE_all'));


% 30 minutes before TE
x = 1;
timeCounter=1;
JLR_TE = zeros(1,5);
double(JLR_TE) 
for x = 1:maxRows
    seq = JLR_Data_2(x,4);
    if JLR_Data_2(x,3)==TE
        time_t1 = JLR_Data_2(x,2);        
        y = x;
        while (time_t1 - JLR_Data_2(y,2))/(delta*60) <30    
            if JLR_Data_2(y,4)~=seq
                break;
            end
            y = y-1;            
        end
        
        JLR_TE = cat(1,JLR_TE(:,:),JLR_Data_2(y+1:x,:)); 
 
    end
end   


% Create time diff from Targeted Event
[maxRowsT maxColsT] = size(JLR_TE);

v = 1;
timeCounter=1;
time_diff = zeros(1,1);
double(time_diff) 
for v = 1:maxRowsT
    seq = JLR_TE(v,4);
    if JLR_TE(v,3)==TE
        time_t = JLR_TE(v,2);
        
        w = v;
        while JLR_TE(w,4)==seq                    
            w = w-1;            
        end
        time_d = (time_t - JLR_TE(w+1:v,2))/(delta*60);
        time_diff = cat(1, time_diff,time_d);
    end
end   
 
 
% 
% cell2csv('test4.csv',JLR_Data); % write the file to CSV

%  dlmwrite('g.txt',JLR_50056,'delimiter', ',');


z = 1;
newbCountTE=0;
for z = 1: maxRowsT
    if JLR_TE(z,3)==TE
       newbCountTE= 1;
    else
        newbCountTE = newbCountTE+1;
    end
  newseq_bTE_all(z) = newbCountTE;
   
end
  
 newseq_bTE_all =  newseq_bTE_all'


% reverse Sequence No 
 z = 1;
rnewbCountTE=0;
 
rnewseq_bTE_all = zeros(1,1);
for z = 1: maxRowsT
    if JLR_TE(z,3)==TE        
        k = z;
        seq =  JLR_TE(z,4);
        while  JLR_TE(k,4)==seq
            if k>2
             k = k-1;
            else
                k =1;
                break;
            end
        end
        temp = [ z-k:-1:1]';
        rnewseq_bTE_all = cat(1,rnewseq_bTE_all,temp);
        
    end
end
 


% Set flag for first occurence of an event in sequence
flag = zeros(maxRowsT,1);
for a =1:maxRowsT
    seq1 = JLR_TE(a,4);
    eventcode =JLR_TE(a,3);
    flag_d = 0;
    for b = 1:maxRowsT
        if (JLR_TE(b,3)==eventcode) && JLR_TE(b,4)==seq1 && flag_d==0
            flag(b)= 1;
            flag_d =1;
%         elseif flag_d==1 && (JLR_50056(b,3)==eventcode) && JLR_50056(b,4)==seq1 
%             flag(b)=flag(b)+1;
        end
    end
end
       
JLR_TE_1 = cat(2,JLR_TE,rnewseq_bTE_all,time_diff,flag);

% Writing data to a file
 col_header ={'MachineID','EventLogDate','EventCode','Seq_TE','O_Seq_BTE','Seq_BTE','Time_to_TE','FO_Flag'};
 fileName = strcat('JLR_Targeted_Event_',num2str(TE));
        tau_print = fullfile('C:\ABB\4-DM\JLR\Analysis', fileName);
        xlswrite(tau_print,col_header,'RawData','A1');
        xlswrite(tau_print,JLR_TE_1(2:end,:),'RawData','A2');
