f = figure;
set(f, 'KeyPressFcn', @(x,y)disp(get(f,'CurrentCharacter')))