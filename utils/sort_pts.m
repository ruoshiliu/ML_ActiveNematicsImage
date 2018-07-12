load('/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/pts_collected/7400_4c.mat');
for i = 1:13000
    if ~isempty(pts_pos(i).cdata)
        X = pts_pos(i).cdata(:,1);
        Y = pts_pos(i).cdata(:,2);
        [sortedX, sortIndex] = sort(X);
        sortedY = Y(sortIndex);
        pts_pos(i).cdata = [sortedX sortedY];
    end
    if ~isempty(pts_neg(i).cdata)
        X = pts_neg(i).cdata(:,1);
        Y = pts_neg(i).cdata(:,2);
        [sortedX, sortIndex] = sort(X);
        sortedY = Y(sortIndex);
        pts_neg(i).cdata = [sortedX sortedY];
    end
    if ~isempty(pts_pos_o(i).cdata)
        X = pts_pos_o(i).cdata(:,1);
        Y = pts_pos_o(i).cdata(:,2);
        [sortedX, sortIndex] = sort(X);
        sortedY = Y(sortIndex);
        pts_pos_o(i).cdata = [sortedX sortedY];
    end
    if ~isempty(pts_nuc(i).cdata)
        X = pts_nuc(i).cdata(:,1);
        Y = pts_nuc(i).cdata(:,2);
        [sortedX, sortIndex] = sort(X);
        sortedY = Y(sortIndex);
        pts_nuc(i).cdata = [sortedX sortedY];
    end
end
save('/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/pts_collected/7400_4c_sorted.mat','pts_pos','pts_neg','pts_nuc','pts_pos_o','k');