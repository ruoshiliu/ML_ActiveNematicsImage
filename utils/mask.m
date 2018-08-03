for ii = 8001:
    path = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_4v1_local/VOC2007/JPEGImages/';
    filename = [sprintf('%06.0f', ii) '.jpg'];
    i = imread(strcat(path,filename));
    centers = [375,375];
    radii = [360];
    m = createCirclesMask(i,centers,radii);
    m = reshape(m, 748,736,3);
%     m = ~m;
    m = double(m);
    i = im2double(i);
    i = i.*m(:,:,1);
    i = uint8(255 * mat2gray(i));
    imwrite(i, strcat(path,filename));
    ii
end
