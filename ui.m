v = VideoReader('d400um.avi');
fig_h = readFrame(v);

function  KeyPress(~)
clc
clear

%// Test image
b = imread('peppers.png');

fig_h = figure('Position',[200 200 500 500],'Units','Pixel');

%// Create pushbutton and define its callback
hButton = uicontrol('style','push','Position',[20 20 60 30],'String','Get Points','Callback',@(s,e) keypressCB)

hold on;
imshow(b);

    function keypressCB       
        [x, y] = getpts(fig_h) 
    end

end