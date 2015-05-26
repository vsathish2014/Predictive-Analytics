clear all;
clc;
files = dir('*.xlsx');
for file = files'

    %k = strcat('data','_',s1);
    data_KL_Trg = readtable(file.name,'Sheet',4); 
    data_KL_Trg = table2cell(data_KL_Trg);
    data_KL_Trg = cell2mat(data_KL_Trg);
    
    data_KL_Test = readtable(file.name,'Sheet',5); 
    data_KL_Test = table2cell(data_KL_Test);
    data_KL_Test = cell2mat(data_KL_Test);
    
    data_R_KL_Trg = readtable(file.name,'Sheet',6); 
    data_R_KL_Trg = table2cell(data_R_KL_Trg);
    data_R_KL_Trg = cell2mat(data_R_KL_Trg);
    
    data_R_KL_Test = readtable(file.name,'Sheet',7); 
    data_R_KL_Test = table2cell(data_R_KL_Test);
    data_R_KL_Test = cell2mat(data_R_KL_Test);
    
    
    data_C_KL_Trg = readtable(file.name,'Sheet',8); 
    data_C_KL_Trg = table2cell(data_C_KL_Trg);
    data_C_KL_Trg = cell2mat(data_C_KL_Trg);
    
    data_C_KL_Test = readtable(file.name,'Sheet',9); 
    data_C_KL_Test = table2cell(data_C_KL_Test);
    data_C_KL_Test = cell2mat(data_C_KL_Test);
    
    %strcat('data','_',k) = data;
    s1 = cellstr(file.name) ;
    k = s1{1};
    name = genvarname(k);     
    l1 = strfind(name,'KL');
    l2 =strfind(name,'IRB');
    name1 = name(1,l1+3:l2-2);
    dsName_KL_Trg = strcat(name1,'_KL','_Trg');
    dsName_KL_Test = strcat(name1,'_KL','_Test');
    dstName_R_KL_Trg = strcat(name1,'_R_KL','_Trg');
    dsName_R_KL_Test = strcat(name1,'_R_KL','_Test');
    dsName_C_KL_Trg = strcat(name1,'_C_KL','_Trg');
    dsName_C_KL_Test = strcat(name1,'_C_KL','_Test');
    
    dsName_KL_Trg = genvarname(dsName_KL_Trg);
    dsName_KL_Test = genvarname(dsName_KL_Test);
    dstName_R_KL_Trg = genvarname(dstName_R_KL_Trg);
    dsName_R_KL_Test = genvarname(dsName_R_KL_Test);
    dsName_C_KL_Trg = genvarname(dsName_C_KL_Trg);
    dsName_C_KL_Test = genvarname(dsName_C_KL_Test);
     
    eval([dsName_KL_Trg,'=data_KL_Trg;']);
    eval([dsName_KL_Test,'=data_KL_Test;']);
    eval([dstName_R_KL_Trg,'=data_R_KL_Trg;']);
    eval([dsName_R_KL_Test,'=data_R_KL_Test;']);
    eval([dsName_C_KL_Trg,'=data_C_KL_Trg;']);
    eval([dsName_C_KL_Test,'=data_C_KL_Test;']);
 
end
