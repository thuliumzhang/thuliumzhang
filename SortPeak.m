function peakSort=SortPeak(peakMerged)
peakSort={[],[]};
numPeak=size(peakMerged,2);
for i=1:numPeak
    peak70=peakMerged(72,i);
    peak100=peakMerged(102,i);
    if peak70>peak100
        peakSort{1}=[peakSort{1} peakMerged(1,i)];
    else
        peakSort{2}=[peakSort{2} peakMerged(1,i)];
    end
end
end