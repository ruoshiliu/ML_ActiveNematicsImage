load '/Users/ruoshiliu/Desktop/OneDrive/Github/ML_ActiveNematicsImage/pts_collected/d400um/7400.mat'

sample_size = 80;
height = 748;
width = 736;
bbox_size = 80;
for i = 1:count
    label = [];
    for k = 1:size(pos(i).cdata,1)
        x = pos(i).cdata(k,1)/ width;
        y = (height - pos(i).cdata(k,2) + bbox_size/2) / height;
        w = bbox_size;
        h = bbox_size;
        label = [label, '1 ', num2str(x), ' ', num2str(y), ' ', num2str(w), ' ', num2str(h), ' '];
    end
    for k = 1:size(neg(i).cdata,1)
        x = (neg(i).cdata(k,1) - bbox_size/2) / width;
        y = (height - neg(i).cdata(k,2) + bbox_size/2) / height;
        w = bbox_size;
        h = bbox_size;
        label = [label, '-1 ', num2str(x), ' ', num2str(y), ' ', num2str(w), ' ', num2str(h)];
    end
    image_name = strcat('labels/', 'labels', num2str(i), '.txt');
    if ~isempty(label)
        fid = fopen(image_name,'wt');
        fprintf(fid, label);
        fclose(fid);
    end
end