% mkdir VOCdevkit;
% cd VOCdevkit;
% mkdir VOC2007;
% cd VOC2007;
% mkdir Annotations;
% cd Annotations;
load '/Users/ruoshiliu/Desktop/OneDrive/Github/ML_ActiveNematicsImage/pts_collected/d400um/7400.mat'
sample_size = 80;
height = 748;
width = 736;

for i = 1:count
    docNode = com.mathworks.xml.XMLUtils.createDocument('annotation');
    %% folder
    folder_node = docNode.createElement('folder');
    docNode.getDocumentElement.appendChild(folder_node);
    folder_text = docNode.createTextNode('VOC2007');
    folder_node.appendChild(folder_text);
    %% filename
    filename_node = docNode.createElement('filename');
    docNode.getDocumentElement.appendChild(filename_node);
    filename_text = docNode.createTextNode('000001.jpg');
    filename_node.appendChild(filename_text);
    %% source
    source_node = docNode.createElement('source');
    docNode.getDocumentElement.appendChild(source_node);

    database_node = docNode.createElement('database');
    source_node.appendChild(database_node);
    database_text = docNode.createTextNode('The VOC2007 Database');
    database_node.appendChild(database_text);

    annotation_node = docNode.createElement('annotation');
    source_node.appendChild(annotation_node);
    annotation_text = docNode.createTextNode('PASCAL VOC2007');
    annotation_node.appendChild(annotation_text);

    image_node = docNode.createElement('image');
    source_node.appendChild(image_node);
    image_text = docNode.createTextNode('flickr');
    image_node.appendChild(image_text);

    flickrid_node = docNode.createElement('flickrid');
    source_node.appendChild(flickrid_node);
    flickrid_text = docNode.createTextNode('?');
    flickrid_node.appendChild(flickrid_text);
    %% owner
    owner_node = docNode.createElement('owner');
    docNode.getDocumentElement.appendChild(owner_node);

    flickrid_node = docNode.createElement('flickrid');
    owner_node.appendChild(flickrid_node);
    flickrid_text = docNode.createTextNode('?');
    flickrid_node.appendChild(flickrid_text);

    name_node = docNode.createElement('name');
    owner_node.appendChild(name_node);
    name_text = docNode.createTextNode('rliu');
    name_node.appendChild(name_text);
    %% size
    size_node = docNode.createElement('size');
    docNode.getDocumentElement.appendChild(size_node);

    width_node = docNode.createElement('width');
    size_node.appendChild(width_node);
    width_text = docNode.createTextNode('736');
    width_node.appendChild(width_text);

    height_node = docNode.createElement('height');
    size_node.appendChild(height_node);
    height_text = docNode.createTextNode('748');
    height_node.appendChild(height_text);

    depth_node = docNode.createElement('depth');
    size_node.appendChild(depth_node);
    depth_text = docNode.createTextNode('1');
    depth_node.appendChild(depth_text);
    %% segmented
    segmented_node = docNode.createElement('segmented');
    docNode.getDocumentElement.appendChild(segmented_node);
    segmented_text = docNode.createTextNode('0');
    segmented_node.appendChild(segmented_text);
    %% object
    num_pos = size(pos(i).cdata,1);
    num_neg = size(neg(i).cdata,1);
    for k1 = 1:num_pos
        pos_i = pos(i).cdata(k1,:);
        xmin = pos_i(1)-sample_size/2;
        xmax = pos_i(1)+sample_size/2;
        ymin = height - pos_i(2) - sample_size/2;
        ymax = height - pos_i(2) + sample_size/2;
        object_node = docNode.createElement('object');
        docNode.getDocumentElement.appendChild(object_node);
        
        name_node = docNode.createElement('name');
        object_node.appendChild(name_node);
        name_text = docNode.createTextNode('pos');
        name_node.appendChild(name_text);
        
        pose_node = docNode.createElement('pose');
        object_node.appendChild(pose_node);
        pose_text = docNode.createTextNode('Unspecified');
        pose_node.appendChild(pose_text);
        
        truncated_node = docNode.createElement('truncated');
        object_node.appendChild(truncated_node);
        truncated_text = docNode.createTextNode('0');
        truncated_node.appendChild(truncated_text);
        
        difficult_node = docNode.createElement('difficult');
        object_node.appendChild(difficult_node);
        difficult_text = docNode.createTextNode('0');
        difficult_node.appendChild(difficult_text);
        
        %% bounding box
        bndbox_node = docNode.createElement('bndbox');
        object_node.appendChild(bndbox_node);
        
        xmin_node = docNode.createElement('xmin');
        bndbox_node.appendChild(xmin_node);
        xmin_text = docNode.createTextNode(num2str(xmin));
        xmin_node.appendChild(xmin_text);
        
        ymin_node = docNode.createElement('ymin');
        bndbox_node.appendChild(ymin_node);
        ymin_text = docNode.createTextNode(num2str(ymin));
        ymin_node.appendChild(ymin_text);
        
        xmax_node = docNode.createElement('xmax');
        bndbox_node.appendChild(xmax_node);
        xmax_text = docNode.createTextNode(num2str(xmax));
        xmax_node.appendChild(xmax_text);
        
        ymax_node = docNode.createElement('ymax');
        bndbox_node.appendChild(ymax_node);
        ymax_text = docNode.createTextNode(num2str(ymax));
        ymax_node.appendChild(ymax_text);
        
    end
    
    for k2 = 1:num_neg
        neg_i = neg(i).cdata(k2,:);
        xmin = neg_i(1)-sample_size/2;
        xmax = neg_i(1)+sample_size/2;
        ymin = height - neg_i(2) - sample_size/2;
        ymax = height - neg_i(2) + sample_size/2;
        object_node = docNode.createElement('object');
        docNode.getDocumentElement.appendChild(object_node);
        
        name_node = docNode.createElement('name');
        object_node.appendChild(name_node);
        name_text = docNode.createTextNode('neg');
        name_node.appendChild(name_text);
        
        pose_node = docNode.createElement('pose');
        object_node.appendChild(pose_node);
        pose_text = docNode.createTextNode('Unspecified');
        pose_node.appendChild(pose_text);
        
        truncated_node = docNode.createElement('truncated');
        object_node.appendChild(truncated_node);
        truncated_text = docNode.createTextNode('0');
        truncated_node.appendChild(truncated_text);
        
        difficult_node = docNode.createElement('difficult');
        object_node.appendChild(difficult_node);
        difficult_text = docNode.createTextNode('0');
        difficult_node.appendChild(difficult_text);
        
        %% bounding box
        bndbox_node = docNode.createElement('bndbox');
        object_node.appendChild(bndbox_node);
        
        xmin_node = docNode.createElement('xmin');
        bndbox_node.appendChild(xmin_node);
        xmin_text = docNode.createTextNode(num2str(xmin));
        xmin_node.appendChild(xmin_text);
        
        ymin_node = docNode.createElement('ymin');
        bndbox_node.appendChild(ymin_node);
        ymin_text = docNode.createTextNode(num2str(ymin));
        ymin_node.appendChild(ymin_text);
        
        xmax_node = docNode.createElement('xmax');
        bndbox_node.appendChild(xmax_node);
        xmax_text = docNode.createTextNode(num2str(xmax));
        xmax_node.appendChild(xmax_text);
        
        ymax_node = docNode.createElement('ymax');
        bndbox_node.appendChild(ymax_node);
        ymax_text = docNode.createTextNode(num2str(ymax));
        ymax_node.appendChild(ymax_text);
        
    end
    name = sprintf('%06.0f.xml',i);
    filename = strcat('/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit/VOC2007/Annotations/', name);
    xmlwrite(filename, docNode)
end
        
        
    



