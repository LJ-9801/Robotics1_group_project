function robot = my_forward_kinematics(robot)

    % We can use prior rot matrix to find the new one using a simple 
    % multiplixation (rot helper function used).  Then the position can be 
    % updated by adding the newly found R by current P and adding to old P 
    % in the pose
    
    % Start off with identity matrix and inherit properites
    T = eye(4, 4);
    q = robot.q;
    h = robot.H;    
    p = robot.P;
    
    % Adjust the angles to account for the dobot angles being different
    % than the angles we normally use for kinematics (and add q4)
    true_q = [q(1), q(2), q(3) - q(2)];
    true_q = [true_q, -true_q(2) - true_q(3)];
    
    % Start off with P01
    T(1:3, 4) = p(1:3, 1);
    
    % Iterate through the rest of the forward kinematics (angles 1:4)
    for i = 1:length(true_q)
        
        % Get the last rot matrix, which is really the product of all rot
        % matrices up to the last one, multiply by current rot matrix to
        % get new R
        R_last = T(1:3, 1:3);
        R_current = rot(h(1:3, i), true_q(i));
        R_new = R_last * R_current;
        
        % Get the latest position, update it by saying position after new
        % link = position before link + rotation*vector
        p_last = T(1:3, 4);
        p_new = p_last + (R_new * p(1:3, i+1));
        
        % Update T with new values
        T = [R_new, p_new; zeros(1, 3), 1];
    end
    % Update robot with the final pose found
    robot.T = T;
end