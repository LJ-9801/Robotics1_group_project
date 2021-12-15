function R = rotation_due_to_pos(position)

    q1 = atan2(position(2), position(1));
    R = rot ([0;0;1], q1);

end