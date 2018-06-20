v = VideoReader('/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/d400um.avi');
load('pts_collected/d400um/7400.mat','pos','neg');
k = 0;

nframes = v.duration * v.framerate;
pts_rand(nframes).cdata = [];


for k=1:nframes
    num_rand = 0;
    rand = [];
    while num_rand < 4
        [x,y] = randompointinellipse(327, 350, 367.495, 376.51, 0, 1);
        adjacent_pos = true;
        for q = 1:size(pos(k).cdata,1)
            if abs(x - pos(k).cdata(q,1)) <= 80 && abs(y - pos(k).cdata(q,2)) <= 80
                adjacent_pos = false;
            end
        end
        adjacent_neg = true;
        for p = 1:size(neg(k).cdata,1)
            if abs(x - neg(k).cdata(p,1)) <= 80 && abs(y - neg(k).cdata(p,2)) <= 80
                adjacent_neg = false;
            end
        end

        if adjacent_pos && adjacent_neg
            rand = [rand;x,y];
            num_rand = num_rand+1;
        end
    end
    pts_rand(k).cdata = [rand];
end
name = '/Users/ruoshiliu/Desktop/OneDrive/Github/ML_ActiveNematicsImage/pts_collected/d400um/pts_rand.mat';
save(name,'pts_rand','k');