function [out_mat_full,Row_sum_out_mat_full] = generic_time_slicing(slice_len,del_sec)
% Slicing the entire event/alarm log data into eaaual time slice baskets. Then
% counting the alarms or events that got activated in each time slice baskets
% 
% Inputs:
% slice_len............ Length of the equal time slice basket in sec
% del_sec.............. Value of 1 sec in MATLAB (as number)
% key_word............. A string which indiates start/on of an alarm/event in
%                       the data. When Alram State of an alarm is equal to the
%                       string in "key_word" indiates that start/on of that alarm
% Outputs:
% out_mat_full........... A matrix of size PXQ. Where, P is the number of
%                         baskets and Q is the number of unique alarms in
%                         the event/alarm log data. An element (p,q) of this
%                         matrix indicates the number of times the qth
%                         alarm/event gets activated in the pth basket.
% Row_sum_out_mat_full... A row vector of size 1XQ. Where, Q is the number 
%                         of unique alarms in the event/alarm log data. The 
%                         qth element of this vector indicates the number 
%                         of times the qth alarm/event gets activated in
%                         the entire event/alarm log.
%
global no_uaid time_vec ic

start_time=time_vec(1); %)all_data{start_idx,2};
stop_time=time_vec(end);% all_data{stop_idx,2};

tot_no_bas = ceil((stop_time-start_time)/(slice_len*del_sec));

% no_uaid=length(unique(cell2mat(all_data(2:end,28)))); % Total no of unique alaram id

out_mat_full=zeros(tot_no_bas,no_uaid);
% mod_out_mat_full=out_mat_full;

str_time=start_time;

% time_vec=cell2mat(all_data(2:end,2));

%   Basket=cell(tot_no_bas+1,28);
%   Basket{1,1}='Basket#';
%   Basket(2:tot_no_bas+1,1)=num2cell([1:tot_no_bas]');

for i=1:1 %tot_no_bas
%     bas_col_no=1;
    %stp_time=str_time+(slice_len*del_sec);
    %idx=find(time_vec>=str_time & time_vec<stp_time);
    
    idx=find(time_vec>=start_time & time_vec<=stop_time);
    if ~isempty(idx)
%         str_idx=idx(1);
%         stp_idx=idx(end);
        acti_alaram_id=ic(idx);
%         acti_time_idx=find(strcmp(AlarmC(str_idx:stp_idx),key_word));
%        if ~isempty(acti_time_idx)
%             acti_alaram_id=UID((str_idx-1)+acti_time_idx);%cell2mat(all_data((str_idx-1)+acti_time_idx,28));
%             acti_alaram_start_time=time_vec((str_idx-1)+acti_time_idx);  %cell2mat(all_data((str_idx-1)+acti_time_idx,2));
%             Basket{i+1,bas_col_no}=i;
            for j=1:length(acti_alaram_id)
                out_mat_full(i,acti_alaram_id(j))=out_mat_full(i,acti_alaram_id(j))+1;

%                   bas_col_no=bas_col_no+1;
%                   Basket{i+1,bas_col_no}=datestr(acti_alaram_start_time(j)+datenum(1900,1,1,0,0,0)-2);
%                   bas_col_no=bas_col_no+1;
%                   Basket{i+1,bas_col_no}=acti_alaram_id(j);
%                   bas_col_no=bas_col_no+1;

            end
 %       end
    end
%     str_time=stp_time;
end
Row_sum_out_mat_full=sum(out_mat_full,1);