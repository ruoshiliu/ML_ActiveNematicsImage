clear variables;
log = importdata('/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/Aug 2nd/augmentation_comparison/8_2_13200_3400_local_rotation/8_2_13200_3400_local_rotation.log',',');
k_loss = cell(size(log,1),1);
k_fscore = cell(size(log,1),1);
k_recall = cell(size(log,1),1);
k_precision = cell(size(log,1),1);
for i = 1:size(log,1)
    k_loss(i) = strfind(log(i,:), 'total');
    k_fscore(i) = strfind(log(i,:), 'fscore:');
    k_recall(i) = strfind(log(i,:), 'recall:');
    k_precision(i) = strfind(log(i,:), 'precision:');
end
 
loss_arr = zeros(size(k_loss,1),1);
for i = 1:size(k_loss,1)
    if ~isempty(cell2mat(k_loss(i,1)))
        log_mat = cell2mat(log(i));
        loss = log_mat(1,cell2mat(k_loss(i,1))+6:size(log_mat,2));
        loss_num = str2double(loss);
        loss_arr(i)= loss_num;
    end
end
x = [];
for i = 1:696
    x = [x; mean(loss_arr((i-1)*116+1:i*116))];
end
plot(x);
 
fscore_arr = [];
for i = 1:size(k_fscore,1)
    if ~isempty(cell2mat(k_fscore(i,1)))
        log_mat = cell2mat(log(i));
        fscore = log_mat(1,cell2mat(k_fscore(i,1))+8:size(log_mat,2));
        fscore_num = str2double(fscore);
        fscore_arr = [fscore_arr; fscore_num];
    end
end
% plot(fscore_arr);
 
recall_arr = [];
for i = 1:size(k_recall,1)
    if ~isempty(cell2mat(k_recall(i,1)))
        log_mat = cell2mat(log(i));
        recall = log_mat(1,cell2mat(k_recall(i,1))+8:cell2mat(k_recall(i,1))+14);
        recall_num = str2double(recall);
        recall_arr = [recall_arr; recall_num];
    end
end
% plot(recall_arr);
 
precision_arr = [];
for i = 1:size(k_precision,1)
    if ~isempty(cell2mat(k_precision(i,1)))
        log_mat = cell2mat(log(i));
        precision = log_mat(1,cell2mat(k_precision(i,1))+11:cell2mat(k_precision(i,1))+17);
        precision_num = str2double(precision);
        precision_arr = [precision_arr; precision_num];
    end
end

 


x(730:size(x,1)) = [];
recall_arr(730:size(recall_arr,1)) = [];
precision_arr(730:size(precision_arr,1)) = [];
fscore_arr(730:size(fscore_arr,1)) = [];

% plot(precision_arr);
figure(1)
plot(x)
grid
figure(2)
plot(fscore_arr)
grid
figure(3)
plot(precision_arr)
grid
figure(4)
plot(recall_arr)
grid

filename = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/Aug 2nd/augmentation_comparison/8_2_13200_3400_local_rotation/fscore_local.mat';
fscore_local = fscore_arr;
save(filename,'fscore_local');