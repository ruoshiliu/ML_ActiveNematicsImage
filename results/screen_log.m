log = importdata('/Users/ruoshiliu/Desktop/tests/d400_last2000/screen_6c.log',',');
k = [];
for i = 1:size(log,1)
    k = [k; strfind(log(i,:), 'total')];
end
loss_arr = [];
for i = 1:size(k,1)
    if ~isempty(cell2mat(k(i,1)))
        log_mat = cell2mat(log(i));
        loss = log_mat(1,cell2mat(k(i,1))+6:size(log_mat,2));
        loss_num = str2num(loss);
        loss_arr = [loss_arr; loss_num];
    end
end
plot(loss_arr);

x = [];
for i = 1:690
    x = [x mean(loss_arr((i-1)*116+1:i*116))];
end
plot(x);