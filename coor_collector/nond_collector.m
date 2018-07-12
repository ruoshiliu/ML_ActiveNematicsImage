v = VideoReader('/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/d400um.avi');
load '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/pts_collected/7400_4c_sorted.mat';
k = 0;

nframes = 7400;
pts_rand(nframes).cdata = [];


for k=1:nframes
    num_rand = 0;
    rand = [];
    while num_rand < 6
        [x,y] = randompointinellipse(327, 350, 367.495, 376.51, 0, 1);
        adjacent_pos = true;
        for q = 1:size(pts_pos(k).cdata,1)
            if abs(x - pts_pos(k).cdata(q,1)) <= 80 && abs(y - pts_pos(k).cdata(q,2)) <= 80
                adjacent_pos = false;
            end
        end
        adjacent_neg = true;
        for p = 1:size(pts_neg(k).cdata,1)
            if abs(x - pts_neg(k).cdata(p,1)) <= 80 && abs(y - pts_neg(k).cdata(p,2)) <= 80
                adjacent_neg = false;
            end
        end
        adjacent_pos_o = true;
        for p = 1:size(pts_pos_o(k).cdata,1)
            if abs(x - pts_pos_o(k).cdata(p,1)) <= 80 && abs(y - pts_pos_o(k).cdata(p,2)) <= 80
                adjacent_pos_o = false;
            end
        end
        adjacent_nuc = true;
        for p = 1:size(pts_nuc(k).cdata,1)
            if abs(x - pts_nuc(k).cdata(p,1)) <= 80 && abs(y - pts_nuc(k).cdata(p,2)) <= 80
                adjacent_nuc = false;
            end
        end

        if adjacent_pos && adjacent_neg && adjacent_pos_o && adjacent_nuc
            rand = [rand;x,y];
            num_rand = num_rand+1;
        end
    end
    pts_rand(k).cdata = [rand];
end
name = '/Users/ruoshiliu/Desktop/OneDrive/Github/ML_ActiveNematicsImage/pts_collected/d400um/pts_rand.mat';
save(name,'pts_rand','k');