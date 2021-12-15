function angles = dobot_random_angles()

    % constraints: -135 to 135, -5 to 85, -10 to 95, -90 to 90
    
    angle1 = randi([-50 50]);
    angle2 = randi([0 35]);
    angle3 = randi([-5 35]);
    angle4 = randi([-90 90]);
    
    angles = [angle1; angle2; angle3; angle4];

end