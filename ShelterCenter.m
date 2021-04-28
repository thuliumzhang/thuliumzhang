function [output,output0]=ShelterCenter(path)
%这一函数的目的是调整衍射点的展示，把中心衍射点屏蔽掉，从而能够更好的观察其他衍射点
type=listdlg('name','是否需要将每个衍射点强度开方','liststring',{'是','否'},'OKstring','确定','cancelstring','取消','listsize',[300,100],'selectionmode','simple');
files=dir(strcat(path,'\*.img'));
lengthfiles=length(files);
output={};
ts={};
dxs={};
dys={};
%把输出结果放到一个output里，可以简化工作区
for i=1:lengthfiles
    newname=files(i).name(1:end-4);
    if ~isnan(str2double(newname))
        %这里不能用str2num，因为str2num('image')有惊喜
        [img_data,t,dx,dy]=binread2D(strcat(path,'\',files(i).name));
        %读取t,dx,dy是为了更改img文件的内容
        outputstr=strcat('output{',newname,'}=img_data;');
        eval(outputstr);
        tstr=strcat('ts{',newname,'}=t;');
        eval(tstr);
        dxstr=strcat('dxs{',newname,'}=dx;');
        eval(dxstr);
        dystr=strcat('dys{',newname,'}=dy;');
        eval(dystr);
    end
end
output0=output;
switch type
    case 2
        newpath=strcat(path,'\adjusted');
    case 1
        newpath=strcat(path,'\SquareAdjusted');
end
mkdir(newpath);
%在原目录下新建目录adjusted，放置挡住中心衍射斑的衍射图
for i=1:length(output0)
    [x,y]=size(output0{i});
    xm=ceil((x+1)/2);
    ym=ceil((y+1)/2);
    %这是选取中心衍射斑的位置
    output0{i}(xm,ym)=0;
    if type==1
        output0{i}=sqrt(output0{i});
    end
    newfile=strcat(newpath,'/',num2str(i),'.img');
    binwrite2D(output0{i},newfile,dxs{i},dys{i},ts{i});
end
fclose('all');    
end