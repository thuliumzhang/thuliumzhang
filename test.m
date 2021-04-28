h=-10:1:10;
k=-10:1:10;
m=157:10:357;
n=157:10:357;
peaks=zeros(length(output)+2,numel(h)*numel(k));
count=1;

for i=1:length(k)
    for j=1:length(h)
        peaks(1,count+1)=h(j);
        peaks(2,count+1)=k(i);
        count=count+1;
    end
end

%写表头

for i=1:length(output)
    newnamex=files(i).name(1:end-4);
    peaks(i+2,1)=str2double(newnamex);
    outputx=strcat('midMatrix=output{',newnamex,'}(m,n)');
    eval(outputx);
    lines=midMatrix(:)';
    peaks(i+2,2:end)=lines;
end
peaks=sortrows(peaks,1);

%这一段是在读取文件中找到设定的峰值