clear all, 
clc;
% Load KL distances
clear all;
clc;
files = dir('*.xlsx');
i=1;
for file = files'
    Table = readtable(file.name,'Sheet',1); 
    ColHeader{i,:} = Table.Properties.VariableNames;
    i = i+1;
end
CommonColHeader = ColHeader{1,1};
for j= 1:10
    CommonColHeader= intersect(CommonColHeader, ColHeader{j,1});
end

for file = files'
    clear Table_new;
    Table = readtable(file.name,'Sheet',1); 
    ColHeader_temp =   Table.Properties.VariableNames;
    [rows vars] = size(ColHeader_temp);
    k=1;
    
    for j = 1: vars
        if ismember(ColHeader_temp(:,j),  CommonColHeader);
            ColHeader_new(:,k) =ColHeader_temp(:,j); 
            Table_new(:,k) = Table(:,j);
            k = k+1;
        end
    end
    Table_new.Properties.VariableNames =ColHeader_new;
%     Table_new = table2cell(Table_new);
%     Table_new = cell2mat(Table_new);
    % Write new data
    % Wrtie table as text is faster (order of 5 minutes)
    s1 = cellstr(file.name) ;
    k = s1{1};
    name = genvarname(k);     
    l1 = strfind(name,'All');
    l2 =strfind(name,'IRB');
    name1 = name(1,l1+4:l2-2);    
    writetable(Table_new,name1,'FileType','text')
    
%    writetable(Table_new,file.name,'sheet',4,'FileType','spreadsheet')
%     stat_print = fullfile('C:\Users\INSAV3\Predictive Analytics\DataSets\ETFA-Data', file.name);
%     xlswrite(stat_print, ColHeader_new,'Raw_data_new','A1');      
%     xlswrite(stat_print, Table_new,'Raw_data_new','A2'); 
    
end
 