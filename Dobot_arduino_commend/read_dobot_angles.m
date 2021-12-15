% This function takes in an arduino object and returns the angles of the
% dobot connected through that arduino

function angles = read_dobot_angles(arduino_obj)
    flush(arduino_obj);
    line_str = readline(arduino_obj); % MATLAB returns readline as string
    pause(.1)
    line_str = readline(arduino_obj); % MATLAB returns readline as string
    line_chr = convertStringsToChars(line_str); % convert the string to char array

    line_float = typecast(uint8(line_chr(2:end)), 'single'); % obtain the 10 float(single) values in the data package

    angles = zeros(6, 1);

    angles(6) = line_float(4); % Rotation value (Relative rotation angle of the end effector to the base)
    angles(1) = line_float(5); % Base Angle 
    angles(2) = line_float(6); % Rear Arm Angle 
    angles(3) = line_float(7); % Fore Arm Angle
    angles(4) = line_float(8); % Servo Angle (joint 4 angle)

    angles(5) = line_float(10); % Gripper Angle 
end