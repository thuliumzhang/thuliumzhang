function qsc=ReadQSC(file)
fid=fopen(file);
i=1;
qsc=[];
while ~feof(fid)
    tline=fgetl(fid);
    disp(tline);
    qsc{i}=tline;
    i=i+1; 
end
fclose(fid);
end


%读取qsc



    


