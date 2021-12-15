clear;
addpath 'C:\Users\jacki\Documents\Robotics 1\Robotics1_Group_project\Control\function'
addpath 'C:\Users\jacki\Documents\Robotics 1\Robotics1_Group_project\Object_detection\function'
addpath 'C:\Users\jacki\Documents\Robotics 1\Robotics1_Group_project\Fwd_Inv_kin'

ard = serialport("COM5",9600);
configureTerminator(ard,hex2dec('5A')); % Data package ends with byte 0x5A
camera = webcam('USB Video Device');
%Microsoft® LifeCam HD-5000
[dudq1, dxdv] = control_calibration(camera, ard);
%  dudq1 = 26;
%  dxdv = .22;
disp("You now have 3 seconds to put the duck where you want it to be picked up from")
pause(3)
dobot_scan_for_duck(camera, ard);
move_to_grab_duck(camera, ard, dudq1, dxdv);
current_pos = read_dobot_position(ard);
move_dobot_gripper(-50, ard);
pause(1)
move_dobot_with_pos(current_pos - [0; 0; 20], ard);
pause(1.5)
move_dobot_gripper(0, ard);
pause(.5)
final_position = [215; 0; 110];
move_dobot_with_pos(final_position + [0; 0; 25], ard)
pause(1)
place_location = [186.7639; -156.7141;54.2200];
move_dobot_with_pos(place_location,ard);
pause(1)
move_dobot_gripper(-50, ard);
pause(1)

%target placing postion (left side)
%(186.7639, -156.7141,54.2200)
%right side
%

% pause(.5)
% move_dobot_with_pos(final_position, ard)
% move_dobot_gripper(-45, ard)
% pause(.5)
% move_dobot_with_angles([0, 0, 0], ard)
