function [x,y] = randompointinellipse(a,b,cx,cy,theta,N)

% Generates random point(s) inside ellipse
% INPUT
% a = semi-major axis (if center at 0,0 then it is along x-axis)
% b = semi-minor axis (if center at 0,0 then it is along y-axis)
% cx = x coord of center
% cy = y coord of center
% theta = rotation angle in radians of ellipse
% N = number of points required, must be integer
% OUTPUT
% Nx2 matrix of coord of random points within ellipse
% 1.0 Aug 2017, 2.0, 2.1 Sept 2017, Rod Letchford
% 2.1 update thanks to Ned Gulley
% Tested with Matlab R2017a
% Core idea from:
% https://au.mathworks.com/matlabcentral/newsreader/view_original/212522


% Error catching
if nargin == 3
    N = 1;
elseif nargin == 2
    theta = 0; N = 1;
end
N = abs(round(N)); % Just in case

% Find the points
r = sqrt(rand(N,1)); % sqrt necessary for uniform area distribution
phi = 2*pi*rand(N,1); % phi uniformly distributed from 0 to 2pi
x1 = a*r.*cos(phi) + cx; % Stretch out to an ellipse shape
y1 = b*r.*sin(phi)+ cy;
x = x1*cos(theta) - y1*sin(theta); % Rotate x anticlock by theta radians
y = x1*sin(theta) + y1*cos(theta); % Rotate y anticlock by theta radians