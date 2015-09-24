function [tot_no_slice, Reduced_Sorted_Id, Reduced_Conf, mean_del_t, std_del_t, max_del_t, min_del_t]=CEA_func(CE_UID,slice_len,del_sec,ocr_thr,conf_thrs,anls_dir,withRevConfi)
 global out_mat_full     
        [tot_no_slice, Row_sum_out_mat, del_t_mat]=find_out_mat_trip_alarm(CE_UID,slice_len,del_sec,ocr_thr,anls_dir);
%        Num_Occurances_Global(uid_trip(ii))=tot_no_slice;
%        Out_Mat_Master(uid_trip(ii),:)=Row_sum_out_mat;
%        del_t_mat_global{1,uid_trip(ii)}=del_t_mat;
%     else
%        tot_no_slice=Num_Occurances_Global(uid_trip(ii));
%        Row_sum_out_mat=Out_Mat_Master(uid_trip(ii),:);
%        del_t_mat=del_t_mat_global{1,uid_trip(ii)};
%     end
       
         
%         acti_time_idx=find(strcmp(AlarmC,'New') & UID==uid_trip(ii)); % Here, 4303 is the unique id of trip alaram. Change it accordingly if you want analyse other trip alarms
% 
%     tot_no_slice = length(acti_time_idx); % Total number of occurance of the trip alarm
    
%     Trip_Alarms=uCA(uid_trip(ii),:);
%     
%     Num_occurance(ii,1)= tot_no_slice;
    
%     Results_All{ii+1,1}=uid_trip(ii);
%     Results_All(ii+1,[2 3])=uCA(uid_trip(ii),:);
%     Results_All{ii+1,4}=tot_no_slice;
        flg=1;
    
        if tot_no_slice>=ocr_thr
    
%     if tot_no_slice>=1
% 
%         out_mat=zeros(tot_no_slice,no_uaid);
%         del_t_mat=(0*slice_len)*ones(tot_no_slice,no_uaid);
% 
% %         bcount=0;
% %         Basket=cell(size(all_data));
%         for i=1:tot_no_slice
%             
%             % Backward Analysis
% %             stp_time=Trip_event_data{acti_time_idx(i)+1,2};
% %             str_time=stp_time-(slice_len*del_sec);
% %             idx=find(time_vec>=str_time & time_vec<stp_time);
%             
%             % Forward Analysis
%             str_time=Trip_event_data{acti_time_idx(i)+1,2};
%             stp_time=str_time+(slice_len*del_sec);
%             idx=find(time_vec>str_time & time_vec<=stp_time);
%             
% %             idx=find(time_vec>str_time & time_vec<=stp_time);
%             if ~isempty(idx)
% %                 bcount=bcount+1;
% %                 
% %                 Basket{bcount,1}=['Basket#' num2str(i)];
% %                 
% %                 if bcount==1
% %                     bcount=bcount+1;
% %                     Basket(bcount,:)=all_data(1,:);
% %                 end
% %                     
% %                 no_events=length(idx);
%                
%                 str_idx=idx(1)+1;
%                 stp_idx=idx(end)+1;
% %                 Basket(bcount+1:bcount+no_events,2)=cellstr(datestr(cell2mat(all_data(str_idx:stp_idx,2))+datenum(1900,1,1,0,0,0)-2));
% %                 Basket(bcount+1:bcount+no_events,4)=cellstr(datestr(cell2mat(all_data(str_idx:stp_idx,4))+datenum(1900,1,1,0,0,0)-2));
% %                 Basket(bcount+1:bcount+no_events,16)=cellstr(datestr(cell2mat(all_data(str_idx:stp_idx,16))+datenum(1900,1,1,0,0,0)-2));
% %                 Basket(bcount+1:bcount+no_events,[1 3:15 17:end])=all_data(str_idx:stp_idx,[1 3:15 17:end]);
% %                 bcount=bcount+no_events;
%                 
%                 acti_time_idx0=find(strcmp(all_data(str_idx:stp_idx,18),'New'));
%                 if ~isempty(acti_time_idx0)
%                     acti_alaram_id=cell2mat(all_data((str_idx-1)+acti_time_idx0,28));
%                     acti_alaram_start_time=cell2mat(all_data((str_idx-1)+acti_time_idx0,2));
% %                     del_t_sec=(stp_time-acti_alaram_start_time)./del_sec; % For Backward Analysis
%                     del_t_sec=-(str_time-acti_alaram_start_time)./del_sec; % For Forward Analysis
% 
%                     for j=1:length(acti_alaram_id)
%                         out_mat(i,acti_alaram_id(j))=out_mat(i,acti_alaram_id(j))+1;
%                         del_t_mat(i,acti_alaram_id(j))=max(del_t_mat(i,acti_alaram_id(j)),del_t_sec(j));
%                     end
%                 end
%             end
% %     str_time=stp_time;
%         end
% %         emptyCells = cellfun('isempty', Basket); 
% %         Basket(all(emptyCells,2),:) = [];
% %         
% %         xlswrite(['Time_Slice_Basket_UID#' num2str(uid_trip(ii)) '.xlsx'],Basket);
%         
%         out_mat(out_mat>1)=1; % Even if same alarm got activated in a given time window more than one time, it will still be counted as one
%         Row_sum_out_mat=sum(out_mat,1);
            [Sorted_sum,Sorted_Id]=sort(Row_sum_out_mat,'descend');% First few elements of "Sorted_Id" are the unique ID of the alarms that occur often with the given trip alarm
                                                   % "Sorted_sum" is the total number of occurance of the other alarms that occur often with the given trip alarm

            Fr_sum=Sorted_sum./tot_no_slice;
            Fr_cut_off=conf_thrs;

            Imp_Idx=find(Fr_sum>=Fr_cut_off);

            if ~isempty(Imp_Idx)

                Reduced_Fr_sum=Fr_sum(Imp_Idx);

                Reduced_Sorted_Id=Sorted_Id(Imp_Idx);
%             Asso_Alarms=uCA(Reduced_Sorted_Id,:);
    
%             Avg_del_t=zeros(1,length(Reduced_Sorted_Id));
%             min_del_t=Avg_del_t;
%             max_del_t=Avg_del_t;
%             std_del_t=Avg_del_t;
            
%             No_Asso_Alarms=min(3,length(Reduced_Sorted_Id));
                No_Asso_Alarms=length(Reduced_Sorted_Id);
              
%             Associated_Alarms_and_Trip_Alarm=[Reduced_Sorted_Id uid_trip(ii)];
%             
%             sub_mat_int_all=out_mat_full(:, Associated_Alarms_and_Trip_Alarm);
%             sub_mat_int=out_mat_full(:,Reduced_Sorted_Id);
%             full_count=sum(prod(sub_mat_int_all,2)>0);
%             pr_count=sum(prod(sub_mat_int,2)>0);
%             
%             confi=100*(full_count/pr_count);
%             
%             Results_All{ii+1,5}=confi;
            
%             col_no=5;

%             col_no=4;
              if withRevConfi==1
%                   out_mat_full=generic_time_slicing(slice_len,del_sec);
                  Conf_Act=zeros(No_Asso_Alarms,1);
                  for jj=1:No_Asso_Alarms
%                 del_t_col=del_t_mat(:,Reduced_Sorted_Id(jj));
%                 del_t_col_r=del_t_col(del_t_col~=(0*slice_len));
% %                 figure(jj+1);plot(del_t_col_r);
% %                 xlabel('Occurance#');
% %                 ylabel('Delta T in sec');
%                 col_no=col_no+1;
%                 Results_All{ii+1,col_no}=Reduced_Sorted_Id(jj);
%                 col_no=col_no+2;
%                 Results_All(ii+1,[col_no-1 col_no])=uCA(Reduced_Sorted_Id(jj),:);
%                 col_no=col_no+1;
                
%                 Associated_Alarms_and_Trip_Alarm=[Reduced_Sorted_Id(jj) uid_trip(ii)];
            
                    sub_mat_int_both=out_mat_full(:, [Reduced_Sorted_Id(jj) CE_UID]);
                    sub_mat_int=out_mat_full(:,Reduced_Sorted_Id(jj));
                    full_count=sum(prod(sub_mat_int_both,2)>0);
                    pr_count=sum(sub_mat_int>0);
                    rev_confi=(full_count/pr_count);
                
%                 if Num_Occurances_Global(Reduced_Sorted_Id(jj))==0
%                     [tot_no_ocr, Row_sum_out_mat1]=find_out_mat_alarm(Reduced_Sorted_Id(jj),slice_len,del_sec,1);
%                     Num_Occurances_Global(Reduced_Sorted_Id(jj))=tot_no_ocr;
%                     Out_Mat_Master(Reduced_Sorted_Id(jj),:)=Row_sum_out_mat1;
% %                     del_t_mat_global{1,uid_trip(ii)}=del_t_mat;
%                 else
%                     tot_no_ocr=Num_Occurances_Global(Reduced_Sorted_Id(jj));
%                     Row_sum_out_mat1=Out_Mat_Master(Reduced_Sorted_Id(jj),:);
% %                     del_t_mat=del_t_mat_global{1,uid_trip(ii)};
%                 end
%                 rev_confi=Row_sum_out_mat1(uid_trip(ii))/tot_no_ocr;

                    Conf_Act(jj)=Reduced_Fr_sum(jj)*rev_confi;
%                 Results_All{ii+1,col_no}=Reduced_Fr_sum(jj)*rev_confi*100;
%                 col_no=col_no+1;
%                 Results_All{ii+1,col_no}=mean(del_t_col_r);
%                 col_no=col_no+1;
%                 Results_All{ii+1,col_no}=std(del_t_col_r);
%                 col_no=col_no+1;
%                 Results_All{ii+1,col_no}=max(del_t_col_r);
%                 col_no=col_no+1;
%                 Results_All{ii+1,col_no}=min(del_t_col_r);
%                 min_del_t(1,jj)=min(del_t_col_r);
%                 max_del_t(1,jj)=max(del_t_col_r);
%                 std_del_t(1,jj)=std(del_t_col_r);
        
                  end
                  [Sorted_Conf,Sorted_Id]=sort(Conf_Act,'descend');% First few elements of "Sorted_Id" are the unique ID of the alarms that occur often with the given trip alarm
                                                   % "Sorted_sum" is the total number of occurance of the other alarms that occur often with the given trip alarm
                  Final_Sorted_Id=Reduced_Sorted_Id(Sorted_Id);
            
                  Imp_Idx=find(Sorted_Conf>=Fr_cut_off);

                  if ~isempty(Imp_Idx)

                    Reduced_Conf=Sorted_Conf(Imp_Idx)*100;

                    Reduced_Sorted_Id=Final_Sorted_Id(Imp_Idx);
                  else
                      flg=0;
                  end
              else
                  Reduced_Conf = Reduced_Fr_sum*100;
              end
            else
                flg=0;
            end
        else
            flg=0;
        end
%             Asso_Alarms=uCA(Reduced_Sorted_Id,:);
    
%             Avg_del_t=zeros(1,length(Reduced_Sorted_Id));
%             min_del_t=Avg_del_t;
%             max_del_t=Avg_del_t;
%             std_del_t=Avg_del_t;
            
%             No_Asso_Alarms=min(3,length(Reduced_Sorted_Id));
       if flg==1
          No_Asso_Alarms=length(Reduced_Sorted_Id);
          mean_del_t=zeros(1,No_Asso_Alarms);
          min_del_t=mean_del_t;
          max_del_t=mean_del_t;
          std_del_t=mean_del_t;
              
%             Associated_Alarms_and_Trip_Alarm=[Reduced_Sorted_Id uid_trip(ii)];
%             
%             sub_mat_int_all=out_mat_full(:, Associated_Alarms_and_Trip_Alarm);
%             sub_mat_int=out_mat_full(:,Reduced_Sorted_Id);
%             full_count=sum(prod(sub_mat_int_all,2)>0);
%             pr_count=sum(prod(sub_mat_int,2)>0);
%             
%             confi=100*(full_count/pr_count);
%             
%             Results_All{ii+1,5}=confi;
            
%             col_no=5;

%                 col_no=4;
               
            for jj=1:No_Asso_Alarms
                del_t_col=del_t_mat(:,Reduced_Sorted_Id(jj));
                del_t_col_r=del_t_col(del_t_col~=(0*slice_len));
%                 figure(jj+1);plot(del_t_col_r);
%                 xlabel('Occurance#');
%                 ylabel('Delta T in sec');
%                     col_no=col_no+1;
%                     Results_All{ii+1,col_no}=Reduced_Final_Sorted_Id(jj);
%                     col_no=col_no+2;
%                     Results_All(ii+1,[col_no-1 col_no])=uCA(Reduced_Final_Sorted_Id(jj),:);
%                     col_no=col_no+1;
%                 
%                     
% 
%                     Results_All{ii+1,col_no}=Reduced_Conf(jj)*100;
%                     col_no=col_no+1;
%                     Results_All{ii+1,col_no}=mean(del_t_col_r);
%                     col_no=col_no+1;
%                     Results_All{ii+1,col_no}=std(del_t_col_r);
%                     col_no=col_no+1;
%                     Results_All{ii+1,col_no}=max(del_t_col_r);
%                     col_no=col_no+1;
%                     Results_All{ii+1,col_no}=min(del_t_col_r);
                    mean_del_t(1,jj)=mean(del_t_col_r);
                    min_del_t(1,jj)=min(del_t_col_r);
                    max_del_t(1,jj)=max(del_t_col_r);
                    std_del_t(1,jj)=std(del_t_col_r);
        
            end
       else
           disp('No Pattern found at current cut off fraction')
           Reduced_Sorted_Id=[];
           Reduced_Conf=[];
           mean_del_t=[];
           min_del_t=[];
           max_del_t=[];
           std_del_t=[];
       end
            
%             Support{ii,1}=Reduced_Fr_sum;
%             Ids{ii,1}=Reduced_Sorted_Id;
%             MeanTime{ii,1}=Avg_del_t;
%             MaxTime{ii,1}=max_del_t;
%             MinTime{ii,1}=min_del_t;
%             StdTime{ii,1}=std_del_t;
