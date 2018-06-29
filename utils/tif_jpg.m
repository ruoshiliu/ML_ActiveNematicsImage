inputpath = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/d300_lamp50_3_20171017_full/';
outputpath = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_d400_d300_mixed/VOC2007/JPEGImages/';
for ii = 1:100
    filename_tif = [sprintf('1%04.0f',ii) '.tif'];
    inputFilename = strcat(inputpath, filename_tif);
    tifImage = imread(inputFilename);
    filename_jpg = [sprintf('%06.0f',ii+7400) '.jpg'];
    outputFilename = strcat(outputpath, filename_jpg);
    imwrite(tifImage, outputFilename);
end
    