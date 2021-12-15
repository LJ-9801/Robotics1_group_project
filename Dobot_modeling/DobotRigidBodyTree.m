clear all
hold on

addpath 'C:\Users\jacki\Documents\Robotics 1\Robotics1_Group_project\Camera_Calibration'
addpath 'C:\Users\jacki\Documents\Robotics 1\Robotics1_Group_project\Dobot_modeling\function'
addpath 'C:\Users\jacki\Documents\Robotics 1\Robotics1_Group_project\Camera_Calibration\function'

zz=zeros(3,1); ex = [1;0;0]; ey = [0;1;0]; ez = [0;0;1];

cam_def;
duckie_model;

P_0B=[0;0;0];
% translation of the camera frame origin from end effector frame (assuming
% same orientation) represented in the end effector frame
P_TC=[30;0;100];
% ****

T_TC=[[ey, ex, -ez],P_TC ;[0 0 0 1]];

% Robot location (B-frame) with respect to the reference frame
T_0B=eye(4);

% H
h1=ez;
h2=ey;
h3=ey;
h4=ey;

q1in = 0;
q2in = 0;
q3in = 0;
%q
q1 = q1in*pi/180;
q2 = q2in*pi/180;
q3 = (q3in-q2in)*pi/180;
q4 = -q2-q3;

q = [q1;q2;q3;q4];

% Final transformation

dobot.P=[[0; 0; 100], [0; 0; 0], [0; 0; 135], [160; 0; 0], [55; 0; -100]];
dobot.H=[h1 h2 h3 h4];
dobot.q = q;
dobot.joint_type=[0 0 0 0];

% define collision body for abb 1200
radius=.5;
%POE
dobot = my_forward_kinematics(dobot);
POE_fwdkin = dobot.T;
disp(POE_fwdkin)
T_0C = dobot.T*T_TC;
[uv,uvw,P1]=cam_image(cam,T_0C,P0);

dobot_rbt=defineRobot(dobot,radius);

figure(99)
show(dobot_rbt,'Collisions','on')
hold on
plot3(P0(1,:),P0(2,:),P0(3,:),'x','LineWidth',1);
axis([-600 600 -600 600 0 500])

figure(50);plot(uv(1,:),uv(2,:),'x','LineWidth',1)
hold on
grid on
xlabel('image plane horizontal axis');
ylabel('image plane vertical axis'); 
p0C=T_0C(1:3,4);
title(['camera frame location: ',...
    '[',num2str(p0C(1)),',',num2str(p0C(2)),',',num2str(p0C(3)),']']);
axis([0 cam.uv0(1)*2 0 cam.uv0(2)*2]);
    % show image plane by flipping x axis
set ( gca, 'xdir', 'reverse' )



