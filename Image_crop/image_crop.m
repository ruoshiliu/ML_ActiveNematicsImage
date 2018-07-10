clear variable
v = VideoReader('/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/d400um.avi');
load '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/pts_collected/nucleation_2c_7400.mat';
width = 100;

% for i = 1:size(pos,2)
%     im = read(v, i);
%     for j = 1:size(pos(i).cdata,1)
%         x = pos(i).cdata(j,1);
%         y = pos(i).cdata(j,2);
%         rect = [x-width/2 y-width/2 width width];
%         J = imcrop(im, rect);
% %         imshow(J);
%         if ~isempty(J)
%             filename = strcat('pos', '_' ,num2str(i) , '_' ,num2str(j) , '.jpg');
%             name = strcat('/Users/ruoshiliu/Desktop/OneDrive/Github/ML_ActiveNematicsImage/image_patches/' , filename);
%             imwrite(J, name);
%         end
%     end
% end

for i = 1:size(pts_nucb,2)
    im = read(v, i);
    for j = 1:size(pts_nucb(i).cdata,1)
        x = pts_nucb(i).cdata(j,1);
        y = pts_nucb(i).cdata(j,2);
        rect = [x-width/2 y-width/2 width width];
        J = imcrop(im, rect);
%         imshow(J);
        if ~isempty(J)
            filename = strcat('pts_nucb', '_' ,num2str(i) , '_' ,num2str(j) , '.jpg');
            name = strcat('/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/image_patches/nuc_b/' , filename);
            imwrite(J, name);
        end
    end
end


