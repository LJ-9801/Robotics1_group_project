function q = which_angles(dobot, angle_set)
    angle_set = real(angle_set / pi * 180);
    for i = 1:12
        
        if angle_set(i) < -5
            angle_set(i) = angle_set(i) + 360;
        end
        
        if angle_set(i) > 180
            angle_set(i) = angle_set(i) -  360;
        end
        
        if angle_set(i) == 360 || angle_set(i) == -360 || floor(angle_set(i)) == -0
            angle_set(i) = 0;
        end
        if abs(angle_set(i)) < .001
            angle_set(i) = 0;
        end
    end

    angle_limit_lower = [-135, -5, -5];
    angle_limit_upper = [135, 85, 85];
    viable_angles = [];
    for i = 1:4
        if diag(angle_set(:, i) <= angle_limit_upper)
            if diag(angle_set(:, i) >= angle_limit_lower)
                viable_angles = [viable_angles, angle_set(:, i)];
            end
        end
    end
    
    if length(viable_angles(:)) == 3
        q = viable_angles(: , 1);
    else
        angle_diff = sum(abs(viable_angles - (dobot.q * 180 / pi)));
        min_diff = min(angle_diff);
        index = find(angle_diff == min_diff);
        q = viable_angles(:, index);
end