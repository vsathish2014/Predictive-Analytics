function [tot_no_slice, Final_Sorted_Id, Reduced_Conf, Reduced_Cooccur, mean_del_t, med_del_t, std_del_t, max_del_t, min_del_t]=CEA_func_new(CE_UID,slice_len,del_sec,ocr_thr,conf_thrs,anls_dir)
% This function perfroms the CEA analysis for given critical event.
% It provides Number of occurances of the CE in the data, UID of all
% the associated alarms with confidence & co-occurance more than or equal to
% specifed by the users. Average, Std. dev., Max & min of time
% differences between the Associated alarm and the given Critical Event.
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

% Inputs:
% CE_UID............. Unique Alarm ID of a critical event
% slice_len.......... Length of the equal time slice basket in sec
% del_sec............ Value of 1 sec in MATLAB (as number)
% ocr_thr............ Mininum Number of occurance of a Critial Event to be considered in CEA
% conf_thrs.......... Minimum Confidence and co-occurance of the associated alarms
% anls_dir........... Direction of CEA, use -1 for past/backword analysis. & +1 for future/forward analysis
% key_word........... A string which indiates start/on of an alarm/event in
%                     the data. When Alram State of an alarm is equal to the
%                     string in "key_word" indiates that start/on of that alarm
% Outputs:
% tot_no_slice....... Total number of occurances of the CE in the entire even/alarm log data, 
% Final_Sorted_Id.... UID of all the associated alarms with confidence & co-occurance more than or equal to
%                     specifed by the users in "conf_thrs".
% Reduced_Conf....... Confidence in percentage of all the associated alarms with confidence & co-occurance more than or equal to
%                     specifed by the users in "conf_thrs". 
% Reduced_Cooccur.....Co-occurance in percentage of all the associated alarms with confidence & co-occurance more than or equal to
%                     specifed by the users in "conf_thrs".  
% mean_del_t..........Average of time differences between the Associated alarms and the given Critical Event
% std_del_t...........Standard deviation of time differences between the Associated alarms and the given Critical Event
% max_del_t...........Maximum of time differences between the Associated alarms and the given Critical Event
% min_del_t...........Minimum of time differences between the Associated alarms and the given Critical Event
%
global Row_sum_out_mat_full 
%%
[tot_no_slice, Row_sum_out_mat, Row_sum_org_out_mat, del_t_mat]=find_out_mat_trip_alarm_new(CE_UID,slice_len,del_sec,ocr_thr,anls_dir);

flg=1;
    
if tot_no_slice>=ocr_thr
   [Sorted_sum,Sorted_Id]=sort(Row_sum_out_mat,'descend');% First few elements of "Sorted_Id" are the unique ID of the assocaited alarms that occur often with the given critical event
                                       % "Sorted_sum" is the total number of occurance of the asscoated alarms that occur often with the given critical event
   Fr_sum=Sorted_sum./tot_no_slice;
   
   Fr_cut_off=conf_thrs;

   Imp_Idx=find(Fr_sum>=Fr_cut_off);

   if ~isempty(Imp_Idx)

       Reduced_Fr_sum=Fr_sum(Imp_Idx);

       Reduced_Sorted_Id=Sorted_Id(Imp_Idx);
                
       co_occur_fr=Row_sum_out_mat(Reduced_Sorted_Id)./(Row_sum_out_mat_full(Reduced_Sorted_Id)-Row_sum_org_out_mat(Reduced_Sorted_Id)+Row_sum_out_mat(Reduced_Sorted_Id));
       co_occur_fr(co_occur_fr>1)=1;
                
       f_Imp_Idx=find(co_occur_fr>=Fr_cut_off);
                
       if ~isempty(f_Imp_Idx)

           Reduced_Cooccur=co_occur_fr(f_Imp_Idx)*100;

           Final_Sorted_Id=Reduced_Sorted_Id(f_Imp_Idx);
                    
           Reduced_Conf=Reduced_Fr_sum(f_Imp_Idx)*100;
       else
           flg=0;
       end

   else
       flg=0;
   end
else
    flg=0;
end

if flg==1
    No_Asso_Alarms=length(Final_Sorted_Id);
    mean_del_t=zeros(1,No_Asso_Alarms);
    min_del_t=mean_del_t;
    max_del_t=mean_del_t;
    std_del_t=mean_del_t;
    med_del_t=mean_del_t;         
    for jj=1:No_Asso_Alarms
           del_t_col=del_t_mat(:,Final_Sorted_Id(jj));
           No_cooccur_baskets=Row_sum_out_mat(Final_Sorted_Id(jj));
           del_t_col_r=zeros(No_cooccur_baskets,1);
           del_t_col_r1=del_t_col(del_t_col~=(0*slice_len));
           if ~isempty(del_t_col_r)
               del_t_col_r(1:length(del_t_col_r1),1)=del_t_col_r1;
           end

            mean_del_t(1,jj)=mean(del_t_col_r);
            med_del_t(1,jj)=median(del_t_col_r);
            min_del_t(1,jj)=min(del_t_col_r);
            max_del_t(1,jj)=max(del_t_col_r);
            std_del_t(1,jj)=std(del_t_col_r);
        
    end
else
%     disp('No Pattern found at current cut off fraction')
    Final_Sorted_Id=[];
    Reduced_Conf=[];
    Reduced_Cooccur=[];
    mean_del_t=[];
    min_del_t=[];
    max_del_t=[];
    std_del_t=[];
    med_del_t=[];
end