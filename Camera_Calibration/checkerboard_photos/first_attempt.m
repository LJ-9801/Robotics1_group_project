clc
clear all
close all
warning off

% This will change for each camera - this is one we found in the lab
c=webcam('Microsoft® LifeCam HD-5000');
for i = 1:5
    e=c.snapshot;
    imshow(e)
    image_name = "image_number_take_4_" + num2str(i) + ".png";
    path_save = 'C:\Users\jacki\Documents\Robotics 1\camera_calibration' + image_name;
    imwrite(e, path_save, 'png')
    imshow(e)
    pause(5)
end