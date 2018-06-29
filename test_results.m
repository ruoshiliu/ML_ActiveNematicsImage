test_pos = importdata('/Users/ruoshiliu/Desktop/test_d300/comp4_det_test_pos.txt');
test_neg = importdata('/Users/ruoshiliu/Desktop/test_d300/comp4_det_test_neg.txt');
test_set = unique(test_neg(:,1));
frame = 1;
path = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/d300_lamp50_3_20171017_jpg/';
filename = [sprintf('%06.0f',frame) '.jpg'];
name = strcat(path, filename);
im = imread(name);
[height,width,z] = size(im);
A = imshow(name, 'InitialMagnification', 180);
hold on;
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
    if test_pos(first_ele+i,2) >= 0.3
        lab_list = [lab_list; test_pos(first_ele+i,:)];
    end
end
for i = 1:size(lab_list,1)
    xmin = lab_list(i,3);
    ymax = height - lab_list(i,4); 
    xmax = lab_list(i,5);
    ymin = height - lab_list(i,6);
    w = ymax - ymin;
    h = xmax - xmin;
%     rectangle('Position',[xmin,xmax,ymax,ymin],'LineWidth',0.5,'LineStyle','-','EdgeColor','r');
    rectangle('Position',[xmin,ymin,w,h],'LineWidth',0.5,'LineStyle','-','EdgeColor','r');
end

num_lab = 0;
for i = 1:size(test_neg,1)
    if test_neg(i,1) == frame
        num_lab = num_lab + 1;
    end
end
first_ele = 1;
while test_neg(first_ele,1) ~= frame
    first_ele = first_ele+1;
end
first_ele = first_ele-1;
lab_list = [];
for i = 1:num_lab
    if test_neg(first_ele+i,2) >= 0.3
        lab_list = [lab_list; test_neg(first_ele+i,:)];
    end
end
for i = 1:size(lab_list,1)
    xmin = lab_list(i,3);
    ymax = height - lab_list(i,4); 
    xmax = lab_list(i,5);
    ymin = height - lab_list(i,6);
    w = ymax - ymin;
    h = xmax - xmin;
%     rectangle('Position',[xmin,xmax,ymax,ymin],'LineWidth',0.5,'LineStyle','-','EdgeColor','r');
    rectangle('Position',[xmin,ymin,w,h],'LineWidth',0.5,'LineStyle','-','EdgeColor','g');
end
