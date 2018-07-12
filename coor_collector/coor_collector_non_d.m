function coor_collector
%% read video information
clear variables;
 
v = VideoReader('/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/d400um.avi');
load '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/pts_collected/7400_4c_sorted.mat';
load '/Users/ruoshiliu/Desktop/OneDrive/Github/ML_ActiveNematicsImage/pts_collected/d400um/pts_rand.mat';
k = 0;

nframes = v.duration * v.framerate;
pts_neg = pts_neg;
pts_pos = pts_pos;
pts_nuc = pts_nuc;
pts_pos_o = pts_pos_o;
pts_rand = pts_rand;

%% construct GUI
%  Create and then hide the UI as it is being constructed.
f = figure('Visible','off','Position',[520,500,650,350],'KeyPressFcn', @keyPress)

% Construct the components.
pos_f = get(gcf, 'Position'); % get figure position
left = pos_f(1);
right = pos_f(2);
width = pos_f(3);
height = pos_f(4);


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
    imshow(i,'InitialMagnification',220);
    display();
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
function kValue_Callback(source,eventdata,handles) 
% Display contour plot of the currently selected data.
	current_string = get(source, 'String');
    set(gcf, 'String', current_string);
end

%% end and save
function end_Callback(source,eventdata) 
%     mkdir pts_collected;
    filename = num2str(k) + ".mat";
    name = '/Users/ruoshiliu/Desktop/' + filename;
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
            plot(x, y, 'b.', 'LineWidth', 1, 'MarkerSize', 10);
        end
        if ~isempty(pts_pos(k).cdata)
            x = pts_pos(k).cdata(:,1);
            y = pts_pos(k).cdata(:,2);
            plot(x, y, 'b.', 'LineWidth', 1, 'MarkerSize', 10);
        end
        if ~isempty(pts_pos_o(k).cdata)
            x = pts_pos_o(k).cdata(:,1);
            y = pts_pos_o(k).cdata(:,2);
            plot(x, y, 'b.', 'LineWidth', 1, 'MarkerSize', 10);
        end
        if ~isempty(pts_nuc(k).cdata)
            x = pts_nuc(k).cdata(:,1);
            y = pts_nuc(k).cdata(:,2);
            plot(x, y, 'b.', 'LineWidth', 1, 'MarkerSize', 10);
        end
        if ~isempty(pts_rand(k).cdata)
            x = pts_rand(k).cdata(:,1);
            y = pts_rand(k).cdata(:,2);
            plot(x, y, 'c*', 'LineWidth', 1, 'MarkerSize', 10);
        end
    end
%% collect
    function collect(source, eventdata)
        hold on;

        if waitforbuttonpress == 1 % press any key to start collecting
            positive.Visible = 'on';
            [x_pos,y_pos] = getpts(gca);
            pts_pos(k).cdata = [x_pos,y_pos];
            positive.Visible = 'off';
            hold on;
            negative.Visible = 'on';
            [x_neg,y_neg] = getpts(gca);
            pts_neg(k).cdata = [x_neg,y_neg];
            negative.Visible = 'off';
            plot(x_neg, y_neg, 'g.', 'LineWidth', 1, 'MarkerSize', 20);
            plot(x_pos, y_pos, 'y+', 'LineWidth', 1, 'MarkerSize', 10);
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
        end
    end
 
end