load('/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/pts_collected/pos_neg/7400.mat','pos','neg');
for i = 1:13000
    if ~isempty(pos(i).cdata)
        X = pos(i).cdata(:,1);
        Y = pos(i).cdata(:,2);
        [sortedX, sortIndex] = sort(X);
        sortedY = Y(sortIndex);
        pos(i).cdata = [sortedX sortedY];
    end
    if ~isempty(neg(i).cdata)
        X = neg(i).cdata(:,1);
        Y = neg(i).cdata(:,2);
        [sortedX, sortIndex] = sort(X);
        sortedY = Y(sortIndex);
        neg(i).cdata = [sortedX sortedY];
    end
end
save('/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/pts_collected/pos_neg/7400_sorted.mat','pos','neg');