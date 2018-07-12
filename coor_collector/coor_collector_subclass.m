function coor_collector
%% read video information
clear variables;
v = VideoReader('/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/d400um.avi');
nframes = v.duration * v.framerate;
load('/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/pts_collected/sub/7400.mat','pts_pos','pts_neg', 'pts_pos_o', 'pts_neg_b', 'k');
load('/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/pts_collected/pos_neg/7400_sorted.mat','pos', 'neg');


pts_pos_old = pos;
pts_neg_old = neg;
clear pos, neg;
k = 0;
xxx = [];



%% construct GUI
%  Create and then hide the UI as it is being constructed.
f = figure('Visible','off','Position',[520,500,650,350],'KeyPressFcn', @keyPress)

% Construct the components.
pos = get(gcf, 'Position'); % get figure position
left = pos(1);
right = pos(2);
width = pos(3);
height = pos(4);


% Indicator of total frame number
nfrms = uicontrol('Style','text','String',['totalframes = ' num2str(nframes)],'Position',[left+width*1.2,300,100,30]);
% Next frame button
kp1 = uicontrol('Style','pushbutton','String','k+1','Position',[left+width*1.2,270,70,25],'Callback',{@kp1_Callback});
% Last frame button
km1 = uicontrol('Style','pushbutton','String','k-1','Position',[left+width*1.2,240,70,25],'Callback',{@km1_Callback});
% "current="
ktext1 = uicontrol('Style','text','String','current=','Position',[left+width*1.20,220,50,15]);
% Indicator of current frame number
kValue = uicontrol('Style','text','String','0','Position',[left+width*1.28,220,50,15],'Callback',{@kValue_Callback});
% Get userinput and set k accordingly
kequal = uicontrol('Style','edit','String','0','Position',[left+width*1.25,145,70,25],'Callback',{@kequal_Callback});
% Go to frame k
enter = uicontrol('Style','pushbutton','String','go to frame k','Position',[left+width*1.2,120,80,15],'Callback',{@gotoK_Callback});
% End and save
end_button = uicontrol('Style','pushbutton','String','END','BackgroundColor','red','FontWeight','bold','FontSize',14,'Position',[left+width*1.22,400,70,25],'Callback',{@end_Callback});
% "K="
ktext2 = uicontrol('Style','text','String','k=','Position',[left+width*1.20,150,15,15]);
% +1/2 or -1/2
positive = uicontrol('Style','text','FontSize',12.5,'ForegroundColor','b','String','+1/2','Position',[left+width*1.25,350,35,15],'Visible','off');
negative = uicontrol('Style','text','FontSize',12.5,'ForegroundColor','b','String','-1/2','Position',[left+width*1.25,350,35,15],'Visible','off');
set(gcf, 'units', 'normalized', 'position', [0 0 1 1]);
% Subclassify
sub = uicontrol('Style','edit','String','0','Position',[left+width*1.27,500,150,25],'Callback',{@sub_Callback});
% Save subclassification
saveSub = uicontrol('Style','pushbutton','String','save','Position',[left+width*1.2,480,80,15],'Callback',{@saveSub_Callback});
% "Sub Classes"
ktext3 = uicontrol('Style','text','String','pos_o;neg_b','Position',[left+width*1.15,507,70,15]);

% set(f,'KeyPressFcn',@KeyPressCb);
ha = axes('Units','normalized','Position',[0.10,0.05,0.55,0.85]);
align([nfrms,kp1,km1,enter],'Center','None');

f.Visible = 'on';


% Push button callbacks. Each callback plots current_data in the
% specified plot type.
 %% next frame
function kp1_Callback(source,eventdata) 
% Increase k
    nframe = k + 1;
	k = k + 1;
    set(kValue,'Visible','on','string',num2str(k));
    hold off;
    i = read(v, nframe);
    if ~isempty(pts_pos_old(k).cdata)
        txt_pos = 1:size(pts_pos_old(k).cdata,1);
        i = insertText(i, pts_pos_old(k).cdata, txt_pos, 'BoxColor', 'blue', 'TextColor', 'white');
    end
    if ~isempty(pts_neg_old(k).cdata)
        txt_neg = 1:size(pts_neg_old(k).cdata,1);
        i = insertText(i, pts_neg_old(k).cdata, txt_neg,'BoxColor','red', 'TextColor', 'white');
    end
    imshow(i,'InitialMagnification',220);
    display_collect();
end
 %% last frame
function km1_Callback(source,eventdata) 
% Decrease k
    if k ~= 1
        nframe = k - 1;
        k = k - 1;
        set(kValue,'Visible','on','string',num2str(k));
        hold off;
        i = read(v, nframe);
        if ~isempty(pts_pos_old(k).cdata)
            txt_pos = 1:size(pts_pos_old(k).cdata,1);
            i = insertText(i, pts_pos_old(k).cdata, txt_pos, 'BoxColor', 'blue', 'TextColor', 'white');
        end
        if ~isempty(pts_neg_old(k).cdata)
            txt_neg = 1:size(pts_neg_old(k).cdata, 1);
            i = insertText(i, pts_neg_old(k).cdata, txt_neg,'BoxColor','red', 'TextColor', 'white');
        end
        imshow(i,'InitialMagnification',220);
        display_collect();
    end
end
%% go to frame
function gotoK_Callback(source,eventdata) 
% Display contour plot of the currently selected data.
    if k <= nframes && k>=0
        nframe = k;
        set(kValue,'Visible','on','string',num2str(k));
        hold off;
        i = read(v, nframe);
        if ~isempty(pts_pos(k).cdata)
            txt_pos = 1:size(pts_pos(k).cdata,1);
            i = insertText(i, pts_pos(k).cdata, txt_pos, 'BoxColor', 'blue', 'TextColor', 'white');
        end
        if ~isempty(pts_neg(k).cdata)
            txt_neg = 1:size(pts_neg(k).cdata,1);
            i = insertText(i, pts_neg(k).cdata, txt_neg,'BoxColor','red', 'TextColor', 'white');
        end
        imshow(i,'InitialMagnification',220);
        display_collect();
    end
end
    
%%
function kequal_Callback(source,eventdata,handles) 
% Display contour plot of the currently selected data.
    current_string = get(source, 'String');
    k = str2double(current_string);
end
%%
function sub_Callback(source,eventdata,handles) 
% Display contour plot of the currently selected data.
	current_string = get(source, 'String');
    xxx = split(current_string, '.');
end
%% save subclassification coordinates
function saveSub_Callback(source,eventdata) 
% Display contour plot of the currently selected data.
	if size(xxx,1) == 1
        yyy = split(xxx(1),' ');
        yyy = str2num(cell2mat(yyy)); 
        pts_pos_o(k).cdata = pts_pos_old(k).cdata(yyy,:);
        pts_pos(k).cdata = pts_pos_old(k).cdata;
        pts_pos(k).cdata(yyy,:) = []; 
    elseif size(xxx,1) == 2
        yyy = split(xxx(1),' ');
        yyy = str2num(cell2mat(yyy));
        pts_pos_o(k).cdata = pts_pos_old(k).cdata(yyy,:);
        pts_pos(k).cdata = pts_pos_old(k).cdata;
        pts_pos(k).cdata(yyy,:) = [];
        zzz = split(xxx(2),' ');
        zzz = str2num(cell2mat(zzz));
        pts_neg_b(k).cdata = pts_neg_old(k).cdata(zzz,:);
        pts_neg(k).cdata = pts_neg_old(k).cdata;
        pts_neg(k).cdata(zzz,:) = [];
    end
    display();
end
%% 
function kValue_Callback(source,eventdata,handles) 
% Display contour plot of the currently selected data.
	current_string = get(source, 'String');
    set(gcf, 'String', current_string);
end

%% end and save
function end_Callback(source,eventdata) 
%     mkdir pts_collected;
    filename = num2str(k) + ".mat";
    name = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/pts_collected/' + filename;
    save(name,'pts_pos','pts_neg', 'pts_pos_o', 'pts_neg_b','k');
    close;
end
%% display and collect
    function display_collect()
        display();
%         collect();
    end
%% display
    function display()
        hold on;
        if ~isempty(pts_pos(k).cdata)
            x = pts_pos(k).cdata(:,1);
            y = pts_pos(k).cdata(:,2);
            plot(x, y, 'b.', 'LineWidth', 1, 'MarkerSize', 20);
        end
        if ~isempty(pts_neg(k).cdata)
            x = pts_neg(k).cdata(:,1);
            y = pts_neg(k).cdata(:,2);
            plot(x, y, 'r+', 'LineWidth', 1, 'MarkerSize', 10);
        end
        if ~isempty(pts_pos_o(k).cdata)
            x = pts_pos_o(k).cdata(:,1);
            y = pts_pos_o(k).cdata(:,2);
            plot(x, y, 'y.', 'LineWidth', 1, 'MarkerSize', 20);
        end
        if ~isempty(pts_neg_b(k).cdata)
            x = pts_neg_b(k).cdata(:,1);
            y = pts_neg_b(k).cdata(:,2);
            plot(x, y, 'g+', 'LineWidth', 1, 'MarkerSize', 10);
        end
    end
%% collect
    function collect(source, eventdata)
        hold on;
        if waitforbuttonpress == 1 % press any key to start collecting
            positive.Visible = 'on';
            [x_pos,y_pos] = getpts(gca);
            pts_nucb(k).cdata = [x_pos,y_pos];
            positive.Visible = 'off';
%             hold on;
%             negative.Visible = 'on';
%             [x_neg,y_neg] = getpts(gca);
%             pts_neg(k).cdata = [x_neg,y_neg];
%             negative.Visible = 'off';
%             plot(x_neg, y_neg, 'g.', 'LineWidth', 1, 'MarkerSize', 20);
%             plot(x_pos, y_pos, 'y+', 'LineWidth', 1, 'MarkerSize', 10);
        end  
    end
    function keyPress(source, eventdata)
        switch eventdata.Key
            % press rightarrow or d to go to the next frame
            case 'rightarrow'
                kp1_Callback(kp1, []);
            case 'd'
                kp1_Callback(kp1, []);
            % press leftarrow or a to go to the previous frame
            case 'leftarrow'
                km1_Callback(km1, []);
            case 'a'
                km1_Callback(km1, []);
            case 'return'
                saveSub_Callback(saveSub,[]);
            case 'f'
                saveSub_Callback(saveSub,[]);
        end
    end
 
end