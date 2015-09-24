function [tot_no_slice, Row_sum_out_mat, Row_sum_org_out_mat, del_t_mat]=find_out_mat_trip_alarm_new(Alarm_UID,slice_len,del_sec,ocr_thr,dir_anlys)
% For given critical event, this function first generates the focused
% critical event baskets. For each activation of critical event C consider
% a basket of time duration "L" before (for backward CEA) or after (for forward CEA) 
% the activation of C. To avoid, generating overlaping, if a critical event basket (forward/backward) 
% for a critical event C contains another C, then consider a basket only from current C 
% up to next the C (for forward) or up to the previous C (for backward).
% Count the alarms/events that are activated in each critical event basket.
% If in a backward critical event basket an alarm (say A) gets actiavted more than one time, 
% then for calculating time difference between A and the critical event, always consider 
% only the earliest A. For confidence and co-occurrence purposes, count A only once.
% If in a forward critical event basket an alarm (say A) gets actiavted more than one time, 
% then for calculating time difference between A and the critical event, always consider 
% only the latest A. For confidence and co-occurrence purposes, count A only once.
% If A occurs more than once in a CEA basket, we count it only once when calculating #A’s in the CEA baskets. 
% Please note confidence = #A’s in the CEA baskets / #CEA_baskets
% Co-occurrence = #A’s in the CEA baskets / [#A’s in the whole log - Total (actual) # of A's in the CEA baskets + #A’s in the CEA baskets]
% For calculating #A’s in the whole log, and also for Total (actual) # of A's in the CEA baskets all A’s are counted.  
% Please note support = #CEA_baskets. For CEA, we have absolute support only and no relative support
% Notice that the numerator for confidence and co-occurrence are same. The denominator is different
%
% Input:
% Alarm_UID.......... Unique Alarm ID of a critical event
% slice_len.......... Length of the equal time slice basket in sec
% del_sec............ Value of 1 sec in MATLAB (as number)
% ocr_thr............ Mininum Number of occurance of a Critial Event to be considered in CEA
% dir_anlys.......... Direction of CEA, use -1 for past/backword analysis. & +1 for future/forward analysis
% key_word........... A string which indiates start/on of an alarm/event in
%                     the data. When Alram State of an alarm is equal to the
%                     string in "key_word" indiates that start/on of that alarm
% Output
% tot_no_slice.......... Total number of occurances of the CE in the entire even/alarm log data
% Row_sum_out_mat....... A row vector of size 1XQ. Where, Q is the number 
%                        of unique alarms in the event/alarm log data. The 
%                        qth element of this vector indicates the number 
%                        of CE baskets in which the qth alarm/event gets activated. 
%                        If in a critical event basket (forward or backward) an alarm (say A) gets actiavted more than one time, 
%                        then count A only once.
% Row_sum_org_out_mat.... A row vector of size 1XQ. Where, Q is the number 
%                         of unique alarms in the event/alarm log data. The 
%                         qth element of this vector indicates the total
%                         number of actiavation of qth alarm/event in all
%                         CE baskets of a given critical event C.                         
% del_t_mat.............. A matrix of size BXQ. Where, B is the number of
%                         CE baskets and Q is the number of unique alarms in
%                         the event/alarm log data. An element (b,q) of this
%                         matrix indicates the time difference (in sec) between qth
%                         alarm/event and the critical event C in bth
%                         critical event basket. If in a critical event basket (forward/backward) 
%                         an alarm (say A) gets actiavted more than one time, then for calculating 
%                         time difference between A and the critical event, always consider 
%                         only the earliest (for backward) or latest (for forward) A

global UID no_uaid time_vec ic u_UID
%%
Alarm_UIDc=find(u_UID==Alarm_UID);

acti_time_idx=find(UID==Alarm_UID); 

tot_no_slice = length(acti_time_idx); % Total number of occurance of the trip alarm

% acti_time_idx=ic(acti_time_idx);

prev_stp_time=0;

if tot_no_slice>=ocr_thr   
    
    out_mat=zeros(tot_no_slice,no_uaid);
    del_t_mat=(0*slice_len)*ones(tot_no_slice,no_uaid);

    for i=1:tot_no_slice
            
         if dir_anlys==-1
            % Backward Analysis
                
             stp_time=time_vec(acti_time_idx(i));
             str_time=stp_time-(slice_len*del_sec);
             if str_time>prev_stp_time
                idx=find(time_vec>str_time & time_vec<=stp_time);
             else
                idx=find(time_vec>prev_stp_time & time_vec<=stp_time);
              end
                prev_stp_time=stp_time;
         else
            % Forward Analysis
             str_time=time_vec(acti_time_idx(i));
             if i<tot_no_slice
                next_str_time=time_vec(acti_time_idx(i+1));
             else
                next_str_time=time_vec(end);
             end
             stp_time=str_time+(slice_len*del_sec);
             if stp_time<next_str_time
                idx=find(time_vec>=str_time & time_vec<stp_time);
             else
                idx=find(time_vec>=str_time & time_vec<next_str_time);
             end
         end
            

         if ~isempty(idx)
              
%              str_idx=idx(1);
%              stp_idx=idx(end);
% 
%              acti_time_idx0=find(strcmp(AlarmC(str_idx:stp_idx),key_word));
%                 %acti_time_idx0=find(strcmp(AlarmC(str_idx:stp_idx),'activate'));
%              if ~isempty(acti_time_idx0)                  
                acti_alaram_id=ic(idx);
 
                acti_alaram_start_time=time_vec(idx) ;
                    
                if dir_anlys==-1
                   del_t_sec=(stp_time-acti_alaram_start_time)./del_sec; % For Backward Analysis
                else
                   del_t_sec=-(str_time-acti_alaram_start_time)./del_sec; % For Forward Analysis
                end

                for j=1:length(acti_alaram_id)
                    out_mat(i,acti_alaram_id(j))=out_mat(i,acti_alaram_id(j))+1;
                    del_t_mat(i,acti_alaram_id(j))=max(del_t_mat(i,acti_alaram_id(j)),del_t_sec(j));
                end
%              end
         end
    end
        org_out_mat=out_mat;
        out_mat(out_mat>1)=1; % Even if same alarm got activated in a given time window more than one time, it will still be counted as one
        Row_sum_out_mat=sum(out_mat,1);
        Row_sum_org_out_mat=sum(org_out_mat,1);
        Row_sum_out_mat(Alarm_UIDc)=0;
        Row_sum_org_out_mat(Alarm_UIDc)=0;
else
    Row_sum_org_out_mat=0;
    Row_sum_out_mat=0;
    del_t_mat=0;
end     