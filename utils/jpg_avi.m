 v = VideoWriter('newfile.avi','Uncompressed AVI');
 open(v);
 
 for k=1:1000      % assumes 10 images to write to file
     filename = [sprintf('%06.0f',k) '.jpg'];
     writeVideo(v,imread(filename));
 end
 close(v);