%% read video information
% clear variables;

k = 1;
nframes = 13000;
thres_pos = 0.25;
thres_neg = 0;
thres_pos_o = 0;
% thres_neg_b = 0;
thres_nuc = 0;
% thres_nucb = 0;
% thres_rand = 1;
path = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_4v1_local/VOC2007/JPEGImages/';

load('/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/pts_collected/18000_4c.mat', 'pts_neg', 'pts_pos', 'pts_neg_b', 'pts_pos_o', 'pts_nuc', 'pts_nucb');

pts_pos_truth = pts_pos;
pts_neg_truth = pts_neg;
pts_pos_o_truth = pts_pos_o;
pts_nuc_truth = pts_nuc;    

clear pts_neg pts_pos pts_pos_o pts_nuc;

test_pos = importdata('/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/Aug 2nd/video/7_x_6000/comp4_det_test_pos.txt');
test_neg = importdata('/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/Aug 2nd/video/7_x_6000/comp4_det_test_neg.txt');
test_pos_o = importdata('/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/Aug 2nd/video/7_x_6000/comp4_det_test_pos_o.txt');
% test_neg_b = importdata('/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/Aug 2nd/video/7_x_6000/comp4_det_test_neg_b.txt');
test_nuc = importdata('/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/Aug 2nd/video/7_x_6000/comp4_det_test_nuc.txt');
% test_nucb = importdata('/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/Aug 2nd/video/7_x_6000/comp4_det_test_nucb.txt');
% test_rand = importdata('/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/Aug 2nd/video/7_x_6000/comp4_det_test_rand.txt');


test_set_neg = unique(test_neg(:,1));
test_set_pos = unique(test_pos(:,1));
% test_set_neg_b = unique(test_neg_b(:,1));
test_set_pos_o = unique(test_pos_o(:,1));
test_set_nuc = unique(test_nuc(:,1));
% test_set_nucb = unique(test_nucb(:,1));
% test_set_rand = unique(test_rand(:,1));

im_temp = [sprintf('%06.0f', 8801) '.jpg'];
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
for iii = 1:size(pts_pos,2)
    pts_pos(iii).cdata = [pts_pos(iii).cdata; pts_pos_o(iii).cdata];
end

for iii = 1:size(pts_pos_truth,2)
    pts_pos_truth(iii).cdata = [pts_pos_truth(iii).cdata; pts_pos_o_truth(iii).cdata];
end
clearvars -except pts_neg pts_neg_truth pts_nuc pts_nuc_truth pts_pos pts_pos_truth test_set_neg test_set_nuc test_set_pos path test_set_pos_ppp;

% v = VideoWriter('d500_old.avi','Uncompressed AVI');
% v.FrameRate = 1;
% open(v);
% 
% for ii = 1589:1688
%     k_test = test_set_pos(ii,1); 
%     filename = [sprintf('%06.0f',k_test) '.jpg'];
%     name = strcat(path, filename);
%     i = imread(name);
%         if ~isempty(pts_pos(ii).cdata)
%         txt_pos = pts_pos(ii).cdata(:,5);
%         i = insertText(i, pts_pos(ii).cdata(:,1:2), txt_pos, 'BoxColor', 'blue', 'TextColor', 'white','FontSize',10);
%     end
%     if ~isempty(pts_neg(ii).cdata)
%         txt_neg = pts_neg(ii).cdata(:,5);
%         i = insertText(i, pts_neg(ii).cdata(:,1:2), txt_neg, 'BoxColor', 'blue', 'TextColor', 'white','FontSize',10);
%     end
%     if ~isempty(pts_nuc(ii).cdata)
%         txt_nuc = pts_nuc(ii).cdata(:,5);
%         i = insertText(i, pts_nuc(ii).cdata(:,1:2), txt_nuc, 'BoxColor', 'blue', 'TextColor', 'white','FontSize',10);
%     end
%     
%     for i_rec = 1:size(pts_pos(ii).cdata,1)
%         xmin = pts_pos(ii).cdata(i_rec,1);
%         ymin = pts_pos(ii).cdata(i_rec,2);
%         w = pts_pos(ii).cdata(i_rec,3);
%         h = pts_pos(ii).cdata(i_rec,4);
% %         rectangle('Position',[xmin,ymin,w,h],'LineWidth',1,'LineStyle','-','EdgeColor','g');
%         i = insertShape(i,'Rectangle',[xmin,ymin,w,h],'LineWidth',1,'Color','g');
%     end
%     for i_rec = 1:size(pts_neg(ii).cdata,1)
%         xmin = pts_neg(ii).cdata(i_rec,1);
%         ymin = pts_neg(ii).cdata(i_rec,2);
%         w = pts_neg(ii).cdata(i_rec,3);
%         h = pts_neg(ii).cdata(i_rec,4);
% %         rectangle('Position',[xmin,ymin,w,h],'LineWidth',1,'LineStyle','-','EdgeColor','r');
%         i = insertShape(i,'Rectangle',[xmin,ymin,w,h],'LineWidth',1,'Color','r');
%     end
%     for i_rec = 1:size(pts_nuc(ii).cdata,1)
%         xmin = pts_nuc(ii).cdata(i_rec,1);
%         ymin = pts_nuc(ii).cdata(i_rec,2);
%         w = pts_nuc(ii).cdata(i_rec,3);
%         h = pts_nuc(ii).cdata(i_rec,4);
% %         rectangle('Position',[xmin,ymin,w,h],'LineWidth',1,'LineStyle','-','EdgeColor','m');
%         i = insertShape(i,'Rectangle',[xmin,ymin,w,h],'LineWidth',1,'Color','m');
%     end
%     for i_rec = 1:size(pts_pos_truth(k_test).cdata,1)
%         xmin = pts_pos_truth(k_test).cdata(i_rec,1);
%         ymin = pts_pos_truth(k_test).cdata(i_rec,2);
% %         plot(xmin, ymin, 'g*', 'LineWidth', 3, 'MarkerSize', 15);
%         i = insertShape(i,'Circle',[xmin,ymin, 8],'LineWidth',2,'Color','g');
%     end
%     for i_rec = 1:size(pts_neg_truth(k_test).cdata,1)
%         xmin = pts_neg_truth(k_test).cdata(i_rec,1);
%         ymin = pts_neg_truth(k_test).cdata(i_rec,2);
% %         plot(xmin, ymin, 'r*', 'LineWidth', 3, 'MarkerSize', 15);
%         i = insertShape(i,'Circle',[xmin,ymin, 8],'LineWidth',2,'Color','r');
%     end
%     for i_rec = 1:size(pts_nuc_truth(k_test).cdata,1)
%         xmin = pts_nuc_truth(k_test).cdata(i_rec,1);
%         ymin = pts_nuc_truth(k_test).cdata(i_rec,2);
% %         plot(xmin, ymin, 'm*', 'LineWidth', 3, 'MarkerSize', 15);
%         i = insertShape(i,'Circle',[xmin,ymin, 8],'LineWidth',2,'Color','m');
%     end
%     writeVideo(v,i);
% end
%  close(v);



