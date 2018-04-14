function imshow3D_clicky( Img, scale )
% function  imshow3D( Img, scale )
% Img can be Img(x,y,t) or Img{r/g/b}(x,y,t)
% By Pengyu Hong @ Brandeis University


if nargin < 2 || isempty( scale )
    if iscell(Img)
        scale = ones(1, length(Img));
    else
        scale = 1;
    end
end    


global InitialCoord;
x = [];
y = [];
SFntSz = 9;

figure( 'Toolbar', 'figure' );
figH = gcf;
imgH = gca;
set( imgH, 'position',[0,0.1,1,1] );
% imgH = axes('position',[0,0.2,1,0.8]);
if iscell( Img )
    imshow( tocolorimg( Img{1}(:,:,1) * scale(1), Img{2}(:,:,1) * scale(2), Img{3}(:,:,1)) * scale(3), [], 'InitialMagnification','fit' );
    sno = size( Img{1}, 3 );
else
    imshow( Img(:,:,1) * scale );
    [xi,yi] = getpts;
    x = [x, xi];
    y = [y, yi];
    sno = size( Img, 3 );
end

FigPos = get(gcf,'Position');
S_Pos = [50 25 uint16(FigPos(3)-100)+1 20];
Stxt_Pos = [50 45 uint16(FigPos(3)-100)+1 15];

if sno > 1
    shand = uicontrol('Style', 'slider', 'Min',1, 'Max',sno, 'Value',1, ...
                      'SliderStep',[1/(sno-1) 10/(sno-1)], 'Position', S_Pos, ...
                      'Callback', {@SliceSlider});
    stxthand = uicontrol('Style', 'text','Position', Stxt_Pos,'String',sprintf('Slice# %d / %d',1, sno), 'BackgroundColor', [0.8 0.8 0.8], 'FontSize', SFntSz);
else
    stxthand = uicontrol('Style', 'text','Position', Stxt_Pos,'String','2D image', 'BackgroundColor', [0.8 0.8 0.8], 'FontSize', SFntSz);
end    

set(gcf, 'WindowScrollWheelFcn', @mouseScroll);
set(gcf, 'ButtonDownFcn', @mouseClick);
set(get(gca,'Children'),'ButtonDownFcn', @mouseClick);
set(gcf,'WindowButtonUpFcn', @mouseRelease)
set(gcf,'ResizeFcn', @figureResized)

% -=< Figure resize callback function >=-
    function figureResized(object, eventdata)
        FigPos = get(gcf,'Position');
        S_Pos = [50 25 uint16(FigPos(3)-100)+1 20];
        Stxt_Pos = [50 45 uint16(FigPos(3)-100)+1 15];
        if sno > 1
            set(shand,'Position', S_Pos);
        end
        set(stxthand,'Position', Stxt_Pos);
    end

% -=< Slice slider callback function >=-
    function SliceSlider(object, eventdata)
        S = round(get(shand,'Value'));
        dcm = datacursormode( figH );
        state = get( dcm, 'Enable' );
        if strcmp( state, 'on' )
            props.Position = get( dcm.CurrentDataCursor, 'Position' );
        end
        axes( imgH );
        xtemp = xlim; ytemp = ylim;
        if iscell( Img )
            imshow( tocolorimg( Img{1}(:,:,S) * scale(1), Img{2}(:,:,S) * scale(2), Img{3}(:,:,S) * scale(3) ), [], 'InitialMagnification','fit' );
        else
            imshow( Img(:,:,S) * scale );
        end
        xlim( imgH, xtemp );
        ylim( imgH, ytemp );
        
        if strcmp( state, 'on' )
            datacursormode( figH, state );
            dcm = datacursormode( figH );
            hDatatip = dcm.createDatatip(imgH, props);
            cc = props.Position(1); rr = props.Position(2);
            if iscell( Img )
                hDatatip.String = sprintf( 'X: %d Y: %d\nRGB: %.3g, %.3g, %.3g', cc, rr, ...
                    Img{1}(rr,cc,S) * scale(1), Img{2}(rr,cc,S) * scale(2), Img{3}(rr,cc,S) * scale(3) );
            else
                hDatatip.String = sprintf( 'X: %d Y: %d\nRGB: %f, %f, %f', cc, rr, ...
                                        Img( rr, cc, S) * scale );
            end
        end
        
        if sno > 1
            set(stxthand, 'String', sprintf('Slice# %d / %d',S, sno));
        else
            set(stxthand, 'String', '2D image');
        end
    end

% -=< Mouse scroll wheel callback function >=-
    function mouseScroll (object, eventdata)
        S = round(get(shand,'Value'));
        UPDN = eventdata.VerticalScrollCount;
        S = S + UPDN;
        if (S < 1)
            S = 1;
        elseif (S > sno)
            S = sno;
        end
        if sno > 1
            set(shand,'Value',S);
            set(stxthand, 'String', sprintf('Slice# %d / %d',S, sno));
        else
            set(stxthand, 'String', '2D image');
        end
        axes( imgH );
        if iscell( Img )
            imshow( tocolorimg( Img{1}(:,:,S) * scale(1), Img{2}(:,:,S) * scale(2), Img{3}(:,:,S)) * scale(3), [], 'InitialMagnification','fit' );
            [xi,yi] = getpts;
        else
            imshow( Img(:,:,S) * scale );
            [xi,yi] = getpts;
        end
    end

% -=< Mouse button released callback function >=-
    function mouseRelease (object,eventdata)
        set(gcf, 'WindowButtonMotionFcn', '')
    end

% -=< Mouse click callback function >=-
    function mouseClick (object, eventdata)
        MouseStat = get(gcbf, 'SelectionType');
        if (MouseStat(1) == 'a')        %   RIGHT CLICK
            InitialCoord = get(0,'PointerLocation');
            set(gcf, 'WindowButtonMotionFcn', @WinLevAdj);
        end
    end

end
