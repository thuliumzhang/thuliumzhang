function output=ReadimgGlobal(path)
files=dir(strcat(path,'\*.img'));
lengthfiles=length(files);
output={};
%把输出结果放到一个output里，可以简化工作区
for i=1:lengthfiles
    newname=files(i).name(1:end-4);
    if ~isnan(str2double(newname))
        %这里不能用str2num，因为str2num('image')有惊喜
        img_data=binread2D(strcat(path,'\',files(i).name));
        outputstr=strcat('output{',newname,'}=img_data;');
        eval(outputstr);
    end
end
end