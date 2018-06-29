load '/Users/ruoshiliu/Desktop/OneDrive/Github/ML_ActiveNematicsImage/pts_collected/d400um/7400.mat'
load '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/d300_lamp50_3_20171017/100.mat'
num_frame = 7400;
for i = 1:100
    pos(7400+i).cdata = pts_pos(i).cdata;
    neg(7400+i).cdata = pts_neg(i).cdata;
end

s = rng; % control the random number
p = 1:7400;
q = 7401:7500;

train_p = p(1:floor(num_frame*0.25));
train_p = [train_p q];
val_p = p(floor(num_frame*0.25)+1:floor(num_frame*0.5));
test_p = p(floor(num_frame*0.5)+1:num_frame);
train_val_p = cat(2, train_p, val_p);

%% pos_train
filename_pos_train = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_d400_d300_mixed/VOC2007/ImageSets/Main/pos_train.txt';
pos_train = [];
for i = 1:size(train_p,2)
    image_name = sprintf('%06.0f',train_p(i));
    if ~isempty(pos(i).cdata)
        image_name = strcat(image_name, '  1');
    else
        image_name = strcat(image_name, ' -1');
    end
    pos_train = [pos_train; image_name];
end

fid = fopen(filename_pos_train,'w');
for r=1:size(pos_train,1)
    fprintf(fid,'%s\n',pos_train(r,:));
end
fclose(fid);
%% pos_val
filename_pos_val = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_d400_d300_mixed/VOC2007/ImageSets/Main/pos_val.txt';
pos_val = [];
for i = 1:size(val_p,2)
    image_name = sprintf('%06.0f',val_p(i));
    if ~isempty(pos(i).cdata)
        image_name = strcat(image_name, '  1');
    else
        image_name = strcat(image_name, ' -1');
    end
    pos_val = [pos_val; image_name];
end

fid = fopen(filename_pos_val,'w');
for r=1:size(pos_val,1)
    fprintf(fid,'%s\n',pos_val(r,:));
end
fclose(fid);
%% pos_trainval
filename_pos_train_val = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_d400_d300_mixed/VOC2007/ImageSets/Main/pos_trainval.txt';
pos_train_val = [];
for i = 1:size(train_val_p,2)
    image_name = sprintf('%06.0f',train_val_p(i));
    if ~isempty(pos(i).cdata)
        image_name = strcat(image_name, '  1');
    else
        image_name = strcat(image_name, ' -1');
    end
    pos_train_val = [pos_train_val; image_name];
end

fid = fopen(filename_pos_train_val,'w');
for r=1:size(pos_train_val,1)
    fprintf(fid,'%s\n',pos_train_val(r,:));
end
fclose(fid);
%% pos_test
filename_pos_test = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_d400_d300_mixed/VOC2007/ImageSets/Main/pos_test.txt';
pos_test = [];
for i = 1:size(test_p,2)
    image_name = sprintf('%06.0f',test_p(i));
    if ~isempty(pos(i).cdata)
        image_name = strcat(image_name, '  1');
    else
        image_name = strcat(image_name, ' -1');
    end
    pos_test = [pos_test; image_name];
end

fid = fopen(filename_pos_test,'w');
for r=1:size(pos_test,1)
    fprintf(fid,'%s\n',pos_test(r,:));
end
fclose(fid);

%% neg_train
filename_neg_train = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_d400_d300_mixed/VOC2007/ImageSets/Main/neg_train.txt';
neg_train = [];
for i = 1:size(train_p,2)
    image_name = sprintf('%06.0f',train_p(i));
    if ~isempty(neg(i).cdata)
        image_name = strcat(image_name, '  1');
    else
        image_name = strcat(image_name, ' -1');
    end
    neg_train = [neg_train; image_name];
end

fid = fopen(filename_neg_train,'w');
for r=1:size(neg_train,1)
    fprintf(fid,'%s\n',neg_train(r,:));
end
fclose(fid);
%% neg_val
filename_neg_val = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_d400_d300_mixed/VOC2007/ImageSets/Main/neg_val.txt';
neg_val = [];
for i = 1:size(val_p,2)
    image_name = sprintf('%06.0f',val_p(i));
    if ~isempty(neg(i).cdata)
        image_name = strcat(image_name, '  1');
    else
        image_name = strcat(image_name, ' -1');
    end
    neg_val = [neg_val; image_name];
end

fid = fopen(filename_neg_val,'w');
for r=1:size(neg_val,1)
    fprintf(fid,'%s\n',neg_val(r,:));
end
fclose(fid);
%% neg_trainval
filename_neg_train_val = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_d400_d300_mixed/VOC2007/ImageSets/Main/neg_trainval.txt';
neg_train_val = [];
for i = 1:size(train_val_p,2)
    image_name = sprintf('%06.0f',train_val_p(i));
    if ~isempty(neg(i).cdata)
        image_name = strcat(image_name, '  1');
    else
        image_name = strcat(image_name, ' -1');
    end
    neg_train_val = [neg_train_val; image_name];
end

fid = fopen(filename_neg_train_val,'w');
for r=1:size(neg_train_val,1)
    fprintf(fid,'%s\n',neg_train_val(r,:));
end
fclose(fid);
%% neg_test
filename_neg_test = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_d400_d300_mixed/VOC2007/ImageSets/Main/neg_test.txt';
neg_test = [];
for i = 1:size(test_p,2)
    image_name = sprintf('%06.0f',test_p(i));
    if ~isempty(neg(i).cdata)
        image_name = strcat(image_name, '  1');
    else
        image_name = strcat(image_name, ' -1');
    end
    neg_test = [neg_test; image_name];
end

fid = fopen(filename_neg_test,'w');
for r=1:size(neg_test,1)
    fprintf(fid,'%s\n',neg_test(r,:));
end
fclose(fid);








%% train
filename_train = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_d400_d300_mixed/VOC2007/ImageSets/Main/train.txt';
train = [];
for i = 1:size(train_p,2)
    image_name = sprintf('%06.0f',train_p(i));
    train = [train; image_name];
end

fid = fopen(filename_train,'w');
for r=1:size(train,1)
    fprintf(fid,'%s\n',train(r,:));
end
fclose(fid);
%% val
filename_val = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_d400_d300_mixed/VOC2007/ImageSets/Main/val.txt';
val = [];
for i = 1:size(val_p,2)
    image_name = sprintf('%06.0f',val_p(i));
    val = [val; image_name];
end

fid = fopen(filename_val,'w');
for r=1:size(val,1)
    fprintf(fid,'%s\n',val(r,:));
end
fclose(fid);
%% trainval
filename_train_val = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_d400_d300_mixed/VOC2007/ImageSets/Main/trainval.txt';
train_val = [];
for i = 1:size(train_val_p,2)
    image_name = sprintf('%06.0f',train_val_p(i));
    train_val = [train_val; image_name];
end

fid = fopen(filename_train_val,'w');
for r=1:size(train_val,1)
    fprintf(fid,'%s\n',train_val(r,:));
end
fclose(fid);
%% test
filename_test = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_d400_d300_mixed/VOC2007/ImageSets/Main/test.txt';
test = [];
for i = 1:size(test_p,2)
    image_name = sprintf('%06.0f',test_p(i));
    test = [test; image_name];
end

fid = fopen(filename_test,'w');
for r=1:size(test,1)
    fprintf(fid,'%s\n',test(r,:));
end
fclose(fid);
