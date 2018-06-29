path = '/home/rliu/pytorch_yolo2/data/an_data/VOCdevkit_d400_d300_mixed/';
list_of_names = [];
for ii = 12601:13000
    a = [];
    filename = [sprintf('%06.0f',ii) '.jpg'];
    filename = [path filename];
    list_of_names = [list_of_names; filename];
end
filePh = fopen('d400_last400.txt','w');
for i = 1:size(list_of_names,1)
    fprintf(filePh,'%s\n',list_of_names(i,:));
end
fclose(filePh);