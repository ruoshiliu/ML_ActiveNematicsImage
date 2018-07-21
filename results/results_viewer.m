function coor_collector
%% read video information
clear variables;

k = 1;
nframes = 13000;
thres_pos = 0.3;
thres_neg = 0.1;
thres_pos_o = 0.3;
% thres_neg_b = 0;
thres_nuc = 0.1;
% thres_nucb = 0;
% thres_rand = 1;
path = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/images/';

test_pos = importdata('/Users/ruoshiliu/Desktop/tests/train6v1/comp4_det_test_pos.txt');
test_neg = importdata('/Users/ruoshiliu/Desktop/tests/train6v1/comp4_det_test_neg.txt');
test_pos_o = importdata('/Users/ruoshiliu/Desktop/tests/train6v1/comp4_det_test_pos_o.txt');
% test_neg_b = importdata('/Users/ruoshiliu/Desktop/tests/train6v1/comp4_det_test_neg_b.txt');
test_nuc = importdata('/Users/ruoshiliu/Desktop/tests/train6v1/comp4_det_test_nuc.txt');
% test_nucb = importdata('/Users/ruoshiliu/Desktop/tests/train6v1/comp4_det_test_nucb.txt');
% test_rand = importdata('/Users/ruoshiliu/Desktop/tests/train6v1/comp4_det_test_rand.txt');

test_set_neg = unique(test_neg(:,1));
test_set_pos = unique(test_pos(:,1));
% test_set_neg_b = unique(test_neg_b(:,1));
test_set_pos_o = unique(test_pos_o(:,1));
test_set_nuc = unique(test_nuc(:,1));
% test_set_nucb = unique(test_nucb(:,1));
% test_set_rand = unique(test_rand(:,1));

im_temp = [sprintf('%06.0f', 11001) '.jpg'];
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



% path = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/d200_3_pos0_20171016/';
%% construct GUI
%  Create and then hide the UI as it is being constructed.
f = figure('Visible','off','Position',[320,500,650,350],'KeyPressFcn', @keyPress)

% Construct the components.
pos = get(gcf, 'Position'); % get figure position
left = pos(1);
right = pos(2);
width = pos(3);
height = pos(4);


% Indicator of total frame number
nfrms = uicontrol('Style','text','String',['totalframes = ' num2str(nframes)],'Position',[left+width*1.2,300,100,30]);
% Next frame button
kp1 = uicontrol('Style','pushbutton','String','k+1','Position',[left+width*1.2,270,70,25],'Callback',{@kp1_Callback});
% Last frame button
km1 = uicontrol('Style','pushbutton','String','k-1','Position',[left+width*1.2,240,70,25],'Callback',{@km1_Callback});
% "current="
ktext1 = uicontrol('Style','text','String','current=','Position',[left+width*1.20,220,50,15]);
% Indicator of current frame number
kValue = uicontrol('Style','text','String','0','Position',[left+width*1.28,220,50,15],'Callback',{@kValue_Callback});
% Get userinput and set k accordingly
kequal = uicontrol('Style','edit','String','0','Position',[left+width*1.25,145,70,25],'Callback',{@kequal_Callback});
% Go to frame k
enter = uicontrol('Style','pushbutton','String','go to frame k','Position',[left+width*1.2,120,80,15],'Callback',{@gotoK_Callback});
% End and save
end_button = uicontrol('Style','pushbutton','String','END','BackgroundColor','red','FontWeight','bold','FontSize',14,'Position',[left+width*1.22,400,70,25],'Callback',{@end_Callback});
% "K="
ktext2 = uicontrol('Style','text','String','k=','Position',[left+width*1.20,150,15,15]);
% +1/2 or -1/2
positive = uicontrol('Style','text','FontSize',12.5,'ForegroundColor','b','String','+1/2','Position',[left+width*1.25,350,35,15],'Visible','off');
negative = uicontrol('Style','text','FontSize',12.5,'ForegroundColor','b','String','-1/2','Position',[left+width*1.25,350,35,15],'Visible','off');
set(gcf, 'units', 'normalized', 'position', [0 0 1 1]);

% set(f,'KeyPressFcn',@KeyPressCb);
ha = axes('Units','normalized','Position',[0.10,0.05,0.55,0.85]);
align([nfrms,kp1,km1,enter],'Center','None');

f.Visible = 'on';

 
% Push button callbacks. Each callback plots current_data in the
% specified plot type.
 %% next frame
function kp1_Callback(source,eventdata) 
% Increase k
    nframe = k + 1;
	k = k + 1;
    k_test = test_set_pos(nframe,1); 
    set(kValue,'Visible','on','string',num2str(k_test));
    hold off;
    filename = [sprintf('%06.0f',k_test) '.jpg'];
    name = strcat(path, filename);
    i = imread(name);
    %% display probability
    if ~isempty(pts_pos(k).cdata)
        txt_pos = pts_pos(k).cdata(:,5);
        i = insertText(i, pts_pos(k).cdata(:,1:2), txt_pos, 'BoxColor', 'blue', 'TextColor', 'white');
    end
    if ~isempty(pts_neg(k).cdata)
        txt_neg = pts_neg(k).cdata(:,5);
        i = insertText(i, pts_neg(k).cdata(:,1:2), txt_neg, 'BoxColor', 'blue', 'TextColor', 'white');
    end
    if ~isempty(pts_pos_o(k).cdata)
        txt_pos_o = pts_pos_o(k).cdata(:,5);
        i = insertText(i, pts_pos_o(k).cdata(:,1:2), txt_pos_o, 'BoxColor', 'blue', 'TextColor', 'white');
    end
%     if ~isempty(pts_neg_b(k).cdata)
%         txt_neg_b = pts_neg_b(k).cdata(:,5);
%         i = insertText(i, pts_neg_b(k).cdata(:,1:2), txt_neg_b, 'BoxColor', 'blue', 'TextColor', 'white');
%     end
    if ~isempty(pts_nuc(k).cdata)
        txt_nuc = pts_nuc(k).cdata(:,5);
        i = insertText(i, pts_nuc(k).cdata(:,1:2), txt_nuc, 'BoxColor', 'blue', 'TextColor', 'white');
    end
%     if ~isempty(pts_nucb(k).cdata)
%         txt_nucb = pts_nucb(k).cdata(:,5);
%         i = insertText(i, pts_nucb(k).cdata(:,1:2), txt_nucb, 'BoxColor', 'blue', 'TextColor', 'white');
%     end

%     if ~isempty(pts_rand(k).cdata)
%         txt_rand = pts_rand(k).cdata(:,5);
%         i = insertText(i, pts_rand(k).cdata(:,1:2), txt_rand, 'BoxColor', 'blue', 'TextColor', 'white');
%     end

    %% display bbox
    imshow(i,'InitialMagnification',220);
    hold on;
    for i_rec = 1:size(pts_pos(nframe).cdata,1)
        xmin = pts_pos(nframe).cdata(i_rec,1);
        ymin = pts_pos(nframe).cdata(i_rec,2);
        w = pts_pos(nframe).cdata(i_rec,3);
        h = pts_pos(nframe).cdata(i_rec,4);
        rectangle('Position',[xmin,ymin,w,h],'LineWidth',1,'LineStyle','-','EdgeColor','g');

    end
    for i_rec = 1:size(pts_neg(nframe).cdata,1)
        xmin = pts_neg(nframe).cdata(i_rec,1);
        ymin = pts_neg(nframe).cdata(i_rec,2);
        w = pts_neg(nframe).cdata(i_rec,3);
        h = pts_neg(nframe).cdata(i_rec,4);
        rectangle('Position',[xmin,ymin,w,h],'LineWidth',1,'LineStyle','-','EdgeColor','r');
    end
    for i_rec = 1:size(pts_pos_o(nframe).cdata,1)
        xmin = pts_pos_o(nframe).cdata(i_rec,1);
        ymin = pts_pos_o(nframe).cdata(i_rec,2);
        w = pts_pos_o(nframe).cdata(i_rec,3);
        h = pts_pos_o(nframe).cdata(i_rec,4);
        rectangle('Position',[xmin,ymin,w,h],'LineWidth',1,'LineStyle','-','EdgeColor','y');
    end
%     for i_rec = 1:size(pts_neg_b(nframe).cdata,1)
%         xmin = pts_neg_b(nframe).cdata(i_rec,1);
%         ymin = pts_neg_b(nframe).cdata(i_rec,2);
%         w = pts_neg_b(nframe).cdata(i_rec,3);
%         h = pts_neg_b(nframe).cdata(i_rec,4);
%         rectangle('Position',[xmin,ymin,w,h],'LineWidth',1,'LineStyle','-','EdgeColor','w');
%     end
    for i_rec = 1:size(pts_nuc(nframe).cdata,1)
        xmin = pts_nuc(nframe).cdata(i_rec,1);
        ymin = pts_nuc(nframe).cdata(i_rec,2);
        w = pts_nuc(nframe).cdata(i_rec,3);
        h = pts_nuc(nframe).cdata(i_rec,4);
        rectangle('Position',[xmin,ymin,w,h],'LineWidth',1,'LineStyle','-','EdgeColor','m');
    end
%     for i_rec = 1:size(pts_nucb(nframe).cdata,1)
%         xmin = pts_nucb(nframe).cdata(i_rec,1);
%         ymin = pts_nucb(nframe).cdata(i_rec,2);
%         w = pts_nucb(nframe).cdata(i_rec,3);
%         h = pts_nucb(nframe).cdata(i_rec,4);
%         rectangle('Position',[xmin,ymin,w,h],'LineWidth',1,'LineStyle','-','EdgeColor','b');
%     end

%     for i_rec = 1:size(pts_rand(nframe).cdata,1)
%         xmin = pts_rand(nframe).cdata(i_rec,1);
%         ymin = pts_rand(nframe).cdata(i_rec,2);
%         w = pts_rand(nframe).cdata(i_rec,3);
%         h = pts_rand(nframe).cdata(i_rec,4);
%         rectangle('Position',[xmin,ymin,w,h],'LineWidth',1,'LineStyle','-','EdgeColor','m');
%     end
    hold off;
end
 %% last frame
function km1_Callback(source,eventdata) 
% Decrease k
    nframe = k - 1;
	k = k - 1;
    k_test = test_set_pos(nframe,1); 
    set(kValue,'Visible','on','string',num2str(k_test));
    hold off;
    filename = [sprintf('%06.0f',k_test) '.jpg'];
    name = strcat(path, filename);
    i = imread(name);
    
    %% display probability
    if ~isempty(pts_pos(k).cdata)
        txt_pos = pts_pos(k).cdata(:,5);
        i = insertText(i, pts_pos(k).cdata(:,1:2), txt_pos, 'BoxColor', 'blue', 'TextColor', 'white');
    end
    if ~isempty(pts_neg(k).cdata)
        txt_neg = pts_neg(k).cdata(:,5);
        i = insertText(i, pts_neg(k).cdata(:,1:2), txt_neg, 'BoxColor', 'blue', 'TextColor', 'white');
    end
    if ~isempty(pts_pos_o(k).cdata)
        txt_pos_o = pts_pos_o(k).cdata(:,5);
        i = insertText(i, pts_pos_o(k).cdata(:,1:2), txt_pos_o, 'BoxColor', 'blue', 'TextColor', 'white');
    end
%     if ~isempty(pts_neg_b(k).cdata)
%         txt_neg_b = pts_neg_b(k).cdata(:,5);
%         i = insertText(i, pts_neg_b(k).cdata(:,1:2), txt_neg_b, 'BoxColor', 'blue', 'TextColor', 'white');
%     end
    if ~isempty(pts_nuc(k).cdata)
        txt_nuc = pts_nuc(k).cdata(:,5);
        i = insertText(i, pts_nuc(k).cdata(:,1:2), txt_nuc, 'BoxColor', 'blue', 'TextColor', 'white');
    end
%     if ~isempty(pts_nucb(k).cdata)
%         txt_nucb = pts_nucb(k).cdata(:,5);
%         i = insertText(i, pts_nucb(k).cdata(:,1:2), txt_nucb, 'BoxColor', 'blue', 'TextColor', 'white');
%     end

    %% display bbox
    imshow(i,'InitialMagnification',220);
    hold on;
    for i_rec = 1:size(pts_pos(nframe).cdata,1)
        xmin = pts_pos(nframe).cdata(i_rec,1);
        ymin = pts_pos(nframe).cdata(i_rec,2);
        w = pts_pos(nframe).cdata(i_rec,3);
        h = pts_pos(nframe).cdata(i_rec,4);
        rectangle('Position',[xmin,ymin,w,h],'LineWidth',1,'LineStyle','-','EdgeColor','g');
    end
    for i_rec = 1:size(pts_neg(nframe).cdata,1)
        xmin = pts_neg(nframe).cdata(i_rec,1);
        ymin = pts_neg(nframe).cdata(i_rec,2);
        w = pts_neg(nframe).cdata(i_rec,3);
        h = pts_neg(nframe).cdata(i_rec,4);
        rectangle('Position',[xmin,ymin,w,h],'LineWidth',1,'LineStyle','-','EdgeColor','r');
    end
    for i_rec = 1:size(pts_pos_o(nframe).cdata,1)
        xmin = pts_pos_o(nframe).cdata(i_rec,1);
        ymin = pts_pos_o(nframe).cdata(i_rec,2);
        w = pts_pos_o(nframe).cdata(i_rec,3);
        h = pts_pos_o(nframe).cdata(i_rec,4);
        rectangle('Position',[xmin,ymin,w,h],'LineWidth',1,'LineStyle','-','EdgeColor','y');
    end
%     for i_rec = 1:size(pts_neg_b(nframe).cdata,1)
%         xmin = pts_neg_b(nframe).cdata(i_rec,1);
%         ymin = pts_neg_b(nframe).cdata(i_rec,2);
%         w = pts_neg_b(nframe).cdata(i_rec,3);
%         h = pts_neg_b(nframe).cdata(i_rec,4);
%         rectangle('Position',[xmin,ymin,w,h],'LineWidth',1,'LineStyle','-','EdgeColor','w');
%     end
    for i_rec = 1:size(pts_nuc(nframe).cdata,1)
        xmin = pts_nuc(nframe).cdata(i_rec,1);
        ymin = pts_nuc(nframe).cdata(i_rec,2);
        w = pts_nuc(nframe).cdata(i_rec,3);
        h = pts_nuc(nframe).cdata(i_rec,4);
        rectangle('Position',[xmin,ymin,w,h],'LineWidth',1,'LineStyle','-','EdgeColor','m');
    end
%     for i_rec = 1:size(pts_nucb(nframe).cdata,1)
%         xmin = pts_nucb(nframe).cdata(i_rec,1);
%         ymin = pts_nucb(nframe).cdata(i_rec,2);
%         w = pts_nucb(nframe).cdata(i_rec,3);
%         h = pts_nucb(nframe).cdata(i_rec,4);
%         rectangle('Position',[xmin,ymin,w,h],'LineWidth',1,'LineStyle','-','EdgeColor','b');
%     end
    hold off;
end
%% go to frame
function gotoK_Callback(source,eventdata) 
% Display contour plot of the currently selected data.
    if k <= nframes && k>=0
        nframe = k;
        set(kValue,'Visible','on','string',num2str(k));
        hold off;
        filename = [sprintf('%06.0f',k) '.jpg'];
        name = strcat(path, filename);
        i = imread(name);
        imshow(i,'InitialMagnification',220);
        display_collect();
    end
end
    
%%
function kequal_Callback(source,eventdata,handles) 
% Display contour plot of the currently selected data.
    current_string = get(source, 'String');
    k = str2double(current_string);
end
%% 
function kValue_Callback(source,eventdata,handles) 
% Display contour plot of the currently selected data.
	current_string = get(source, 'String');
    set(gcf, 'String', current_string);
end

%% end and save
function end_Callback(source,eventdata) 
%     mkdir pts_collected;
    filename = num2str(k) + ".mat";
    name = path + filename;
    save(name,'pts_pos','pts_neg','k');
    close;
end
%% display and collect
    function display_collect()
        display();
        collect();
    end
%% display
    function display()
        hold on;
        if ~isempty(pts_neg(k).cdata)
            x = pts_neg(k).cdata(:,1);
            y = pts_neg(k).cdata(:,2);
            plot(x, y, 'b.', 'LineWidth', 1, 'MarkerSize', 20);
        end
        if ~isempty(pts_pos(k).cdata)
            x = pts_pos(k).cdata(:,1);
            y = pts_pos(k).cdata(:,2);
            plot(x, y, 'r+', 'LineWidth', 1, 'MarkerSize', 10);
        end
    end
%% collect
    function collect(source, eventdata)
        hold on;

        if waitforbuttonpress == 1 % press any key to start collecting
            positive.Visible = 'on';
            [x_pos,y_pos] = getpts(gca);
            pts_pos(k).cdata = [x_pos,y_pos];
            positive.Visible = 'off';
            hold on;
            negative.Visible = 'on';
            [x_neg,y_neg] = getpts(gca);
            pts_neg(k).cdata = [x_neg,y_neg];
            negative.Visible = 'off';
            plot(x_neg, y_neg, 'g.', 'LineWidth', 1, 'MarkerSize', 20);
            plot(x_pos, y_pos, 'y+', 'LineWidth', 1, 'MarkerSize', 10);
        end  
    end
    function keyPress(source, eventdata)
        switch eventdata.Key
            % press rightarrow or d to go to the next frame
            case 'rightarrow'
                kp1_Callback(kp1, []);
            case 'd'
                kp1_Callback(kp1, []);
            % press leftarrow or a to go to the previous frame
            case 'leftarrow'
                km1_Callback(km1, []);
            case 'a'
                km1_Callback(km1, []);
        end
    end
 
end