%
% pinholecam.m
%
% generates a pinhole camera object
%
% usage: cam=pinholecam(f,rhox,rhoy,u0,v0)
% 
% input: 
% f: focal length
% rhox: width/pixel
% rhoy: height/pixel
% u0,v0: pixel domain location of optical center
% 
% output:
% cam: camera object with attributes f, rhox, rhoy, u0, v0, and
% K=intrinsic camera matrix
% 

function cam=pinholecam(uv0,k)

cam.uv0=uv0;
cam.K=k;

end



