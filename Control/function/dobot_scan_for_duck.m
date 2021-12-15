% The first step is to construct the circles (based on radius and number of
% steps which was set based on radius).  Note that circle two goes the
% opposite direction, for fluid transtion from 3 to 2 to 1

function dobot_scan_for_duck(camera, ard)

    radii = [200, 240, 280];
    setup_dobot;

    theta = 90:-180/9:-90;
    starting_angles = zeros(3, 3);
    for i = 1:3
        pos = [0; radii(i); 75];
        r = rotation_due_to_pos(pos);
        T = [r, pos; [0, 0, 0, 1]];
        dobot.q = [0; 0; 0];
        dobot.T = T;
        dobot = inv_kin(dobot);
        starting_angles(:, i) = dobot.q;
    end

    circle_one = [theta; ones(1, 10) * starting_angles(2, 1); ones(1, 10) * starting_angles(3, 1)];
    circle_two = [theta; ones(1, 10) * starting_angles(2, 2); ones(1, 10) * starting_angles(3, 2)];
    circle_three = [theta; ones(1, 10) * starting_angles(2, 3); ones(1, 10) * starting_angles(3, 3)];

    % now that we have the circles, we have to traverse them (3 --> 2 --> 1)
    % and at each point search to see if we see yellow, and stop once we do

    circle_locations = [circle_one, circle_two, circle_three];

    for i = 1:length(circle_locations)

        next_pos = circle_locations(:, i);
        move_dobot_with_angles(next_pos, ard)
        pause(.5)
        yellow_points = get_image_data(camera.snapshot);
        imshow(camera.snapshot);
        if length(yellow_points) > 350
            break
        end
    end

    % now that we have a little bit of yellow (at least) in our frame, we
    % want to position ourselves so that we see all of the duck in our
    % frame

    current_angles = read_dobot_angles(ard);
    current_angles = current_angles(1:3);
    while 1
        yellow_points = get_image_data(camera.snapshot);
        pause(.1)
        left = 1;
        right = 640;
        bottom = 1;
        top = 480;
        if min(yellow_points(1, :)) == 0
            current_angles = current_angles + [5; 0; 0];
            disp('1')
            move_dobot_with_angles(current_angles, ard)
            pause(.5)
        elseif max(yellow_points(1, :)) == 640
            current_angles = current_angles + [-5; 0; 0];
            disp('2')
            move_dobot_with_angles(current_angles, ard)
            pause(.5)
        elseif min(yellow_points(2, :)) == 0
            current_angles = current_angles + [0; -5; 0];
            disp('3')
            move_dobot_with_angles(current_angles, ard)
            pause(.5)
        elseif max(yellow_points(2, :)) == 480
            current_angles = current_angles + [0; 5; 0];
            disp('4')
            move_dobot_with_angles(current_angles, ard)
            pause(.5)
        else
            break
        end
    end

    % now that the entire duck is in the frame, the function is over
end