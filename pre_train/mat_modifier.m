% This program is used to merge the coordinates of two classes in a struct

load '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/pts_collected/7400_6c.mat'
pts1(13000).cdata = [];
pts2(13000).cdata = [];
for i = 1:13000
    pts1(i).cdata = [pts_neg(i).cdata; pts_neg_b(i).cdata];
    pts2(i).cdata = [pts_nuc(i).cdata; pts_nucb(i).cdata];
end
count1 = 0;
count_neg = 0;
count_neg_b = 0;
count2 = 0;
count_nuc = 0;
count_nucb = 0;
for i = 1:13000
    count1 = count1 + size(pts1(i).cdata,1);
    count_neg = count_neg + size(pts_neg(i).cdata,1);
    count_neg_b = count_neg_b + size(pts_neg_b(i).cdata,1);
    count2 = count2 + size(pts2(i).cdata,1);
    count_nuc = count_nuc + size(pts_nuc(i).cdata,1);
    count_nucb = count_nucb + size(pts_nucb(i).cdata,1);
end
pts_neg = pts1;
pts_nuc = pts2;
clear pts1 pts2 pts_nucb pts_neg_b;
save('/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/pts_collected/pos_neg/7400_4c.mat','pts_pos','pts_neg','pts_nuc','pts_pos_o','k');