[file,path]=uigetfile('*.qsc','请选择要模拟的qsc文件');
stem3='D:\结构分析表征\QSTEM\stem3.exe';
fullPath=strcat(path,file);
nowPath=pwd;
temtype=listdlg('name','请选择选区的范围标准','liststring',{'NCells','Box'},'OKstring','确定','cancelstring','取消','listsize',[300,100],'selectionmode','simple');
Direction=listdlg('name','请选择选区的范围标准','liststring',{'X','Y','Z'},'OKstring','确定','cancelstring','取消','listsize',[300,100],'selectionmode','simple');
qsc=ReadQSC(fullPath);
WriteQSC(strcat(path,'old.qsc'),qsc);
    %这里备份旧的QSC,
    
if temtype==1
    for i=1:100
    folder=qsc{68}(10:end-1);
    switch Direction
        case 1
            qsc{11}=strcat('NCELLX: ',num2str(i));
        case 2
            qsc{12}=strcat('NCELLY: ',num2str(i));
        case 3
            qsc{13}=strcat('NCELLZ: ',num2str(i));
    end
    qsc{18}=strcat('slices: ',num2str(i),'		% number of different slices per slab in z-direction');
    WriteQSC(strcat(path,file),qsc);
    cd(path);
    %中间这两个cd是为了把输出的文件存回原来的文件夹，但是函数都在matlab文件夹中，所以需要反复横跳
    cmd=strcat(stem3,32,fullPath);
    system(cmd)
    renamer=['!rename' 32 path '\' folder '\diff.img' 32 num2str(i) '.img'];
    eval(renamer);
    %上一句是给文件改名，中间的路径需要灵活变动
    cd(nowPath);
    end
    %第一种情况，按照晶胞数目逐渐增加，这种情况会出现晶体模型不对称。
    
elseif temtype==2
        
    [x, y, z, alpha, beta, gamma]=getCFGfromQSC(path,file);
    %从qsc关联的cfg文件中读取晶胞参数。
    
    cube=strsplit(qsc{14});
    cube{2}=num2str(10*x);
    cube{3}=num2str(10*y);
    %这里默认xy都是十倍晶胞大小了！必要时要进行调整！
    cube{4}=num2str(z);
    qsc{14}=strcat(cube{1},32,cube{2},32,cube{3},32,cube{4});
    WriteQSC(strcat(path,file),qsc);
    %取消了之前的向上取整，这里xyz都是整数倍
    
    for i=1:100
    qsc=ReadQSC(fullPath);
    folder=qsc{69}(10:end-1);
    cube=strsplit(qsc{14});
    zLength=str2double(cube{4});
    if i~=1
        zLength=zLength+z;
    end
    cube{4}=num2str(zLength);
    qsc{14}=strcat(cube{1},32,cube{2},32,cube{3},32,cube{4});
    qsc{19}=strcat('slices: ',num2str((2*i+1)),'		% number of different slices per slab in z-direction');
    %层数与晶胞种类相匹配，最好是一层原子对应一个slice
    WriteQSC(strcat(path,file),qsc);
    cd(path);
    %中间这两个cd是为了把输出的文件存回原来的文件夹，但是函数都在matlab文件夹中，所以需要反复横跳
    cmd=strcat(stem3,32,fullPath);
    system(cmd);
    renamer=['!rename' 32 path folder '\diff.img' 32 num2str(i) '.img'];
    eval(renamer);
    %上一句是给文件改名，中间的路径需要灵活变动
    cd(nowPath);
    end
    %第二种情况，用Box模式的数据，这种情况可以避免由于边界问题导致得到的衍射峰不对称。
end

fclose('all'); 
renamer=['!rename' 32 path file 32 file(1:end-4) 'end.qsc'];
eval(renamer);
renamer=['!rename' 32 path 'old.qsc' 32 file];
eval(renamer);
%最终把最后的文件输出成名字+end，最初的qsc恢复
    
    
