% mkdir VOCdevkit;
% cd VOCdevkit;
% mkdir VOC2007;
% cd VOC2007;
% mkdir Annotations;
% cd Annotations;
load '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/pts_collected/7400_5c_background.mat'
sample_size = 55;
height = 748;
width = 736;

size_pos = 80;
size_neg = 100;
size_pos_o = 120;
size_nuc = 120;
% size_rand = 100; % negative box size
for i = 1:7400
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
    width_text = docNode.createTextNode(num2str(width));
    width_node.appendChild(width_text);

    height_node = docNode.createElement('height');
    size_node.appendChild(height_node);
    height_text = docNode.createTextNode(num2str(height));
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
    num_pos = size(pts_pos(i).cdata,1);
    num_neg = size(pts_neg(i).cdata,1);
    num_pos_o = size(pts_pos_o(i).cdata,1);
%     num_neg_b = size(pts_neg_b(i).cdata,1);
    num_nuc = size(pts_nuc(i).cdata,1);
%     num_nucb = size(pts_nucb(i).cdata,1);
    num_rand = size(pts_rand(i).cdata,1);
%% pos    
    for k1 = 1:num_pos
        pos_i = pts_pos(i).cdata(k1,:);
        xmin = round(pos_i(1)-size_pos/2);
        xmax = round(pos_i(1)+size_pos/2);
        ymin = round(height - pos_i(2) - size_pos/2);
        ymax = round(height - pos_i(2) + size_pos/2);
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
%% neg
    for k2 = 1:num_neg
        neg_i = pts_neg(i).cdata(k2,:);
        xmin = round(neg_i(1)-size_neg/2);
        xmax = round(neg_i(1)+size_neg/2);
        ymin = round(height - neg_i(2) - size_neg/2);
        ymax = round(height - neg_i(2) + size_neg/2);
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
%% pos_o
    for k3 = 1:num_pos_o
        pos_o_i = pts_pos_o(i).cdata(k3,:);
        xmin = round(pos_o_i(1)-size_pos_o/2);
        xmax = round(pos_o_i(1)+size_pos_o/2);
        ymin = round(height - pos_o_i(2) - size_pos_o/2);
        ymax = round(height - pos_o_i(2) + size_pos_o/2);
        object_node = docNode.createElement('object');
        docNode.getDocumentElement.appendChild(object_node);
        
        name_node = docNode.createElement('name');
        object_node.appendChild(name_node);
        name_text = docNode.createTextNode('pos_o');
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
% %% neg_b
%     for k4 = 1:num_neg_b
%         size_neg_b = 100; % negative box size
%         neg_b_i = pts_neg_b(i).cdata(k4,:);
%         xmin = round(neg_b_i(1)-size_neg_b/2);
%         xmax = round(neg_b_i(1)+size_neg_b/2);
%         ymin = round(height - neg_b_i(2) - size_neg_b/2);
%         ymax = round(height - neg_b_i(2) + size_neg_b/2);
%         object_node = docNode.createElement('object');
%         docNode.getDocumentElement.appendChild(object_node);
%         
%         name_node = docNode.createElement('name');
%         object_node.appendChild(name_node);
%         name_text = docNode.createTextNode('neg_b');
%         name_node.appendChild(name_text);
%         
%         pose_node = docNode.createElement('pose');
%         object_node.appendChild(pose_node);
%         pose_text = docNode.createTextNode('Unspecified');
%         pose_node.appendChild(pose_text);
%         
%         truncated_node = docNode.createElement('truncated');
%         object_node.appendChild(truncated_node);
%         truncated_text = docNode.createTextNode('0');
%         truncated_node.appendChild(truncated_text);
%         
%         difficult_node = docNode.createElement('difficult');
%         object_node.appendChild(difficult_node);
%         difficult_text = docNode.createTextNode('0');
%         difficult_node.appendChild(difficult_text);
%         
%         %% bounding box
%         bndbox_node = docNode.createElement('bndbox');
%         object_node.appendChild(bndbox_node);
%         
%         xmin_node = docNode.createElement('xmin');
%         bndbox_node.appendChild(xmin_node);
%         xmin_text = docNode.createTextNode(num2str(xmin));
%         xmin_node.appendChild(xmin_text);
%         
%         ymin_node = docNode.createElement('ymin');
%         bndbox_node.appendChild(ymin_node);
%         ymin_text = docNode.createTextNode(num2str(ymin));
%         ymin_node.appendChild(ymin_text);
%         
%         xmax_node = docNode.createElement('xmax');
%         bndbox_node.appendChild(xmax_node);
%         xmax_text = docNode.createTextNode(num2str(xmax));
%         xmax_node.appendChild(xmax_text);
%         
%         ymax_node = docNode.createElement('ymax');
%         bndbox_node.appendChild(ymax_node);
%         ymax_text = docNode.createTextNode(num2str(ymax));
%         ymax_node.appendChild(ymax_text);
%         
%     end
%% nuc
    for k5 = 1:num_nuc
        nuc_i = pts_nuc(i).cdata(k5,:);
        xmin = round(nuc_i(1)-size_nuc/2);
        xmax = round(nuc_i(1)+size_nuc/2);
        ymin = round(height - nuc_i(2) - size_nuc/2);
        ymax = round(height - nuc_i(2) + size_nuc/2);
        object_node = docNode.createElement('object');
        docNode.getDocumentElement.appendChild(object_node);
        
        name_node = docNode.createElement('name');
        object_node.appendChild(name_node);
        name_text = docNode.createTextNode('nuc');
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
% %% nucb
%     for k6 = 1:num_nucb
%         size_nucb = 100; % negative box size
%         nucb_i = pts_nucb(i).cdata(k6,:);
%         xmin = round(nucb_i(1)-size_nucb/2);
%         xmax = round(nucb_i(1)+size_nucb/2);
%         ymin = round(height - nucb_i(2) - size_nucb/2);
%         ymax = round(height - nucb_i(2) + size_nucb/2);
%         object_node = docNode.createElement('object');
%         docNode.getDocumentElement.appendChild(object_node);
%         
%         name_node = docNode.createElement('name');
%         object_node.appendChild(name_node);
%         name_text = docNode.createTextNode('nucb');
%         name_node.appendChild(name_text);
%         
%         pose_node = docNode.createElement('pose');
%         object_node.appendChild(pose_node);
%         pose_text = docNode.createTextNode('Unspecified');
%         pose_node.appendChild(pose_text);
%         
%         truncated_node = docNode.createElement('truncated');
%         object_node.appendChild(truncated_node);
%         truncated_text = docNode.createTextNode('0');
%         truncated_node.appendChild(truncated_text);
%         
%         difficult_node = docNode.createElement('difficult');
%         object_node.appendChild(difficult_node);
%         difficult_text = docNode.createTextNode('0');
%         difficult_node.appendChild(difficult_text);
%         
%         %% bounding box
%         bndbox_node = docNode.createElement('bndbox');
%         object_node.appendChild(bndbox_node);
%         
%         xmin_node = docNode.createElement('xmin');
%         bndbox_node.appendChild(xmin_node);
%         xmin_text = docNode.createTextNode(num2str(xmin));
%         xmin_node.appendChild(xmin_text);
%         
%         ymin_node = docNode.createElement('ymin');
%         bndbox_node.appendChild(ymin_node);
%         ymin_text = docNode.createTextNode(num2str(ymin));
%         ymin_node.appendChild(ymin_text);
%         
%         xmax_node = docNode.createElement('xmax');
%         bndbox_node.appendChild(xmax_node);
%         xmax_text = docNode.createTextNode(num2str(xmax));
%         xmax_node.appendChild(xmax_text);
%         
%         ymax_node = docNode.createElement('ymax');
%         bndbox_node.appendChild(ymax_node);
%         ymax_text = docNode.createTextNode(num2str(ymax));
%         ymax_node.appendChild(ymax_text);
%         
%     end
% %% rand
%     for k5 = 1:num_rand
%         rand_i = pts_rand(i).cdata(k5,:);
%         xmin = round(rand_i(1)-size_rand/2);
%         xmax = round(rand_i(1)+size_rand/2);
%         ymin = round(height - rand_i(2) - size_rand/2);
%         ymax = round(height - rand_i(2) + size_rand/2);
%         object_node = docNode.createElement('object');
%         docNode.getDocumentElement.appendChild(object_node);
%         
%         name_node = docNode.createElement('name');
%         object_node.appendChild(name_node);
%         name_text = docNode.createTextNode('rand');
%         name_node.appendChild(name_text);
%         
%         pose_node = docNode.createElement('pose');
%         object_node.appendChild(pose_node);
%         pose_text = docNode.createTextNode('Unspecified');
%         pose_node.appendChild(pose_text);
%         
%         truncated_node = docNode.createElement('truncated');
%         object_node.appendChild(truncated_node);
%         truncated_text = docNode.createTextNode('0');
%         truncated_node.appendChild(truncated_text);
%         
%         difficult_node = docNode.createElement('difficult');
%         object_node.appendChild(difficult_node);
%         difficult_text = docNode.createTextNode('0');
%         difficult_node.appendChild(difficult_text);
%         
%         %% bounding box
%         bndbox_node = docNode.createElement('bndbox');
%         object_node.appendChild(bndbox_node);
%         
%         xmin_node = docNode.createElement('xmin');
%         bndbox_node.appendChild(xmin_node);
%         xmin_text = docNode.createTextNode(num2str(xmin));
%         xmin_node.appendChild(xmin_text);
%         
%         ymin_node = docNode.createElement('ymin');
%         bndbox_node.appendChild(ymin_node);
%         ymin_text = docNode.createTextNode(num2str(ymin));
%         ymin_node.appendChild(ymin_text);
%         
%         xmax_node = docNode.createElement('xmax');
%         bndbox_node.appendChild(xmax_node);
%         xmax_text = docNode.createTextNode(num2str(xmax));
%         xmax_node.appendChild(xmax_text);
%         
%         ymax_node = docNode.createElement('ymax');
%         bndbox_node.appendChild(ymax_node);
%         ymax_text = docNode.createTextNode(num2str(ymax));
%         ymax_node.appendChild(ymax_text);
%         
%     end
    name = sprintf('%06.0f.xml',i);
    filename = strcat('/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/VOC_file/VOCdevkit_4c/VOC2007/Annotations/', name);
    xmlwrite(filename, docNode)
end


        
        
    



