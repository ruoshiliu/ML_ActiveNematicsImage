function coor_collector

clear variables;
% VIDEOROSH
% who knows how the hell this works
% practice shit
 
v = VideoReader('d400um.avi');
k = 0;
% while hasFrame(v)
%     frame = readFrame(v);
%     imshow(frame,'InitialMagnification',180);
%     [xi,yi] = getpts(gca);
%     pts(k).cdata = [xi,yi];
%     k = k+1;
% end
% fr = read(v, 1);
% imshow(fr,'InitialMagnification',180);
% 
% keyboard
 
nframes = v.duration * v.framerate;
pts(nframes).cdata = [];
%  Create and then hide the UI as it is being constructed.
f = figure('Visible','off','Position',[360,500,450,285])

% Construct the components.
nfrms = uicontrol('Style','text','String',['nframes = ' num2str(nframes)],'Position',[725,250,70,25]);
kp1 = uicontrol('Style','pushbutton','String','k+1','Position',[715,220,70,25],'Callback',{@kp1_Callback});
km1 = uicontrol('Style','pushbutton','String','k-1','Position',[715,180,70,25],'Callback',{@km1_Callback});
ktext = uicontrol('Style','text','String','k=','Position',[725,90,60,15]);
kequal = uicontrol('Style','edit','String','0','Position',[715,135,70,25],'Callback',{@kequal_Callback});
enter = uicontrol('Style','pushbutton','String','go to frame k','Position',[725,90,60,15],'Callback',{@gotoK_Callback});
kValue = uicontrol('Style','text','String','k=','Position',[815,235,80,35],'Callback',{@kValue_Callback});
end_button = uicontrol('Style','pushbutton','String','END','Position',[755,260,70,25],'Callback',{@end_Callback});

set(gcf, 'units', 'normalized', 'position', [0.05 0.15 0.65 0.75]);
 
ha = axes('Units','pixels','Position',[50,60,600,500]);
align([nfrms,kp1,km1,ktext,kequal,enter,kValue],'Center','None');

f.Visible = 'on';
 
% Push button callbacks. Each callback plots current_data in the
% specified plot type.
 
function kp1_Callback(source,eventdata) 
% Increase k
    nframe = k + 1;
	k = k + 1;
	i = read(v, nframe);
    set(kValue,'Visible','on','string',num2str(k));
	imshow(i,'InitialMagnification',180);
    if ~isempty(pts(k).cdata)
        x = pts(k).cdata(:,1);
        y = pts(k).cdata(:,2);
        hold on;
        plot(x, y, 'r*', 'LineWidth', 1, 'MarkerSize', 10);
    end
	[xi,yi] = getpts(gcf);
	pts(k).cdata = [xi,yi];
    hold on;
    plot(xi, yi, 'y*', 'LineWidth', 1, 'MarkerSize', 10);
end
 
function km1_Callback(source,eventdata) 
% Decrease k
	if k ~= 1
        nframe = k - 1;
        k = k - 1;
        set(kValue,'Visible','on','string',num2str(k));
        i = read(v, nframe);
        imshow(i,'InitialMagnification',180);
        if ~isempty(pts(k).cdata)
            x = pts(k).cdata(:,1);
            y = pts(k).cdata(:,2);
            hold on;
            plot(x, y, 'r*', 'LineWidth', 1, 'MarkerSize', 10);
        end
        [xi,yi] = getpts(gca);
        pts(k).cdata = [xi,yi];
    end
    hold on;
    plot(xi, yi, 'y*', 'LineWidth', 1, 'MarkerSize', 10);
end
 
function kequal_Callback(source,eventdata,handles) 
% Display contour plot of the currently selected data.
    current_string = get(source, 'String');
    k = str2double(current_string);
end

function kValue_Callback(source,eventdata,handles) 
% Display contour plot of the currently selected data.
	current_string = get(source, 'String');
    set(gcf, 'String', current_string);
end

function gotoK_Callback(source,eventdata) 
% Display contour plot of the currently selected data.
	if k <= nframes & k>=0
        nframe = k;
        set(kValue,'Visible','on','string',num2str(k));
        i = read(v, nframe);
        imshow(i,'InitialMagnification',180);
        if ~isempty(pts(k).cdata)
            x = pts(k).cdata(:,1);
            y = pts(k).cdata(:,2);
            hold on;
            plot(x, y, 'r*', 'LineWidth', 1, 'MarkerSize', 10);
        end
        [xi,yi] = getpts(gca);
        pts(k).cdata = [xi,yi];
    end
end
function end_Callback(source,eventdata) 
    filename = num2str(k) + ".mat";
    name = pwd + "/pts_collected/" + filename;
    save(name,'pts','k');
    close;
end

 
end