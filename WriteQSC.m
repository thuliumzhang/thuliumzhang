function newQSC=WriteQSC(file,content)
fid=fopen(file,'w');
for j=1:length(content)
    str=char(content(j));
    formatSpec='%s\n';
    fprintf(fid,formatSpec,str);
end
fclose(fid);
newQSC=1;
end