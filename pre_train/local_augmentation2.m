path = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_4v1_local/VOC2007/JPEGImages/';
test = [51501:53000 53201:53300 53801:53900 60501:62000 62201:62300 62801:62900 69501:71000 71201:71300 71801:71900 78501:80000 80201:80300 80801:80900 87501:89000 89201:89300 89801:89900];
total = 45001:90000;
change = setdiff(total,test);
for ii = change
    filename = [sprintf('%06.0f', ii) '.jpg'];
    i = imread(strcat(path,filename));
    var_speckle = rand * 0.05;
    i = imnoise(i,'speckle',var_speckle);
    m = rand*0.1 - 0.05;
    i = imnoise(i,'gaussian',m);
    d = rand*0.05;
    i = imnoise(i,'salt & pepper', d);
    imwrite(i, strcat(path,filename));
end