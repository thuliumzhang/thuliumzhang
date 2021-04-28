path=uigetdir('请选择img文件所在的文件夹');
%选取img所在的文件夹


output=ReadimgGlobal(path);
%通过脚本批量读取img文件


peakOriginal=PeakSearch10(output);
%读取峰值


peakMerged=PeakAdjust(peakOriginal);
%将对称性相关的峰值合并
