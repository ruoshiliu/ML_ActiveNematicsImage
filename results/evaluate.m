%% read video information
clear variables;

k = 1;
nframes = 13000;
thres_pos = 0;
thres_neg = 0;
thres_pos_o = 0;
% thres_neg_b = 0;
thres_nuc = 0;
% thres_nucb = 0;
% thres_rand = 1;
path = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_4v1/VOC2007/JPEGImages/';

load('/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/train6v1/9000_4c.mat', 'pts_neg', 'pts_pos', 'pts_pos_o', 'pts_nuc');

pts_pos_truth = pts_pos;
pts_neg_truth = pts_neg;
pts_pos_o_truth = pts_pos_o;
pts_nuc_truth = pts_nuc;

clear pts_neg pts_pos pts_pos_o pts_nuc;

test_pos = importdata('/Users/ruoshiliu/Desktop/tests/Jul30_150weights/comp4_det_test_pos.txt');
test_neg = importdata('/Users/ruoshiliu/Desktop/tests/Jul30_150weights/comp4_det_test_neg.txt');
test_pos_o = importdata('/Users/ruoshiliu/Desktop/tests/Jul30_150weights/comp4_det_test_pos_o.txt');
% test_neg_b = importdata('/Users/ruoshiliu/Desktop/tests/Jul30_150weights/comp4_det_test_neg_b.txt');
test_nuc = importdata('/Users/ruoshiliu/Desktop/tests/Jul30_150weights/comp4_det_test_nuc.txt');
% test_nucb = importdata('/Users/ruoshiliu/Desktop/tests/Jul30_150weights/comp4_det_test_nucb.txt');
% test_rand = importdata('/Users/ruoshiliu/Desktop/tests/Jul30_150weights/comp4_det_test_rand.txt');

test_set_neg = unique(test_neg(:,1));
test_set_pos = unique(test_pos(:,1));
% test_set_neg_b = unique(test_neg_b(:,1));
test_set_pos_o = unique(test_pos_o(:,1));
test_set_nuc = unique(test_nuc(:,1));
% test_set_nucb = unique(test_nucb(:,1));
% test_set_rand = unique(test_rand(:,1));

im_temp = [sprintf('%06.0f', 1) '.jpg'];
im_name = strcat(path, im_temp);
im = imread(im_name);
height = size(im,1);
width = size(im,2);

clear pts_pos pts_neg;
pts_pos(size(test_set_pos,1)).cdata = [];
pts_neg(size(test_set_pos,1)).cdata = [];
pts_pos_o(size(test_set_pos,1)).cdata = [];
% pts_neg_b(size(test_set_pos,1)).cdata = [];
pts_nuc(size(test_set_pos,1)).cdata = [];
% pts_nucb(size(test_set_pos,1)).cdata = [];

for m = 1:size(test_set_pos,1)
    frame = test_set_pos(m,1);
    %% pos
    num_lab = 0;
    for i = 1:size(test_pos,1)
        if test_pos(i,1) == frame
            num_lab = num_lab + 1;
        end
    end
    first_ele = 1;
    while test_pos(first_ele,1) ~= frame
        first_ele = first_ele+1;
    end
    first_ele = first_ele-1;
    lab_list = [];
    for i = 1:num_lab
        if test_pos(first_ele+i,2) >= thres_pos
            lab_list = [lab_list; test_pos(first_ele+i,:)];
        end
    end
    rec = [];
    for i = 1:size(lab_list,1)
        xmin = lab_list(i,3);
        ymax = height - lab_list(i,4); 
        xmax = lab_list(i,5);
        ymin = height - lab_list(i,6);
        w = ymax - ymin;
        h = xmax - xmin;
%         rectangle('Position',[xmin,ymin,w,h],'LineWidth',0.5,'LineStyle','-','EdgeColor','r');
        rec = [rec; xmin ymin w h lab_list(i,2)];
    end
    pts_pos(m).cdata = rec;
    %% neg
    num_lab = 0;
    for i = 1:size(test_neg,1)
        if test_neg(i,1) == frame
            num_lab = num_lab + 1;
        end
    end
    first_ele = 1;
    while test_neg(first_ele,1) ~= frame && first_ele < size(test_neg,1)
        first_ele = first_ele+1;
    end
    first_ele = first_ele-1;
    lab_list = [];
    for i = 1:num_lab
        if test_neg(first_ele+i,2) >= thres_neg
            lab_list = [lab_list; test_neg(first_ele+i,:)];
        end
    end
    rec = [];
    for i = 1:size(lab_list,1)
        xmin = lab_list(i,3);
        ymax = height - lab_list(i,4); 
        xmax = lab_list(i,5);
        ymin = height - lab_list(i,6);
        w = ymax - ymin;
        h = xmax - xmin;
    %     rectangle('Position',[xmin,xmax,ymax,ymin],'LineWidth',0.5,'LineStyle','-','EdgeColor','r');
        rec = [rec; xmin ymin w h lab_list(i,2)];
    end
    pts_neg(m).cdata = rec;
    
    %% pos_o
    num_lab = 0;
    for i = 1:size(test_pos_o,1)
        if test_pos_o(i,1) == frame
            num_lab = num_lab + 1;
        end
    end
    first_ele = 1;
    while test_pos_o(first_ele,1) ~= frame && first_ele < size(test_pos_o,1)
        first_ele = first_ele+1;
    end
    first_ele = first_ele-1;
    lab_list = [];
    for i = 1:num_lab
        if test_pos_o(first_ele+i,2) >= thres_pos_o
            lab_list = [lab_list; test_pos_o(first_ele+i,:)];
        end
    end
    rec = [];
    for i = 1:size(lab_list,1)
        xmin = lab_list(i,3);
        ymax = height - lab_list(i,4); 
        xmax = lab_list(i,5);
        ymin = height - lab_list(i,6);
        w = ymax - ymin;
        h = xmax - xmin;
    %     rectangle('Position',[xmin,xmax,ymax,ymin],'LineWidth',0.5,'LineStyle','-','EdgeColor','r');
        rec = [rec; xmin ymin w h lab_list(i,2)];
    end
    pts_pos_o(m).cdata = rec;
    
%     %% neg_b
%     num_lab = 0;
%     for i = 1:size(test_neg_b,1)
%         if test_neg_b(i,1) == frame
%             num_lab = num_lab + 1;
%         end
%     end
%     first_ele = 1;
%     while test_neg_b(first_ele,1) ~= frame && first_ele < size(test_neg_b,1)
%         first_ele = first_ele+1;
%     end
%     first_ele = first_ele-1;
%     lab_list = [];
%     for i = 1:num_lab
%         if test_neg_b(first_ele+i,2) >= thres_neg_b
%             lab_list = [lab_list; test_neg_b(first_ele+i,:)];
%         end
%     end
%     rec = [];
%     for i = 1:size(lab_list,1)
%         xmin = lab_list(i,3);
%         ymax = height - lab_list(i,4); 
%         xmax = lab_list(i,5);
%         ymin = height - lab_list(i,6);
%         w = ymax - ymin;
%         h = xmax - xmin;
%     %     rectangle('Position',[xmin,xmax,ymax,ymin],'LineWidth',0.5,'LineStyle','-','EdgeColor','r');
%         rec = [rec; xmin ymin w h lab_list(i,2)];
%     end
%     pts_neg_b(m).cdata = rec;
    
    %% nuc
    num_lab = 0;
    for i = 1:size(test_nuc,1)
        if test_nuc(i,1) == frame
            num_lab = num_lab + 1;
        end
    end
    first_ele = 1;
    while test_nuc(first_ele,1) ~= frame && first_ele < size(test_nuc,1)
        first_ele = first_ele+1;
    end
    first_ele = first_ele-1;
    lab_list = [];
    for i = 1:num_lab
        if test_nuc(first_ele+i,2) >= thres_nuc
            lab_list = [lab_list; test_nuc(first_ele+i,:)];
        end
    end
    rec = [];
    for i = 1:size(lab_list,1)
        xmin = lab_list(i,3);
        ymax = height - lab_list(i,4); 
        xmax = lab_list(i,5);
        ymin = height - lab_list(i,6);
        w = ymax - ymin;
        h = xmax - xmin;
    %     rectangle('Position',[xmin,xmax,ymax,ymin],'LineWidth',0.5,'LineStyle','-','EdgeColor','r');
        rec = [rec; xmin ymin w h lab_list(i,2)];
    end
    pts_nuc(m).cdata = rec;
    
%     %% nucb
%     num_lab = 0;
%     for i = 1:size(test_nucb,1)
%         if test_nucb(i,1) == frame
%             num_lab = num_lab + 1;
%         end
%     end
%     first_ele = 1;
%     while test_nucb(first_ele,1) ~= frame && first_ele < size(test_nucb,1)
%         first_ele = first_ele+1;
%     end
%     first_ele = first_ele-1;
%     lab_list = [];
%     for i = 1:num_lab
%         if test_nucb(first_ele+i,2) >= thres_nucb
%             lab_list = [lab_list; test_nucb(first_ele+i,:)];
%         end
%     end
%     rec = [];
%     for i = 1:size(lab_list,1)
%         xmin = lab_list(i,3);
%         ymax = height - lab_list(i,4); 
%         xmax = lab_list(i,5);
%         ymin = height - lab_list(i,6);
%         w = ymax - ymin;
%         h = xmax - xmin;
%     %     rectangle('Position',[xmin,xmax,ymax,ymin],'LineWidth',0.5,'LineStyle','-','EdgeColor','r');
%         rec = [rec; xmin ymin w h lab_list(i,2)];
%     end
%     pts_nucb(m).cdata = rec;

%     %% rand
%     num_lab = 0;
%     for i = 1:size(test_rand,1)
%         if test_rand(i,1) == frame
%             num_lab = num_lab + 1;
%         end
%     end
%     first_ele = 1;
%     while test_rand(first_ele,1) ~= frame && first_ele < size(test_rand,1)
%         first_ele = first_ele+1;
%     end
%     first_ele = first_ele-1;
%     lab_list = [];
%     for i = 1:num_lab
%         if test_rand(first_ele+i,2) >= thres_rand
%             lab_list = [lab_list; test_rand(first_ele+i,:)];
%         end
%     end
%     rec = [];
%     for i = 1:size(lab_list,1)
%         xmin = lab_list(i,3);
%         ymax = height - lab_list(i,4); 
%         xmax = lab_list(i,5);
%         ymin = height - lab_list(i,6);
%         w = ymax - ymin;
%         h = xmax - xmin;
%     %     rectangle('Position',[xmin,xmax,ymax,ymin],'LineWidth',0.5,'LineStyle','-','EdgeColor','r');
%         rec = [rec; xmin ymin w h lab_list(i,2)];
%     end
%     pts_rand(m).cdata = rec;
end
%% pos
correct_pos = 0;
count_t_pos = 0;
count_p_pos = 0;
for i1 = 1:1680
    count_t_pos = count_t_pos + size(pts_pos_truth(i1).cdata,1);
    count_p_pos = count_p_pos + size(pts_pos(i1).cdata,1);
    for i_t = 1:size(pts_pos_truth(i1).cdata,1)
        x_t = pts_pos_truth(i1).cdata(i_t,1);
        y_t = pts_pos_truth(i1).cdata(i_t,2);
        for i_p = 1:size(pts_pos(i1).cdata,1)
            x_p = pts_pos(i1).cdata(i_p,1);
            y_p = pts_pos(i1).cdata(i_p,2);
            w_p = pts_pos(i1).cdata(i_p,3)+0;
            h_p = pts_pos(i1).cdata(i_p,4)+0;
            if x_t <= x_p+w_p && x_t >= x_p-w_p && y_t <= y_p+h_p && y_p >= y_p-h_p
                correct_pos = correct_pos + 1;
            end
        end
    end
end
%% neg
correct_neg = 0;
count_t_neg = 0;
count_p_neg = 0;
for i1 = 1589:1680
    count_t_neg = count_t_neg + size(pts_neg_truth(i1).cdata,1);
    count_p_neg = count_p_neg + size(pts_neg(i1).cdata,1);
    for i_t = 1:size(pts_neg_truth(i1).cdata,1)
        x_t = pts_neg_truth(i1).cdata(i_t,1);
        y_t = pts_neg_truth(i1).cdata(i_t,2);
        for i_p = 1:size(pts_neg(i1).cdata,1)
            x_p = pts_neg(i1).cdata(i_p,1);
            y_p = pts_neg(i1).cdata(i_p,2);
            w_p = pts_neg(i1).cdata(i_p,3)+0;
            h_p = pts_neg(i1).cdata(i_p,4)+0;
            if x_t <= x_p+w_p && x_t >= x_p-w_p && y_t <= y_p+h_p && y_p >= y_p-h_p
                correct_neg = correct_neg + 1;
            end
        end
    end
end


