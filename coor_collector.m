function coor_collector
%% read video information
clear variables;
 
v = VideoReader('d400um.avi');
k = 0;

nframes = v.duration * v.framerate;
pts_pos(nframes).cdata = [];
pts_neg(nframes).cdata = [];
%% construct GUI
%  Create and then hide the UI as it is being constructed.
f = figure('Visible','off','Position',[360,500,650,350])

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
end_button = uicontrol('Style','pushbutton','String','END','BackgroundColor','red','FontWeight','bold','FontSize',14,'Position',[left+width*1.2,800,70,25],'Callback',{@end_Callback});
% "K="
ktext2 = uicontrol('Style','text','String','k=','Position',[left+width*1.20,150,15,15]);
set(gcf, 'units', 'normalized', 'position', [0 0 1 1]);
 
ha = axes('Units','normalized','Position',[0.05,0.05,0.5,0.8]);
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
    i = read(v, nframe);
    imshow(i,'InitialMagnification',200);
    display_collect();
end
 %% last frame
function km1_Callback(source,eventdata) 
% Decrease k
    if k ~= 1
        nframe = k - 1;
        k = k - 1;
        set(kValue,'Visible','on','string',num2str(k));
        i = read(v, nframe);
        imshow(i,'InitialMagnification',200);
        display_collect();
    end
end
%% go to frame
function gotoK_Callback(source,eventdata) 
% Display contour plot of the currently selected data.
    if k <= nframes && k>=0
        nframe = k;
        set(kValue,'Visible','on','string',num2str(k));
        i = read(v, nframe);
        imshow(i,'InitialMagnification',200);
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
function kValue_Callback(source,eventdata,handles) 
% Display contour plot of the currently selected data.
	current_string = get(source, 'String');
    set(gcf, 'String', current_string);
end

%% end and save
function end_Callback(source,eventdata) 
    filename = num2str(k) + ".mat";
    name = pwd + "/pts_collected/" + filename;
    save(name,'pts_pos','pts_neg','k');
    close;
end
%% display and collect
    function display_collect()
        display();
        collect();
    end
%% display
    function display()
        hold on;
        if ~isempty(pts_neg(k).cdata)
            x = pts_neg(k).cdata(:,1);
            y = pts_neg(k).cdata(:,2);
            plot(x, y, 'b.', 'LineWidth', 1, 'MarkerSize', 20);
        end
        if ~isempty(pts_pos(k).cdata)
            x = pts_pos(k).cdata(:,1);
            y = pts_pos(k).cdata(:,2);
            plot(x, y, 'r+', 'LineWidth', 1, 'MarkerSize', 10);
        end
    end
%% collect
    function collect()
        hold on;
        [x_pos,y_pos] = getpts(gca);
        pts_pos(k).cdata = [x_pos,y_pos];
        hold on;
        [x_neg,y_neg] = getpts(gca);
        pts_neg(k).cdata = [x_neg,y_neg];
        plot(x_neg, y_neg, 'g.', 'LineWidth', 1, 'MarkerSize', 20);
        plot(x_pos, y_pos, 'y+', 'LineWidth', 1, 'MarkerSize', 10);
    end   
 
end