inputpath = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/d500_1_pos1_20171018/';
outputpath = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/d500_1_pos1_20171018_jpg/';
for ii = 1:3999
    filename_tif = [sprintf('1%04.0f',ii) '.tif'];
    inputFilename = strcat(inputpath, filename_tif);
    tifImage = imread(inputFilename);
    filename_jpg = [sprintf('%06.0f',ii) '.jpg'];
    outputFilename = strcat(outputpath, filename_jpg);
    imwrite(tifImage, outputFilename);
end
    