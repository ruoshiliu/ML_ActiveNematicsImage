% This program will merge all the 'mat' file under a directory into one
% single 'mat' file. It will be named after the last pts being collected.
% Note: after merging, the original mat file will be deleted, so please
% make sure you make copies of them before merging!!!

d=dir('/Users/ruoshiliu/Desktop/OneDrive/Github/ML_ActiveNematicsImage/pts_collected/*.mat');
nframes = 13000;
pos(nframes).cdata = [];
neg(nframes).cdata = [];
for i = 1:length(d)
    load(d(i).name);
    for j = 1:nframes
        if ~isempty(pts_neg(j).cdata)
            neg(j).cdata = pts_neg(j).cdata;
        end
        if ~isempty(pts_pos(j).cdata)
            pos(j).cdata = pts_pos(j).cdata;
        end
    end
    clear pts_neg pts_pos k;
end
delete '*.mat';
count = 0;
for i = 1:nframes
    if ~isempty(pos(i).cdata)
        count = count + 1;
    end
end
filename = count + ".mat";
name = '/Users/ruoshiliu/Desktop/OneDrive/Github/ML_ActiveNematicsImage/pts_collected/' + filename;
save(name,'pos','neg','count');
