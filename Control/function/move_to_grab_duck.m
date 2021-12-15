function move_to_grab_duck(camera, ard, dudq1, dxdv)
      target_uv = [387.5;376.5];
      for i = 1:3
        % this value is where we want the duck to be positioned in camera so
        % that it is directly under the gripper
        % determine error in u direction
        uvtest = get_duckie_position(camera);
        error_u = uvtest(1)-target_uv(1);
        disp(error_u);

        % move the dobot to account for this u error (by angle q1)
        current_angles = read_dobot_angles(ard);
        %k = 1 / (2 * (i - 1) * (i^2) + 1);
        q1t = error_u*(1/dudq1);
        test_angles = current_angles(1:3);
        if abs(q1t) <= 1
           disp(q1t)
           move_dobot_with_angles(test_angles, ard);
           pause(1.5) 
        else
            disp(q1t)
            testq1_offset = -q1t;
            test_angles(1) = test_angles(1) + testq1_offset;
            move_dobot_with_angles(test_angles, ard);
            pause(1.5)
        end
      end
        % now determine and account for x_error, which will change y and scale
        % x to account for remaining offset
        current_pos = read_dobot_position(ard);
        uvtest = get_duckie_position(camera);
        error_v = uvtest(2)-target_uv(2);
        error_x = error_v*dxdv;
        disp(error_x)
        mag = sqrt(current_pos(1)^2+current_pos(2)^2);
        scale = mag/error_x;
        desired_pos(1) = current_pos(1)-(current_pos(1)/scale);
        desired_pos(2) = current_pos(2)-(current_pos(2)/scale);
        desired_pos(3) = 65;
        disp(desired_pos);
        move_dobot_with_pos(desired_pos, ard);
        pause(1.5)
   
    % now that we are directly over the duck, make an effort to try and
    % grab it!
%     current_pos = read_dobot_position(ard);
%     move_dobot_gripper(-50, ard);
%     pause(1)
%     move_dobot_with_pos(current_pos - [0; 0; 30], ard);
%     pause(1.5)
%     move_dobot_gripper(90, ard);
end