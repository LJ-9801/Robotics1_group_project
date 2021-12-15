% This will create a duckie object image based on points - starting with
% representing duckie as a block with the same dimensions

%% Define vectors: units are mm

z = 4.25*10;
x=5*10;
y=5.5*10;
px = 10.5*25.4;
py = 0*25.4;
l = 20;


%points in z
az = [(0:z/(l/2):z) (z:-z/(l/2):0)];
az = [az(1:11) az(13:end)];

%array 1
%points in y & x
a1x = zeros(1,length(az))+px;
a1y = (py-y/2:y/20:py+y/2);
a1 = [a1x;a1y;az];

%array2
%points in y & x
a2y = zeros(1,length(az))+py;
a2x = (px-x/2:x/20:px+x/2);
a2 = [a2x;a2y;az];

P0 = [a1 a2];
scatter3(P0(1, :), P0(2, :), P0(3, :))
view(0, 90)

%% notes
%duckie z=4.25 cm
%       x=5  cm
%       y=5.5  cm
%       px = 11inches
%       py = 0.5 inches