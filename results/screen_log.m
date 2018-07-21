log = importdata('/Users/ruoshiliu/Desktop/tests/4c_6v1.log',',');
k_loss = [];
k_fscore = [];
for i = 1:size(log,1)
    k_loss = [k_loss; strfind(log(i,:), 'total')];
    k_fscore = [k_fscore; strfind(log(i,:), 'fscore')];
end
loss_arr = [];
for i = 1:size(k_loss,1)
    if ~isempty(cell2mat(k_loss(i,1)))
        log_mat = cell2mat(log(i));
        loss = log_mat(1,cell2mat(k_loss(i,1))+6:size(log_mat,2));
        loss_num = str2num(loss);
        loss_arr = [loss_arr; loss_num];
    end
end
x = [];
for i = 1:698
    x = [x mean(loss_arr((i-1)*116+1:i*116))];
end
% plot(x);

fscore_arr = [];
for i = 1:size(k_fscore,1)
    if ~isempty(cell2mat(k_fscore(i,1)))
        log_mat = cell2mat(log(i));
        fscore = log_mat(1,cell2mat(k_fscore(i,1))+8:size(log_mat,2));
        fscore_num = str2num(fscore);
        fscore_arr = [fscore_arr; fscore_num];
    end
end
% plot(fscore_arr);
