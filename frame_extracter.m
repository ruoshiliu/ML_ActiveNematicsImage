%% Setup
% Create a temporary working folder to store the image sequence.
%%
workingDir = '/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/images';
%% Create VideoReader
% Create a VideoReader to use for reading frames from the file.
%%
shuttleVideo = VideoReader('/Users/ruoshiliu/Desktop/OneDrive/Summer Project 2018/d400um.avi');
%% Create the Image Sequence
% Loop through the video, reading each frame into a width-by-height-by-3 array 
% named |img|. Write out each image to a JPEG file with a name in the form |imgN.jpg|, 
% where N is the frame number.
% 
% |      img001.jpg|
% 
% |      img002.jpg|
% 
% |      ...|
% 
% |      img121.jpg|
%%
ii = 1;

while hasFrame(shuttleVideo)
   img = readFrame(shuttleVideo);
   filename = [sprintf('%06.0f',ii) '.jpg'];
   fullname = fullfile(workingDir,filename);
   imwrite(img,fullname)    % Write out to a JPEG file (img1.jpg, img2.jpg, etc.)
   ii = ii+1;
end