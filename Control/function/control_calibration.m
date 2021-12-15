function [dudq1, dxdv] = control_calibration (camera, ard)

    setup_dobot;
    for i = 1:4
        pos1 = [261.24,0,126.85];
        move_dobot_with_pos(pos1, ard);
        pos1a = read_dobot_position(ard);
        uv1 = get_duckie_position(camera);

        pos2 = [211.24,0,126.85];
        move_dobot_with_pos(pos2, ard)
        pos2a = read_dobot_position(ard);
        uv2 = get_duckie_position(camera);

        error_uv = uv2-uv1;
        error_pos = pos2a-pos1a;
        dxdv_m(i) = error_pos(1)/error_uv(2);

        q1 = [-10,-1.54,2.9];
        move_dobot_with_angles(q1,ard);
        uv3 = get_duckie_position(camera);
        pos3 = read_dobot_position(ard);

        q = [0,-1.54,2.9];
        move_dobot_with_angles(q,ard);
        uv4 = get_duckie_position(camera);
        pos4 = read_dobot_position(ard);

        q2 = [8,-1.54,2.9];
        move_dobot_with_angles(q2,ard);
        uv5 = get_duckie_position(camera);
        pos5 = read_dobot_position(ard);

        error_uv = uv4-uv3;
        dudq1_m(i) = error_uv(1)/10;

        error_uv = uv5-uv4;

        dudq1_m(i+4) = error_uv(1)/8;
    end
    
    dudq1 = mean(dudq1_m);
    dxdv = mean(dxdv_m);
    
end
