clear variable
v = VideoReader('/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/d400um.avi');
load '/Users/ruoshiliu/Desktop/OneDrive/Github/ML_ActiveNematicsImage/pts_collected/7400';
width = 80;

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

for i = 1:size(neg,2)
    im = read(v, i);
    for j = 1:size(neg(i).cdata,1)
        x = neg(i).cdata(j,1);
        y = neg(i).cdata(j,2);
        rect = [x-width/2 y-width/2 width width];
        J = imcrop(im, rect);
%         imshow(J);
        if ~isempty(J)
            filename = strcat('neg', '_' ,num2str(i) , '_' ,num2str(j) , '.jpg');
            name = strcat('/Users/ruoshiliu/Desktop/OneDrive/Github/ML_ActiveNematicsImage/image_patches/neg/' , filename);
            imwrite(J, name);
        end
    end
end


