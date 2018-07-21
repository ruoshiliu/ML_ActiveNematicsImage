function coor_collector
%% read video information
clear variables;
 
k = 0;

nframes = 0;

load('/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/train6v1/7450_6c.mat', 'pts_neg', 'pts_pos', 'pts_neg_b', 'pts_pos_o', 'pts_nuc', 'pts_nucb');
neg = pts_neg;
pos = pts_pos;
neg_b = pts_neg_b;
pos_o = pts_pos_o;
nuc = pts_nuc;
nucb = pts_nucb;

clear pts_neg pts_pos pts_neg_b pts_pos_o pts_nuc pts_nucb;



path = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/train6v1/images6v1/';
%% construct GUI
%  Create and then hide the UI as it is being constructed.
f = figure('Visible','off','Position',[320,500,650,350],'KeyPressFcn', @keyPress)

% Construct the components.
posi = get(gcf, 'Position'); % get figure position
left = posi(1);
right = posi(2);
width = posi(3);
height = posi(4);


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
positive = uicontrol('Style','text','FontSize',16,'ForegroundColor','r','String','pos','Position',[left+width*1.24,350,50,25],'Visible','off');
negative = uicontrol('Style','text','FontSize',16,'ForegroundColor','r','String','neg','Position',[left+width*1.24,350,50,25],'Visible','off');
positive_o = uicontrol('Style','text','FontSize',16,'ForegroundColor','r','String','pos_o','Position',[left+width*1.24,350,50,25],'Visible','off');
negative_b = uicontrol('Style','text','FontSize',16,'ForegroundColor','r','String','neg_b','Position',[left+width*1.24,350,50,25],'Visible','off');
nucleation = uicontrol('Style','text','FontSize',16,'ForegroundColor','r','String','nuc','Position',[left+width*1.24,350,50,25],'Visible','off');
nucleation_b = uicontrol('Style','text','FontSize',16,'ForegroundColor','r','String','nucb','Position',[left+width*1.24,350,50,25],'Visible','off');
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
        filename_jpg = [path sprintf('%06.0f',k) '.jpg'];
        i = imread(filename_jpg);
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
        filename_jpg = [path sprintf('%06.0f',k) '.jpg'];
        i = imread(filename_jpg);
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
        filename_jpg = [path sprintf('%06.0f',k) '.jpg'];
        i = imread(filename_jpg);
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
    filename = num2str(k) + "_6c.mat";
    savePath = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/train6v1/';
    name = savePath + filename;
    pts_pos = pos;
    pts_neg = neg;
    pts_pos_o = pos_o;
    pts_neg_b = neg_b;
    pts_nuc = nuc;
    pts_nucb = nucb;
    save(name,'pts_neg', 'pts_pos', 'pts_neg_b', 'pts_pos_o', 'pts_nuc', 'pts_nucb','k');
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
        if ~isempty(neg(k).cdata)
            x = neg(k).cdata(:,1);
            y = neg(k).cdata(:,2);
            plot(x, y, 'y.', 'LineWidth', 1, 'MarkerSize', 10);
            text(x,y,'neg', 'color','red','FontSize',15);
        end
        if ~isempty(pos(k).cdata)
            x = pos(k).cdata(:,1);
            y = pos(k).cdata(:,2);
            plot(x, y, 'y.', 'LineWidth', 1, 'MarkerSize', 10);
            text(x,y,'pos', 'color','green','FontSize',15);
        end
        if ~isempty(pos_o(k).cdata)
            x = pos_o(k).cdata(:,1);
            y = pos_o(k).cdata(:,2);
            plot(x, y, 'y.', 'LineWidth', 1, 'MarkerSize', 10);
            text(x,y,'posEmp', 'color','yellow','FontSize',15);
        end
        if ~isempty(neg_b(k).cdata)
            x = neg_b(k).cdata(:,1);
            y = neg_b(k).cdata(:,2);
            plot(x, y, 'y.', 'LineWidth', 1, 'MarkerSize', 10);
            text(x,y,'negBoun', 'color','white','FontSize',15);
        end
        if ~isempty(nuc(k).cdata)
            x = nuc(k).cdata(:,1);
            y = nuc(k).cdata(:,2);
            plot(x, y, 'y.', 'LineWidth', 1, 'MarkerSize', 10);
            text(x,y,'nuc', 'color','m','FontSize',15);
        end
        if ~isempty(nucb(k).cdata)
            x = nucb(k).cdata(:,1);
            y = nucb(k).cdata(:,2);
            plot(x, y, 'y.', 'LineWidth', 1, 'MarkerSize', 10);
            text(x,y,'nucBoun', 'color','blue','FontSize',15);
        end
    end
%% collect
    function collect(source, eventdata)
        hold on;
        if waitforbuttonpress == 1 % press any key to start collecting
            positive.Visible = 'on';
            [x_pos,y_pos] = getpts(gca);
            pos(k).cdata = [x_pos,y_pos];
            positive.Visible = 'off';
            hold on;
            
            negative.Visible = 'on';
            [x_neg,y_neg] = getpts(gca);
            neg(k).cdata = [x_neg,y_neg];
            negative.Visible = 'off';
            
            hold on;
            
            positive_o.Visible = 'on';
            [x_pos_o,y_pos_o] = getpts(gca);
            pos_o(k).cdata = [x_pos_o,y_pos_o];
            positive_o.Visible = 'off';
            hold on;
            
            negative_b.Visible = 'on';
            [x_neg_b,y_neg_b] = getpts(gca);
            neg_b(k).cdata = [x_neg_b,y_neg_b];
            negative_b.Visible = 'off';
            hold on;
            
            nucleation.Visible = 'on';
            [x_nuc,y_nuc] = getpts(gca);
            nuc(k).cdata = [x_nuc,y_nuc];
            nucleation.Visible = 'off';
            hold on;
            
            nucleation_b.Visible = 'on';
            [x_nucb,y_nucb] = getpts(gca);
            nucb(k).cdata = [x_nucb,y_nucb];
            nucleation_b.Visible = 'off';
            
            plot(x_neg, y_neg, 'y.', 'LineWidth', 1, 'MarkerSize', 10);
            text(x_neg,y_neg,'neg', 'color','red','FontSize',15);
            
            plot(x_pos, y_pos, 'y.', 'LineWidth', 1, 'MarkerSize', 10);
            text(x_pos,y_pos,'pos', 'color','green','FontSize',15);
            
            plot(x_pos_o, y_pos_o, 'y.', 'LineWidth', 1, 'MarkerSize', 10);
            text(x_pos_o,y_pos_o,'posEmp', 'color','yellow','FontSize',15);
            
            plot(x_neg_b, y_neg_b, 'y.', 'LineWidth', 1, 'MarkerSize', 10);
            text(x_neg_b,y_neg_b,'negBoun', 'color','white','FontSize',15);

            plot(x_nuc, y_nuc, 'y.', 'LineWidth', 1, 'MarkerSize', 10);
            text(x_nuc,y_nuc,'nuc', 'color','m','FontSize',15);

            plot(x_nucb, y_nucb, 'y.', 'LineWidth', 1, 'MarkerSize', 10);
            text(x_nucb,y_nucb,'nucBoun', 'color','blue','FontSize',15);
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