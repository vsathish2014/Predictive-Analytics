function [tot_no_slice, Row_sum_out_mat, del_t_mat]=find_out_mat_trip_alarm_new(Alarm_UID,slice_len,del_sec,ocr_thr,dir_anlys)
global AlarmC UID no_uaid time_vec

% del_sec=datenum(2014,1,1,6,10,2)-datenum(2014,1,1,6,10,1);


acti_time_idx=find(strcmp(AlarmC,'New') & UID==Alarm_UID); % Here, 4303 is the unique id of trip alaram. Change it accordingly if you want analyse other trip alarms

%acti_time_idx=find(strcmp(AlarmC,'activate') & UID==Alarm_UID); 

tot_no_slice = length(acti_time_idx); % Total number of occurance of the trip alarm

No_valid_baskets=tot_no_slice; 
if tot_no_slice>=ocr_thr   
    
    out_mat=zeros(tot_no_slice,no_uaid);
    del_t_mat=(0*slice_len)*ones(tot_no_slice,no_uaid);

%         bcount=0;
%         Basket=cell(size(all_data));
        for i=1:tot_no_slice
            
            if dir_anlys==-1
            % Backward Analysis
                stp_time=time_vec(acti_time_idx(i));
                str_time=stp_time-(slice_len*del_sec);
                idx=find(time_vec>=str_time & time_vec<stp_time);
            else
            % Forward Analysis
                str_time=time_vec(acti_time_idx(i));
                stp_time=str_time+(slice_len*del_sec);
                idx=find(time_vec>str_time & time_vec<=stp_time);
            end
            
%             idx=find(time_vec>str_time & time_vec<=stp_time);
            if ~isempty(idx)
%                 bcount=bcount+1;
%                 
%                 Basket{bcount,1}=['Basket#' num2str(i)];
%                 
%                 if bcount==1
%                     bcount=bcount+1;
%                     Basket(bcount,:)=all_data(1,:);
%                 end
%                     
%                 no_events=length(idx);
               
                str_idx=idx(1);
                stp_idx=idx(end);
%                 Basket(bcount+1:bcount+no_events,2)=cellstr(datestr(cell2mat(all_data(str_idx:stp_idx,2))+datenum(1900,1,1,0,0,0)-2));
%                 Basket(bcount+1:bcount+no_events,4)=cellstr(datestr(cell2mat(all_data(str_idx:stp_idx,4))+datenum(1900,1,1,0,0,0)-2));
%                 Basket(bcount+1:bcount+no_events,16)=cellstr(datestr(cell2mat(all_data(str_idx:stp_idx,16))+datenum(1900,1,1,0,0,0)-2));
%                 Basket(bcount+1:bcount+no_events,[1 3:15 17:end])=all_data(str_idx:stp_idx,[1 3:15 17:end]);
%                 bcount=bcount+no_events;
                
                acti_time_idx0=find(strcmp(AlarmC(str_idx:stp_idx),'New'));
                %acti_time_idx0=find(strcmp(AlarmC(str_idx:stp_idx),'activate'));
                if ~isempty(acti_time_idx0)
                    
                    
                                        
                    acti_alaram_id=UID((str_idx-1)+acti_time_idx0);
                    
                    if any(acti_alarm_id==Alarm_UID)
                        
                        No_valid_baskets=No_valid_basket-1;
                    else
                    
                        acti_alaram_start_time=time_vec((str_idx-1)+acti_time_idx0) ;
                    
                        if dir_anlys==-1
                            del_t_sec=(stp_time-acti_alaram_start_time)./del_sec; % For Backward Analysis
                        else
                            del_t_sec=-(str_time-acti_alaram_start_time)./del_sec; % For Forward Analysis
                        end

                        for j=1:length(acti_alaram_id)
                            out_mat(i,acti_alaram_id(j))=out_mat(i,acti_alaram_id(j))+1;
                            del_t_mat(i,acti_alaram_id(j))=max(del_t_mat(i,acti_alaram_id(j)),del_t_sec(j));
                        end
                    end
                end
            end
%     str_time=stp_time;
        end
        org_out_mat=out_mat;
        out_mat(out_mat>1)=1; % Even if same alarm got activated in a given time window more than one time, it will still be counted as one
        Row_sum_out_mat=sum(out_mat,1);
        Row_sum_org_out_mat=sum(org_out_mat,1);
else
    Row_sum_out_mat=0;
    del_t_mat=0;
end
%         emptyCells = cellfun('isempty', Basket); 
%         Basket(all(emptyCells,2),:) = [];
%         
%         xlswrite(['Time_Slice_Basket_UID#' num2str(uid_trip(ii)) '.xlsx'],Basket);
        
        