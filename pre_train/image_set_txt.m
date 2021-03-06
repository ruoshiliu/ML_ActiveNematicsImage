load '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/pts_collected/18000_4c.mat'
num_frame = 18000;
% non_train = [6001:8000 8201:8500 8801:8900 15001:17000 17201:17500 17801:17900 24001:26000 26201:26500 26801:26900 33001:35000 35201:35500 35801:35900 42001:44000 44201:44500 44801:44900 51001:53000 53201:53500 53801:53900 60001:62000 62201:62500 62801:62900 69001:71000 71201:71500 71801:71900 78001:80000 80201:80500 80801:80900 87001:89000 89201:89500 89801:89900];
% total = 1:90000;
% change = setdiff(total,non_train);
for i = 1:num_frame
    pos(i).cdata = pts_pos(i).cdata;
    neg(i).cdata = pts_neg(i).cdata;
    pos_o(i).cdata = pts_pos_o(i).cdata;
%     neg_b(i).cdata = pts_neg_b(i).cdata;
    nuc(i).cdata = pts_nuc(i).cdata;
%     nucb(i).cdata = pts_nucb(i).cdata;
%     rand(i).cdata = pts_rand(i).cdata;
end

train_p = [1:6000 8001:8200 8501:8800 8901:9000 9001:15000 17001:17200 17501:17800 17901:18000];
val_p = [];
% test_p = p(floor(num_frame*0.5)+1:num_frame);
test_p = [6501:8000, 8201:8300, 8801:8900];
train_val_p = cat(2, train_p, val_p);

%% pos_train
filename_pos_train = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/pos_train.txt';
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
filename_pos_val = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/pos_val.txt';
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
filename_pos_train_val = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/pos_trainval.txt';
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
filename_pos_test = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/pos_test.txt';
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
filename_neg_train = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/neg_train.txt';
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
filename_neg_val = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/neg_val.txt';
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
filename_neg_train_val = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/neg_trainval.txt';
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
filename_neg_test = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/neg_test.txt';
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



%% pos_o_train
filename_pos_o_train = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/pos_o_train.txt';
pos_o_train = [];
for i = 1:size(train_p,2)
    image_name = sprintf('%06.0f',train_p(i));
    if ~isempty(pos_o(i).cdata)
        image_name = strcat(image_name, '  1');
    else
        image_name = strcat(image_name, ' -1');
    end
    pos_o_train = [pos_o_train; image_name];
end

fid = fopen(filename_pos_o_train,'w');
for r=1:size(pos_o_train,1)
    fprintf(fid,'%s\n',pos_o_train(r,:));
end
fclose(fid);
%% pos_o_val
filename_pos_o_val = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/pos_o_val.txt';
pos_o_val = [];
for i = 1:size(val_p,2)
    image_name = sprintf('%06.0f',val_p(i));
    if ~isempty(pos_o(i).cdata)
        image_name = strcat(image_name, '  1');
    else
        image_name = strcat(image_name, ' -1');
    end
    pos_o_val = [pos_o_val; image_name];
end

fid = fopen(filename_pos_o_val,'w');
for r=1:size(pos_o_val,1)
    fprintf(fid,'%s\n',pos_o_val(r,:));
end
fclose(fid);
%% pos_o_trainval
filename_pos_o_train_val = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/pos_o_trainval.txt';
pos_o_train_val = [];
for i = 1:size(train_val_p,2)
    image_name = sprintf('%06.0f',train_val_p(i));
    if ~isempty(pos_o(i).cdata)
        image_name = strcat(image_name, '  1');
    else
        image_name = strcat(image_name, ' -1');
    end
    pos_o_train_val = [pos_o_train_val; image_name];
end

fid = fopen(filename_pos_o_train_val,'w');
for r=1:size(pos_o_train_val,1)
    fprintf(fid,'%s\n',pos_o_train_val(r,:));
end
fclose(fid);
%% pos_o_test
filename_pos_o_test = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/pos_o_test.txt';
pos_o_test = [];
for i = 1:size(test_p,2)
    image_name = sprintf('%06.0f',test_p(i));
    if ~isempty(pos_o(i).cdata)
        image_name = strcat(image_name, '  1');
    else
        image_name = strcat(image_name, ' -1');
    end
    pos_o_test = [pos_o_test; image_name];
end

fid = fopen(filename_pos_o_test,'w');
for r=1:size(pos_o_test,1)
    fprintf(fid,'%s\n',pos_o_test(r,:));
end
fclose(fid);











% %% neg_b_train
% filename_neg_b_train = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/neg_b_train.txt';
% neg_b_train = [];
% for i = 1:size(train_p,2)
%     image_name = sprintf('%06.0f',train_p(i));
%     if ~isempty(neg_b(i).cdata)
%         image_name = strcat(image_name, '  1');
%     else
%         image_name = strcat(image_name, ' -1');
%     end
%     neg_b_train = [neg_b_train; image_name];
% end
% 
% fid = fopen(filename_neg_b_train,'w');
% for r=1:size(neg_b_train,1)
%     fprintf(fid,'%s\n',neg_b_train(r,:));
% end
% fclose(fid);
% %% neg_b_val
% filename_neg_b_val = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/neg_b_val.txt';
% neg_b_val = [];
% for i = 1:size(val_p,2)
%     image_name = sprintf('%06.0f',val_p(i));
%     if ~isempty(neg_b(i).cdata)
%         image_name = strcat(image_name, '  1');
%     else
%         image_name = strcat(image_name, ' -1');
%     end
%     neg_b_val = [neg_b_val; image_name];
% end
% 
% fid = fopen(filename_neg_b_val,'w');
% for r=1:size(neg_b_val,1)
%     fprintf(fid,'%s\n',neg_b_val(r,:));
% end
% fclose(fid);
% %% neg_b_trainval
% filename_neg_b_train_val = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/neg_b_trainval.txt';
% neg_b_train_val = [];
% for i = 1:size(train_val_p,2)
%     image_name = sprintf('%06.0f',train_val_p(i));
%     if ~isempty(neg_b(i).cdata)
%         image_name = strcat(image_name, '  1');
%     else
%         image_name = strcat(image_name, ' -1');
%     end
%     neg_b_train_val = [neg_b_train_val; image_name];
% end
% 
% fid = fopen(filename_neg_b_train_val,'w');
% for r=1:size(neg_b_train_val,1)
%     fprintf(fid,'%s\n',neg_b_train_val(r,:));
% end
% fclose(fid);
% %% neg_b_test
% filename_neg_b_test = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/neg_b_test.txt';
% neg_b_test = [];
% for i = 1:size(test_p,2)
%     image_name = sprintf('%06.0f',test_p(i));
%     if ~isempty(neg_b(i).cdata)
%         image_name = strcat(image_name, '  1');
%     else
%         image_name = strcat(image_name, ' -1');
%     end
%     neg_b_test = [neg_b_test; image_name];
% end
% 
% fid = fopen(filename_neg_b_test,'w');
% for r=1:size(neg_b_test,1)
%     fprintf(fid,'%s\n',neg_b_test(r,:));
% end
% fclose(fid);




%% nuc_train
filename_nuc_train = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/nuc_train.txt';
nuc_train = [];
for i = 1:size(train_p,2)
    image_name = sprintf('%06.0f',train_p(i));
    if ~isempty(nuc(i).cdata)
        image_name = strcat(image_name, '  1');
    else
        image_name = strcat(image_name, ' -1');
    end
    nuc_train = [nuc_train; image_name];
end

fid = fopen(filename_nuc_train,'w');
for r=1:size(nuc_train,1)
    fprintf(fid,'%s\n',nuc_train(r,:));
end
fclose(fid);
%% nuc_val
filename_nuc_val = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/nuc_val.txt';
nuc_val = [];
for i = 1:size(val_p,2)
    image_name = sprintf('%06.0f',val_p(i));
    if ~isempty(nuc(i).cdata)
        image_name = strcat(image_name, '  1');
    else
        image_name = strcat(image_name, ' -1');
    end
    nuc_val = [nuc_val; image_name];
end

fid = fopen(filename_nuc_val,'w');
for r=1:size(nuc_val,1)
    fprintf(fid,'%s\n',nuc_val(r,:));
end
fclose(fid);
%% nuc_trainval
filename_nuc_train_val = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/nuc_trainval.txt';
nuc_train_val = [];
for i = 1:size(train_val_p,2)
    image_name = sprintf('%06.0f',train_val_p(i));
    if ~isempty(nuc(i).cdata)
        image_name = strcat(image_name, '  1');
    else
        image_name = strcat(image_name, ' -1');
    end
    nuc_train_val = [nuc_train_val; image_name];
end

fid = fopen(filename_nuc_train_val,'w');
for r=1:size(nuc_train_val,1)
    fprintf(fid,'%s\n',nuc_train_val(r,:));
end
fclose(fid);
%% nuc_test
filename_nuc_test = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/nuc_test.txt';
nuc_test = [];
for i = 1:size(test_p,2)
    image_name = sprintf('%06.0f',test_p(i));
    if ~isempty(nuc(i).cdata)
        image_name = strcat(image_name, '  1');
    else
        image_name = strcat(image_name, ' -1');
    end
    nuc_test = [nuc_test; image_name];
end

fid = fopen(filename_nuc_test,'w');
for r=1:size(nuc_test,1)
    fprintf(fid,'%s\n',nuc_test(r,:));
end
fclose(fid);


% %% nucb_train
% filename_nucb_train = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/nucb_train.txt';
% nucb_train = [];
% for i = 1:size(train_p,2)
%     image_name = sprintf('%06.0f',train_p(i));
%     if ~isempty(nucb(i).cdata)
%         image_name = strcat(image_name, '  1');
%     else
%         image_name = strcat(image_name, ' -1');
%     end
%     nucb_train = [nucb_train; image_name];
% end
% 
% fid = fopen(filename_nucb_train,'w');
% for r=1:size(nucb_train,1)
%     fprintf(fid,'%s\n',nucb_train(r,:));
% end
% fclose(fid);
% %% nucb_val
% filename_nucb_val = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/nucb_val.txt';
% nucb_val = [];
% for i = 1:size(val_p,2)
%     image_name = sprintf('%06.0f',val_p(i));
%     if ~isempty(nucb(i).cdata)
%         image_name = strcat(image_name, '  1');
%     else
%         image_name = strcat(image_name, ' -1');
%     end
%     nucb_val = [nucb_val; image_name];
% end
% 
% fid = fopen(filename_nucb_val,'w');
% for r=1:size(nucb_val,1)
%     fprintf(fid,'%s\n',nucb_val(r,:));
% end
% fclose(fid);
% %% nucb_trainval
% filename_nucb_train_val = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/nucb_trainval.txt';
% nucb_train_val = [];
% for i = 1:size(train_val_p,2)
%     image_name = sprintf('%06.0f',train_val_p(i));
%     if ~isempty(nucb(i).cdata)
%         image_name = strcat(image_name, '  1');
%     else
%         image_name = strcat(image_name, ' -1');
%     end
%     nucb_train_val = [nucb_train_val; image_name];
% end
% 
% fid = fopen(filename_nucb_train_val,'w');
% for r=1:size(nucb_train_val,1)
%     fprintf(fid,'%s\n',nucb_train_val(r,:));
% end
% fclose(fid);
% %% nucb_test
% filename_nucb_test = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/nucb_test.txt';
% nucb_test = [];
% for i = 1:size(test_p,2)
%     image_name = sprintf('%06.0f',test_p(i));
%     if ~isempty(nucb(i).cdata)
%         image_name = strcat(image_name, '  1');
%     else
%         image_name = strcat(image_name, ' -1');
%     end
%     nucb_test = [nucb_test; image_name];
% end
% 
% fid = fopen(filename_nucb_test,'w');
% for r=1:size(nucb_test,1)
%     fprintf(fid,'%s\n',nucb_test(r,:));
% end
% fclose(fid);






% %% rand_train
% filename_rand_train = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/rand_train.txt';
% rand_train = [];
% for i = 1:size(train_p,2)
%     image_name = sprintf('%06.0f',train_p(i));
%     if ~isempty(rand(i).cdata)
%         image_name = strcat(image_name, '  1');
%     else
%         image_name = strcat(image_name, ' -1');
%     end
%     rand_train = [rand_train; image_name];
% end
% 
% fid = fopen(filename_rand_train,'w');
% for r=1:size(rand_train,1)
%     fprintf(fid,'%s\n',rand_train(r,:));
% end
% fclose(fid);
% %% rand_val
% filename_rand_val = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/rand_val.txt';
% rand_val = [];
% for i = 1:size(val_p,2)
%     image_name = sprintf('%06.0f',val_p(i));
%     if ~isempty(rand(i).cdata)
%         image_name = strcat(image_name, '  1');
%     else
%         image_name = strcat(image_name, ' -1');
%     end
%     rand_val = [rand_val; image_name];
% end
% 
% fid = fopen(filename_rand_val,'w');
% for r=1:size(rand_val,1)
%     fprintf(fid,'%s\n',rand_val(r,:));
% end
% fclose(fid);
% %% rand_trainval
% filename_rand_train_val = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/rand_trainval.txt';
% rand_train_val = [];
% for i = 1:size(train_val_p,2)
%     image_name = sprintf('%06.0f',train_val_p(i));
%     if ~isempty(rand(i).cdata)
%         image_name = strcat(image_name, '  1');
%     else
%         image_name = strcat(image_name, ' -1');
%     end
%     rand_train_val = [rand_train_val; image_name];
% end
% 
% fid = fopen(filename_rand_train_val,'w');
% for r=1:size(rand_train_val,1)
%     fprintf(fid,'%s\n',rand_train_val(r,:));
% end
% fclose(fid);
% %% rand_test
% filename_rand_test = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/rand_test.txt';
% rand_test = [];
% for i = 1:size(test_p,2)
%     image_name = sprintf('%06.0f',test_p(i));
%     if ~isempty(rand(i).cdata)
%         image_name = strcat(image_name, '  1');
%     else
%         image_name = strcat(image_name, ' -1');
%     end
%     rand_test = [rand_test; image_name];
% end
% 
% fid = fopen(filename_rand_test,'w');
% for r=1:size(rand_test,1)
%     fprintf(fid,'%s\n',rand_test(r,:));
% end
% fclose(fid);










%% train
filename_train = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/train.txt';
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
filename_val = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/val.txt';
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
filename_train_val = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/trainval.txt';
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
filename_test = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_18000/VOC2007/ImageSets/Main/test.txt';
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
