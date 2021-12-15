% get the calibration for the camera on the dobot
Intrinsic_calibration;

% 1 is f/pw, 3 is u0, 5 is f/ph, 6 is v0
instrinsic_parameters = K;

% intrinsic camera parameters
u0 = instrinsic_parameters(1, 3);
v0 = instrinsic_parameters(2, 3);
uv0 = [u0; v0];

% phih=atan2(H*rhoh/2,f); % vertical viewing angle range
% phiw=atan2(W*rhow/2,f); % horizontal viewing angle range

% define the camera, save it as cam
cam = pinholecam(uv0,K);
