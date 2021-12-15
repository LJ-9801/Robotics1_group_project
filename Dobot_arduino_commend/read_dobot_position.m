% This function takes in an arduino object and returns the (x; y; z)
% coordinates of the dobot connected through that arduino

function pos = read_dobot_position(arduino_obj)

    flush(arduino_obj);
    line_str = readline(arduino_obj); % MATLAB returns readline as string
    line_str = readline(arduino_obj); % MATLAB returns readline as string
    line_str = readline(arduino_obj); % MATLAB returns readline as string
    pause(.1)
    line_chr = convertStringsToChars(line_str); % convert the string to char array

    line_float = typecast(uint8(line_chr(2:end)), 'single'); % obtain the 10 float(single) values in the data package
    pos = zeros(3, 1);
    
    pos(1) = line_float(1); % X coordinate
    pos(2) = line_float(2); % Y coordinate
    pos(3) = line_float(3); % Z coordinate

end