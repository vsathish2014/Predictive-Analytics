clear all, close all
%% Define the global variables - these variables will be used by several functions
global UID no_uaid time_vec out_mat_full Row_sum_out_mat_full ic u_UID


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