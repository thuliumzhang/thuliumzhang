function [x, y, z, alpha, beta, gamma]=getCFGfromQSC(path,file)
content=ReadQSC(strcat(path,file));
cfg=content{8}(11:end);
addpath(path)
if cfg(1)=='"'
    cfg=cfg(2:end-2);
else
    cfg=cfg(1:end-1);
end
cfgcontent=ReadQSC(cfg);
unitCell=zeros(3);
for i=3:11
    Mid=strsplit(cfgcontent{i});
    j=floor(i/3);
    k=mod(i,3)+1;
    unitCell(k,j)=str2double(Mid{3});
    %读取cfg中晶胞参数矩阵的数据，生成一个矩阵
end
X=unitCell(:,1);
Y=unitCell(:,2);
Z=unitCell(:,3);
x=norm(X);
y=norm(Y);
z=norm(Z);
alpha=acosd(dot(Y,Z)/(y*z));
beta=acosd(dot(X,Z)/(x*z));
gamma=acosd(dot(X,Y)/(x*y));
end
