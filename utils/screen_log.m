log = importdata('/Users/ruoshiliu/Desktop/train_6-28/screen.log',',');
k = [];
for i = 1:size(log,1)
    k = [k; strfind(log(i,:), 'total')];
end
loss_arr = [];
loss_arr = []
for i = 1:size(k,1)
    if ~isempty(cell2mat(k(i,1)))
        log_mat = cell2mat(log(i));
        loss = log_mat(1,cell2mat(k(i,1))+6:size(log_mat,2));
        loss_num = str2num(loss);
        loss_arr = [loss_arr; loss_num];
    end
end
plot(loss_arr);