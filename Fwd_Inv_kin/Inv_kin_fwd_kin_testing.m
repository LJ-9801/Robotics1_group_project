clear all;

addpath 'C:\Users\jacki\Documents\Robotics 1\Robotics1_Group_project'
addpath 'C:\Users\jacki\Documents\Robotics 1\Robotics1_Group_project\Dobot_arduino_commend'
addpath 'C:\Users\jacki\Documents\Robotics 1\Robotics1_Group_project\Fwd_Inv_kin\function'

ard = serialport("COM5",9600);
configureTerminator(ard,hex2dec('5A'));

setup_dobot;
%define space
qgen = zeros(3,50);
qtest = zeros(3,50);

p_fwd = zeros(3,50);
p_read = zeros(3,50);

%generate 50 random angles qgen
%compute forward kinematics on dobot model
%obtain dobot.T
%move dobot and read end effector postion
%re-construct dobot.T using reading values
%compute inverse kinematics to obtain qtest
for i=1:50
    q = dobot_random_angles;
    qgen(:,i)=q(1:3);
    move_dobot_with_angles(qgen(:,i)',ard);
    dobot.q = qgen(:,i)*pi/180;
    dobot = my_forward_kinematics(dobot);
    p_fwd(:,i) = dobot.T(1:3,4);
    pause(1)
    p_read(:,i) = read_dobot_position(ard);
    R = rotation_due_to_pos(p_read(:,i));
    dobot.T = [R p_read(:,i);[0 0 0 1]];
    dobot = inv_kin(dobot);
    qtest(:,i) = dobot.q;
    pause(1)
end

