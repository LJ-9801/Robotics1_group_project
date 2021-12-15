% This function will write to the dobot, given angles and an arduino
% object.  Nothing is returned, but it should configure the four angles of
% the arduino as specified.  Currently, it has no suction and moves the
% joints independently

function move_dobot_with_pos (coord, arduino_obj)


    gripper = read_dobot_angles(arduino_obj);
    gripper = gripper(4);
    
    isGrab = 0; % No suction
    MOVE_MODE_JOINTS = 1;  % joints move independent
    MODE = 3; % move robot with joint angles

    % Set the float values in the data package
    line_float_cmd = zeros(1,10);
    line_float_cmd(1) = MODE; % sets the state to 6
    line_float_cmd(3) = coord(1); % joint one angle
    line_float_cmd(4) = coord(2); % joint two angle
    line_float_cmd(5) = coord(3); % joint three angle
    line_float_cmd(6) = gripper; % joint four angle
    line_float_cmd(7) = isGrab;
    line_float_cmd(8) = MOVE_MODE_JOINTS;

    % Combine datapackage
    header_chr = char(hex2dec('A5'));
    line_chr_cmd = char(typecast(single(line_float_cmd), 'uint8'));
    line_chr_cmd = [header_chr,line_chr_cmd];
    line_str_cmd = convertCharsToStrings(line_chr_cmd);

    % Write out to dobot
    writeline(arduino_obj, line_str_cmd)
    pause(1)
end