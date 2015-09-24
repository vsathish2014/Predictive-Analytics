clear all, close all
%% Define the global variables - these variables will be used by several functions
global UID no_uaid time_vec out_mat_full Row_sum_out_mat_full ic u_UID

%% Load alarm event log data from A MAT file

% %[data,txt,all_data]=xlsread('Alaram_Data.xlsx');
% [~,~,all_data]=xlsread('Full_Alaram_Data.xlsx');
% save all_data all_data
% load Devon_Data_Activation_Events % This will create a cell array "C" in MATLAB workspce. Each cell in "C" would Contain a column of Alarm data
%% Exatarcting relevant information from cell array "C"
% EventID = C{1,1};% 1st column of "C" contains Event ID info
% TimeStamp = C{1,2}; %2nd column of "C" stores Time Stamp info
% SourceS=C{1,3}; %3rd column of "C" contains source info
% Cond=C{1,4};%4th column of "C" contains source info
% Severity=C{1,5}; %5th column of "C" contains Alarm/Event Severity info
% AlarmC=C{1,6};%6th column of "C" contains Alarm Change info
% AlarmS=C{1,7};%7th column of "C" contains Alarm State info

% EventID=[1:start_indx]';
% TimeStamp = C{1,1}; %2nd column of "C" stores Time Stamp info
% SourceS=C{1,2};
% Cond=C{1,5};
% Severity=C{1,6};
% AlarmC=C{1,8};
% AlarmS=C{1,9};
% clear C
%% Reading the alarm/event data from excel file & Extarcting the useful/relevant information from the data
% C=cell(4000000,5);
% j=1;
% for i=1:13
%     [~,~,C1]=xlsread(['D:\Kaushik\IAM\Dong Energy Data\Dong Energy Data Reduced\Data' num2str(i) '_reduced.xlsx']); % Read the alarm/ event log data directly from the xlsx file
%     [nro,~]=size(C1);
%     C(j:j+nro-2,:)=C1(2:end,:);
%     clear C1
%     j=j+nro-1;
% end
% 
% emptyCells = cellfun('isempty', C); 
% C(all(emptyCells,2),:) = [];
% clear emptyCells
% 
% save('DongEnergyDataReduced','C');
%%
% load DongEnergyDataReduced

% file_list=ls('D:\Kaushik\Robotics\EventLog\*.csv');
% file_list=cellstr(file_list);
% f_format1='%*s "%u32" %s %*s %*s %*s "%[^"] %*[^\n]';
% f_format2='%*s %u32 %s %*s %*s %*s "%[^"] %*[^\n]';
% 
% 
% load CriticalEventID
% 
% uid_trip=Cri_ID; % UID of all Critical Events
% clear Cri_ID
% uid_trip=[34261;34303;34304;34306;34316;34307;34317;34309;34203];
% no_trip_alaram=length(uid_trip); %Total number of unique critical events in the data

%% Define parameters for CEA
del_sec=datenum(2014,1,1,6,10,2)-datenum(2014,1,1,6,10,1); %Value of 1s in MATLAB (as number)
slice_len=3600; % time slice length in sec
ocr_thr=1; %Mininum No. of occurance of a Critial Event to be considered in CEA
confi_thr=0.005; %Minimum Confidence and co-occurance of the associated alarms
anls_dir=-1; % Direction of CEA, use -1 for past/backword analysis. & +1 for future/forward analysis

    
%%    
%load BMWData

%load BMW_NewData

load EventLogData_till22092015.mat

% TimeStamp = C(2:end,1); %1st column of "C" stores Time Stamp info
% UID=cell2mat(C(2:end,5));
%% Mention the Column number for time stamp & event code
TimeStamp = C(2:end,1); %1st column of "C" stores Time Stamp info
UID=cell2mat(C(2:end,6));

clear C

Cntr_ID=1;

% for fn=1:size(file_list,1)
%     fileID = fopen(file_list{fn,1});
% 
%     C = textscan(fileID,f_format1,'Delimiter', ',', ...
%         'HeaderLines',1);
%     if isempty(C{1,1})
%         C = textscan(fileID,f_format2,'Delimiter', ',', ...
%         'HeaderLines',1);
%     end
%         
%     fclose(fileID);
%     
%     TimeStamp = C{1,2}; %1st column of "C" stores Time Stamp info
%     UIDs=C{1,3};
%     Cntr_ID=unique((C{1,1}));
% 
%     bad_idx=find(strcmp(UIDs,'NULL'));
%     good_idx=setdiff((1:length(UIDs))',bad_idx);
% 
%     TimeStamp=TimeStamp(good_idx,1);
%     UIDs=UIDs(good_idx,1);
%     UID=str2double(UIDs);
    
    
    

% load Dong4Hadoop_minus60sec

%%
% Extarct the useful/relevant event information
% EventID = cell2mat(C(2:end,2));% 2nd column of "C" contains Event ID info
% TimeStamp = (C(:,1)); %1st column of "C" stores Time Stamp info
% SourceS=C(:,3); %3rd column of "C" contains source info
% Cond=C(:,4);%6th column of "C" contains source info
% Severity= cell2mat(C(:,5)); %5th column of "C" contains Alarm/Event Severity info
% AlarmC=C(:,2);%7th column of "C" contains Alarm Change info
% EventID=(1:length(Severity))';
%AlarmS=C{1,7};%7th column of "C" contains Alarm State info

% TimeStamp = (C(2:end,3)); %1st column of "C" stores Time Stamp info
% UIDs=(C(2:end,7));
% 
% bad_idx=find(strcmp(UIDs,'NULL'));
% good_idx=setdiff([1:length(UIDs)]',bad_idx);
% 
% TimeStamp=TimeStamp(good_idx,1);
% UIDs=UIDs(good_idx,1);
% UID=cell2mat(UIDs);
%time_vec = cell2mat(C(:,1)); %1st column of "C" stores Time Stamp info
% SourceS=C(:,4); %3rd column of "C" contains source info
% Cond=C(:,6);%6th column of "C" contains source info
% Severity= cell2mat(C(:,5)); %5th column of "C" contains Alarm/Event Severity info
% AlarmC=C(:,7);%7th column of "C" contains Alarm Change info
% EventID=(1:length(Severity))';
%     clear C
%     clear good_idx bad_idx UIDs
% 
%% Sorting data based on Time stamp so that all the events will be according to their chronological order
% time_vec=datenum(TimeStamp); %Store the TimeStamp info as number in MATLAB in a column vector "time_vec"
    %time_vec=datenum(TimeStamp,'mm/dd/yyyy HH:MM:SS PM'); %Store the TimeStamp info as number in MATLAB in a column vector "time_vec"
    
    time_vec=datenum(TimeStamp);
    
    [time_vec,I]=sort(time_vec); %Sort the column vector "time_vec" in the ascending order
% Sort all the revelent fields according to their chronological order 
    TimeStamp=TimeStamp(I,:); 
    UID=UID(I,:);
    % SourceS=SourceS(I,:);
    % Cond=Cond(I,:);
    % Severity=Severity(I);
    % AlarmC=AlarmC(I,:);
    % AlarmS=AlarmS(I,:);
    % EventID=EventID(I,:);
    clear I
% 
%%
% Good_Idx= find(strcmp(AlarmC,'New') & strcmp(AlarmS,'ACT'));
% % idx_rtn= find(strcmp(AlarmC,'Inactive') & strcmp(AlarmState,'RTN'));
% % Good_Idx=sort([idx_act;idx_rtn]);
% 
% 
% TimeStamp=TimeStamp(Good_Idx);
% SourceS=SourceS(Good_Idx);
% Cond=Cond(Good_Idx);
% Severity=Severity(Good_Idx);
% AlarmC=AlarmC(Good_Idx);
% AlarmS=AlarmS(Good_Idx);
% % EventID=EventID(Good_Idx);
% % RelatedEventID=RelatedEventID(Good_Idx);

%% Sorting data based on Time stamp so that all the events will be according to their chronological order - not required if the data is alaready arraged in chornological manner
% time_vec=datenum(TimeStamp,'dd.mm.yyyy HH:MM:SS'); %Store the TimeStamp info as number in MATLAB in a column vector "time_vec"

%% Storing the TimeStamp info as number in MATLAB in a column vector "time_vec"
% time_vec=TimeStamp;
% clear TimeStamp

%% Creating a new attribute - Unique Alaram ID
% Fields_Unique_Id=[SourceS,Cond]; % Combine the fields (columns) that define unique alarm ID
% [UID,uCA,no_uaid]=create_Unique_AlarmID(Fields_Unique_Id);
    [u_UID,ia,ic]=unique(UID);
    no_uaid=length(u_UID);
    
%     [N,~]=hist(UID,u_UID);
%     [N,J]=sort(N,'descend');
%     u_UID=u_UID(J);
    
   %uid_trip=[34261;34303;34304;34306;34316;34307;34317;34309;34203]; % u_UID(1:24)=[34261;34303;34304;34306;34316;34307;34317;34309;34203];
   %% Mentiona Traget Events
    uid_trip=[34306,34307]; %uid_trip=[40230,10020];
    no_trip_alaram=length(uid_trip); %Total number of unique critical events in the data

%% Creating a new attribute - Related Event ID 
% key_word = 'activate';  %A string which indiates start/on of an alarm/event in
% %                   the data. When Alram State of an alarm is equal to the
% %                   string in "key_word" indiates that start/on of that
% %                   alarm
% 
% key_word_rtn='return-to-normal'; %A string which indiates return to normal status of an alarm/event in
%                   the data. When Alram State of an alarm is equal to the
%                   string in "key_word" indiates that return to normal status of that
%                   alarm
% %%
% RelatedEventID=create_related_event_ID1(EventID,UID,AlarmC,key_word);
% 
% %%
% idx_act= find(strcmp(AlarmC,key_word));
% idx_rtn= find(strcmp(AlarmC,key_word_rtn));
% 
% AlarmC(idx_act,1)=cellstr('activate');
% AlarmC(idx_rtn,1)=cellstr('return-to-normal');
%%
% tic
% fileID = fopen('DongEnergy_Data_OMV_format.txt','w');
% f_format_header='%s\t%s\t%s\t%s\t%s\t%s\t%s\r\n';
% fprintf(fileID,f_format_header,'TimeStamp','EventID','RelatedEventID','Source', 'Severity', 'Condition','AlarmState');
% f_format='%s\t%u\t%s\t%s\t%u\t%s\t%s\r\n';
% fprintf(fileID,'%6s %12s\n','x','exp(x)');
% for i=1:length(Severity)
%     if isnan(RelatedEventID(i,:))
%         fprintf(fileID,f_format,TimeStamp{i,:},EventID(i,:),'',SourceS{i,:},Severity(i,:),Cond{i,:},AlarmC{i,:});
%     else
%         fprintf(fileID,f_format,TimeStamp{i,:},EventID(i,:),num2str(RelatedEventID(i,:)),SourceS{i,:},Severity(i,:),Cond{i,:},AlarmC{i,:});
%     end
% end
% fclose(fileID);
% toc

%% Defining Critical Events & Extarcting the UIDs of Critical events in the data
% Defining Critical Events
% Trip_Idx=find(Severity>=901 & Severity<=1000); % Find the indices of the critical events from the definition of critical events provided by the user. Change this line based on the definition of critical events in your data
% Trip_Idx=find(Severity>=800 & Severity<=1000); 
%     load CriticalEventID
% Trip_Idx=find(Severity==1000);
% Find the indices of the critical events from the definition of critical events provided by the user. Change this line based on the definition of critical events in your data
%%
%     uid_trip=Cri_ID; % UID of all Critical Events
%     clear Cri_ID
%Trip_Severity=Severity(Trip_Idx); % Severity of all Critical Events


% [AA0,BB0]=hist(Severity,unique(Severity));
% figure(2);
% bar(BB0,AA0); 
% xlabel('Severity');
% ylabel('No of Events');
% %%
% figure(3)
% pie(AA0([5,6,8]));
%%
% [uid_trip, ia,~]=unique(Trip_UID);%UID unique critical events
% Trip_Severity=Trip_Severity(ia);
% 
% % Plot Histogram of Critical Events
% [AA,BB]=hist(Trip_UID,unique(UID));
% figure(1);
% bar(AA); 
% xlabel('Unique ID of Trip Alarms');
% ylabel('No of Event of the Trip Alarms');

%     no_trip_alaram=length(uid_trip); %Total number of unique critical events in the data

%% Define parameters for CEA
%     del_sec=datenum(2014,1,1,6,10,2)-datenum(2014,1,1,6,10,1); %Value of 1s in MATLAB (as number)
%     slice_len=3600*(24*10); % time slice length in sec
%     ocr_thr=1; %Mininum No. of occurance of a Critial Event to be considered in CEA
%     confi_thr=0.05; %Minimum Confidence and co-occurance of the associated alarms
%     anls_dir=-1; % Direction of CEA, use -1 for past/backword analysis. & +1 for future/forward analysis

%% Create an empty/blank cell array for storing the results of critical event analysis
% Results_All=cell(no_trip_alaram+1,28); % Create an empty/blank cell array for storing the results of critical event analysis
% Results_All(1,1:5)={'CriticalEvent.UID','CriticalEvent.Severity','CriticalEvent.Source','CriticalEvent.Condition','CriticalEvent.NumOccurance'};% Headerline of 1st 5 columns in "Results_All" cell array
%% Initialization of Results Cell Array
Results_All=cell(no_trip_alaram+1,11); % Create an empty/blank cell array for storing the results of critical event analysis
Results_All(1,1:11)={'ControllerID','CriticalEvent.UID','CriticalEvent.NumOccurance','AssociatedAlarm.UID','AssociatedAlarm.Confidence','AssociatedAlarm.Cooccurance','AssociatedAlarm.MeanTimeDiff','AssociatedAlarm.MedianTimeDiff (s)', 'AssociatedAlarm.StdTimeDiff (s)','AssociatedAlarm.MaxTimeDiff (s)','AssociatedAlarm.MinTimeDiff (s)'};% Headerline of 1st 5 columns in "Results_All" cell array
row_no=1;

%%
    [out_mat_full, Row_sum_out_mat_full] = generic_time_slicing(slice_len,del_sec);
%%
%% Create an empty/blank cell array for storing the results of critical event analysis
%     Results_All=cell(no_trip_alaram+1,10); % Create an empty/blank cell array for storing the results of critical event analysis
%     Results_All(1,1:10)={'CriticalEvent.UID','CriticalEvent.NumOccurance','AssociatedAlarm.UID','AssociatedAlarm.Confidence','AssociatedAlarm.Cooccurance','AssociatedAlarm.MeanTimeDiff','AssociatedAlarm.MedianTimeDiff (s)', 'AssociatedAlarm.StdTimeDiff (s)','AssociatedAlarm.MaxTimeDiff (s)','AssociatedAlarm.MinTimeDiff (s)'};% Headerline of 1st 5 columns in "Results_All" cell array
%     row_no=1;
%%
    for ii=1:no_trip_alaram %[1:5209 5211:no_trip_alaram] % For each unique Critical Alarm
%     
        disp([Cntr_ID,ii]);
        [Num_Occurance, Asso_Alarms_UID, Asso_Alarm_Confi, Asso_Alarm_Cooccur, Asso_Alarm_Mean_Time_Diff, Asso_Alarm_Med_Time_Diff, Asso_Alarm_Std_Time_Diff, Asso_Alarm_Max_Time_Diff, Asso_Alarm_Min_Time_Diff]=CEA_func_new(uid_trip(ii),slice_len,del_sec,ocr_thr,confi_thr,anls_dir);
       % The above function perfrom the CEA analysis for given critical event.
       % It provides Num of occurances of the CE in the data, UID of all
       % the associated alarms with confidence & co-occurance more than or equal to
       % specifed by the users. Average, Std. dev., Max & min of time
       % differences between the Associated alarm and the given Critical Event.

       % Store the revelant info of each critical event in the cell array
       % "Results_All"
%         Results_All{ii+1,1}=uid_trip(ii);
%         Results_All{ii+1,2}=Trip_Severity(ii);
%         Results_All(ii+1,[3 4])=uCA(uid_trip(ii),:);
%         Results_All{ii+1,5}=Num_Occurance;
    
       % Store the revelant info of all the associated alarms identified thru CEA for given critical event in the cell array
       % "Results_All"
            if ~isempty(Asso_Alarms_UID)
            
%             col_no=5;
               
                for jj=1:length(Asso_Alarms_UID)
                    row_no=row_no+1;
                    Results_All{row_no,1}=Cntr_ID;
                    Results_All{row_no,2}=uid_trip(ii);
%                 Results_All{row_no,2}=Trip_Severity(ii);
%                 Results_All(row_no,[3 4])=uCA(uid_trip(ii),:);
                    Results_All{row_no,3}=Num_Occurance;
                
%                  col_no=col_no+1;
                    Results_All{row_no,4}=u_UID(Asso_Alarms_UID(jj));
%                  col_no=col_no+2;
%                  Results_All(row_no,[7 8])=uCA(Asso_Alarms_UID(jj),:);
% %                  col_no=col_no+1;
%                     
                    Results_All{row_no,5}=Asso_Alarm_Confi(jj);
                 %col_no=col_no+1;
                    
                    Results_All{row_no,6}=Asso_Alarm_Cooccur(jj);
%                  col_no=col_no+1;
                    
                    Results_All{row_no,7}=Asso_Alarm_Mean_Time_Diff(jj);
%                  col_no=col_no+1;
                    Results_All{row_no,8}=Asso_Alarm_Med_Time_Diff(jj);
%                  col_no=col_no+1;
                    Results_All{row_no,9}=Asso_Alarm_Std_Time_Diff(jj);
%                  col_no=col_no+1;
                    Results_All{row_no,10}=Asso_Alarm_Max_Time_Diff(jj);
%                  col_no=col_no+1;
                    Results_All{row_no,11}=Asso_Alarm_Min_Time_Diff(jj);
                
                
                    
%                     col_no=col_no+1;
%                     Results_All{ii+1,col_no}=Asso_Alarms_UID(jj);
%                     col_no=col_no+2;
%                     Results_All(ii+1,[col_no-1 col_no])=uCA(Asso_Alarms_UID(jj),:);
%                     col_no=col_no+1;
%                     
%                     Results_All{ii+1,col_no}=Asso_Alarm_Confi(jj);
%                     col_no=col_no+1;
%                     
%                     Results_All{ii+1,col_no}=Asso_Alarm_Cooccur(jj);
%                     col_no=col_no+1;
%                     
%                     Results_All{ii+1,col_no}=Asso_Alarm_Mean_Time_Diff(jj);
%                     col_no=col_no+1;
%                     Results_All{ii+1,col_no}=Asso_Alarm_Med_Time_Diff(jj);
%                     col_no=col_no+1;
%                     Results_All{ii+1,col_no}=Asso_Alarm_Std_Time_Diff(jj);
%                     col_no=col_no+1;
%                     Results_All{ii+1,col_no}=Asso_Alarm_Max_Time_Diff(jj);
%                     col_no=col_no+1;
%                     Results_All{ii+1,col_no}=Asso_Alarm_Min_Time_Diff(jj);
                end
            end
    end
% end

 % Headerline of 6th column on-wards in the "Results_All" cell array
%  [~,ncol]=size(Results_All);
%   max_no_associated_Alarm=(ncol-5)/10;
%   for ji=1:max_no_associated_Alarm
%       Results_All(1,5+(ji-1)*10+1:5+(ji-1)*10+10)={['AssociatedAlarm' num2str(ji) '.UID'],['AssociatedAlarm' num2str(ji) '.Source'],['AssociatedAlarm' num2str(ji) '.Condition'],['AssociatedAlarm' num2str(ji) '.Confidence'],['AssociatedAlarm' num2str(ji) '.Cooccurance'],['AssociatedAlarm' num2str(ji) '.MeanTimeDiff (s)'], ['AssociatedAlarm' num2str(ji) '.MedianTimeDiff (s)'], ['AssociatedAlarm' num2str(ji) '.StdTimeDiff (s)'],['AssociatedAlarm' num2str(ji) '.MaxTimeDiff (s)'],['AssociatedAlarm' num2str(ji) '.MinTimeDiff (s)']};
%   end
  
  % Removing the empty rows in the Cell Array "Results_All"
  emptyCells = cellfun('isempty', Results_All); 
  Results_All(all(emptyCells,2),:) = [];
  clear emptyCellsells

  % Write Results of CEA (i.e., the cell array "Results_All") in the a
  % excel file
  xlswrite('EventLogJunResult.xlsx',Results_All);