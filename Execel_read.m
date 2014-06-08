Folder=cd('C:\ABB\4-DM\Data Analysis\FieldFailures');
 d = dir('*.xls');
N_File=numel(d);
e = actxserver ('Excel.Application');
        h=waitbar(0,'Progress...');
       for o = 1:N_File
          qs=numel(d)-o;
          clc;
      fprintf('Please wait %d second ',qs)
       fprintf(1,repmat('\n',1,1));
      waitbar(o/N_File,h);
      %     r = xlsread(d(o).name,2);
      cd(directory);
      ExcelWorkbook = e.workbooks.Open(fullfile(Folder,d(o).name));
      Sheet=ExcelWorkbook.Sheets.Item(2);
      Range=Sheet.UsedRange;
      r=cell2mat(Range.Value);
      ExcelWorkbook.Close;
      d=sprintf('r%d',o);
      assignin('base',d,r);
       end
      close all; 
       e.Quit;
      e.delete;