inputpath = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/train6v1/d500_fluor Pos2/';
outputpath = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/train6v1/images6v1/';
for ii = 1:100
    filename_tif = [sprintf('1%04.0f',ii) '.tif'];
    inputFilename = strcat(inputpath, filename_tif);
    tifImage = imread(inputFilename);
    filename_jpg = [sprintf('%06.0f',ii+8900) '.jpg'];
    outputFilename = strcat(outputpath, filename_jpg);
    imwrite(tifImage, outputFilename);
end
    