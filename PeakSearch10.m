function peakOriginal=PeakSearch10(output)
h=-10:1:10;
k=-10:1:10;
m=157:10:357;
n=157:10:357;
peakOriginal=zeros(length(output)+2,numel(h)*numel(k)+1);
count=1;
for i=1:length(k)
    for j=1:length(h)
        peakOriginal(1,count+1)=h(j);
        peakOriginal(2,count+1)=k(i);
        count=count+1;
    end
end
%写表头

for i=1:length(output)
    peakOriginal(i+2,1)=i;
    outputx=strcat('midMatrix=output{',num2str(i),'}(m,n);');
    eval(outputx);
    lines=midMatrix(:)';
    peakOriginal(i+2,2:end)=lines;
end
peakOriginal=sortrows(peakOriginal,1);
end