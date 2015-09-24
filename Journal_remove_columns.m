clc;
clear;
 i = 1; %file number
files = dir('*.xlsx');
for file = files'
   
    %k = strcat('data','_',s1);
  
    [num1 txt1 raw1] = xlsread(file.name,'dist_data_Trg','A1:AJ41');
    [num2 txt2 raw2] = xlsread(file.name,'dist_data_Test','A1:AJ21');
    
    [num3 txt3 raw3] = xlsread(file.name,'diff_data_Trg','A1:AJ41');
    [num4 txt4 raw4] = xlsread(file.name,'diff_data_Test','A1:AJ21');
    cols2remove=[2 5 8 11 14 17 19:23 25:29 31:35];
    
    %Print the file to excel  
    
    txt1(cols2remove) =[];
    num1(:,cols2remove) =[];
    
    txt2(cols2remove) =[];
    num2(:,cols2remove) =[];
    
    txt3(cols2remove) =[];
    num3(:,cols2remove) =[];
    
    txt4(cols2remove) =[];
    num4(:,cols2remove) =[];
    
    data_dist = cat(1,num1,num2);
     
    
     empty = repmat(' ',[41 21]);

    stat_print1 = fullfile('C:\Users\insav3\Predictive Analytics\DataSets\GB 60day -before failure\Journal_removeCols',...
                           file.name);
    xlswrite(stat_print1, txt1,'dist_data_Trg','A1');       
    xlswrite(stat_print1,num1,'dist_data_Trg','A2'); 
    xlswrite(stat_print1,empty,'dist_data_Trg','P1'); 
    
    xlswrite(stat_print1, txt2,'dist_data_Test','A1');       
    xlswrite(stat_print1,num2,'dist_data_Test','A2'); 
    xlswrite(stat_print1,empty,'dist_data_Test','P1'); 
    
    xlswrite(stat_print1, txt3,'diff_data_Trg','A1');       
    xlswrite(stat_print1,num3,'diff_data_Trg','A2'); 
    xlswrite(stat_print1,empty,'diff_data_Trg','P1'); 
    
    xlswrite(stat_print1, txt4,'diff_data_Test','A1');       
    xlswrite(stat_print1,num4,'diff_data_Test','A2'); 
    xlswrite(stat_print1,empty,'diff_data_Test','P1'); 
    
    
    stat_print2 = fullfile('C:\Users\insav3\Predictive Analytics\DataSets\GB 60day -before failure\Journal_ExploratoryAnalysis',...
                           'All_Robots_Data.xlsx');
                       
     str = strcat('Dataset', num2str(i));
    xlswrite(stat_print2, txt1,str,'A1');       
    xlswrite(stat_print2,data_dist,str,'A2'); 
    i = i+1;
     
    
end