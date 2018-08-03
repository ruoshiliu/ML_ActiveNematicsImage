path = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_4v1_local/VOC2007/JPEGImages/';
load('/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/pts_collected/81000_6c.mat', 'pts_neg', 'pts_pos', 'pts_neg_b', 'pts_pos_o', 'pts_nuc', 'pts_nucb');
pts_pos(90000).cdata = [];
pts_neg(90000).cdata = [];
pts_pos_o(90000).cdata = [];
pts_neg_b(90000).cdata = [];
pts_nuc(90000).cdata = [];
pts_nucb(90000).cdata = [];
k = 90000;

for ii = k-17999:k-9000
    filename = [sprintf('%06.0f', ii) '.jpg'];
    i = imread(strcat(path,filename));
    ang = rand*360;    % use radians
    ir = imrotate(i,ang,'crop');
%     imshow(ir);
	ang = ang / 180.0 * pi;
    w = size(i,2);
    h = size(i,1);
    
%% pos  
	x_pos = [];
	y_pos = [];
    for kk = 1:size(pts_pos(ii).cdata,1)
        x_0 = pts_pos(ii).cdata(kk,1);     % x coordinate of center of bbox before rotation
        y_0 = h - pts_pos(ii).cdata(kk,2);     % y coordinate of center of bbox before rotation
        l_r = sqrt((x_0-w/2)^2 + (y_0-h/2)^2);   % length from center of bbox before rotation to image center
        alpha = atan2((y_0-h/2),(x_0-w/2));    % original angle between center of bbox and positive x axis
        if alpha < 0    % alpha belongs to [0, 360); alphs is integer
            alpha = alpha + 2*pi;
        end  
        x_r = w/2 + l_r * cos(ang + alpha);   % position of center of bbox after rotation
        y_r = h/2 - l_r * sin(ang + alpha);
        x_pos = [x_pos; x_r];
        y_pos = [y_pos; y_r];
    end
%     hold on;
%     plot(x_pos, y_pos, 'r*', 'LineWidth', 2, 'MarkerSize', 15);
%% neg
	x_neg = [];
	y_neg = [];
	for kk = 1:size(pts_neg(ii).cdata,1)
        x_0 = pts_neg(ii).cdata(kk,1);     % x coordinate of center of bbox before rotation
        y_0 = h - pts_neg(ii).cdata(kk,2);     % y coordinate of center of bbox before rotation
        l_r = sqrt((x_0-w/2)^2 + (y_0-h/2)^2);   % length from center of bbox before rotation to image center
        alpha = atan2((y_0-h/2),(x_0-w/2));    % original angle between center of bbox and positive x axis
        if alpha < 0    % alpha belongs to [0, 360); alphs is integer
            alpha = alpha + 2*pi;
        end  
        x_r = w/2 + l_r * cos(ang + alpha);   % position of center of bbox after rotation
        y_r = h/2 - l_r * sin(ang + alpha);
        x_neg = [x_neg; x_r];
        y_neg = [y_neg; y_r];
    end
%     hold on;
%     plot(x_neg, y_neg, 'g*', 'LineWidth', 2, 'MarkerSize', 15);
%% pos_o
	x_pos_o = [];
	y_pos_o = [];
	for kk = 1:size(pts_pos_o(ii).cdata,1)
        x_0 = pts_pos_o(ii).cdata(kk,1);     % x coordinate of center of bbox before rotation
        y_0 = h - pts_pos_o(ii).cdata(kk,2);     % y coordinate of center of bbox before rotation
        l_r = sqrt((x_0-w/2)^2 + (y_0-h/2)^2);   % length from center of bbox before rotation to image center
        alpha = atan2((y_0-h/2),(x_0-w/2));    % original angle between center of bbox and positive x axis
        if alpha < 0    % alpha belongs to [0, 360); alphs is integer
            alpha = alpha + 2*pi;
        end  
        x_r = w/2 + l_r * cos(ang + alpha);   % position of center of bbox after rotation
        y_r = h/2 - l_r * sin(ang + alpha);
        x_pos_o = [x_pos_o; x_r];
        y_pos_o = [y_pos_o; y_r];
    end
%     hold on;
%     plot(x_pos_o, y_pos_o, 'w*', 'LineWidth', 2, 'MarkerSize', 15);
%% neg_b
	x_neg_b = [];
	y_neg_b = [];
	for kk = 1:size(pts_neg_b(ii).cdata,1)
        x_0 = pts_neg_b(ii).cdata(kk,1);     % x coordinate of center of bbox before rotation
        y_0 = h - pts_neg_b(ii).cdata(kk,2);     % y coordinate of center of bbox before rotation
        l_r = sqrt((x_0-w/2)^2 + (y_0-h/2)^2);   % length from center of bbox before rotation to image center
        alpha = atan2((y_0-h/2),(x_0-w/2));    % original angle between center of bbox and positive x axis
        if alpha < 0    % alpha belongs to [0, 360); alphs is integer
            alpha = alpha + 2*pi;
        end  
        x_r = w/2 + l_r * cos(ang + alpha);   % position of center of bbox after rotation
        y_r = h/2 - l_r * sin(ang + alpha);
        x_neg_b = [x_neg_b; x_r];
        y_neg_b = [y_neg_b; y_r];
    end
%     hold on;
%     plot(x_neg_b, y_neg_b, 'b*', 'LineWidth', 2, 'MarkerSize', 15);
%% nuc
	x_nuc = [];
	y_nuc = [];
	for kk = 1:size(pts_nuc(ii).cdata,1)
        x_0 = pts_nuc(ii).cdata(kk,1);     % x coordinate of center of bbox before rotation
        y_0 = h - pts_nuc(ii).cdata(kk,2);     % y coordinate of center of bbox before rotation
        l_r = sqrt((x_0-w/2)^2 + (y_0-h/2)^2);   % length from center of bbox before rotation to image center
        alpha = atan2((y_0-h/2),(x_0-w/2));    % original angle between center of bbox and positive x axis
        if alpha < 0    % alpha belongs to [0, 360); alphs is integer
            alpha = alpha + 2*pi;
        end  
        x_r = w/2 + l_r * cos(ang + alpha);   % position of center of bbox after rotation
        y_r = h/2 - l_r * sin(ang + alpha);
        x_nuc = [x_nuc; x_r];
        y_nuc = [y_nuc; y_r];
    end
%     hold on;
%     plot(x_nuc, y_nuc, 'm*', 'LineWidth', 2, 'MarkerSize', 15);
%% nucb
	x_nucb = [];
	y_nucb = [];
	for kk = 1:size(pts_nucb(ii).cdata,1)
        x_0 = pts_nucb(ii).cdata(kk,1);     % x coordinate of center of bbox before rotation
        y_0 = h - pts_nucb(ii).cdata(kk,2);     % y coordinate of center of bbox before rotation
        l_r = sqrt((x_0-w/2)^2 + (y_0-h/2)^2);   % length from center of bbox before rotation to image center
        alpha = atan2((y_0-h/2),(x_0-w/2));    % original angle between center of bbox and positive x axis
        if alpha < 0    % alpha belongs to [0, 360); alphs is integer
            alpha = alpha + 2*pi;
        end  
        x_r = w/2 + l_r * cos(ang + alpha);   % position of center of bbox after rotation
        y_r = h/2 - l_r * sin(ang + alpha);
        x_nucb = [x_nucb; x_r];
        y_nucb = [y_nucb; y_r];
    end
%     hold on;
%     plot(x_nucb, y_nucb, 'y*', 'LineWidth', 2, 'MarkerSize', 15);
    pts_pos(ii+9000).cdata = [x_pos, y_pos];
    pts_neg(ii+9000).cdata = [x_neg, y_neg];
    pts_pos_o(ii+9000).cdata = [x_pos_o, y_pos_o];
    pts_neg_b(ii+9000).cdata = [x_neg_b, y_neg_b];
    pts_nuc(ii+9000).cdata = [x_nuc, y_nuc];
    pts_nucb(ii+9000).cdata = [x_nucb, y_nucb];
    filename = [sprintf('%06.0f', ii+9000) '.jpg'];
    imwrite(ir, strcat(path,filename));
end
filename = num2str(k) + "_6c.mat";
savePath = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/pts_collected/';
name = savePath + filename;
save(name,'pts_neg', 'pts_pos', 'pts_neg_b', 'pts_pos_o', 'pts_nuc', 'pts_nucb','k');



