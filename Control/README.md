## funtion:
```
  control_calibration: initial scan to obtain values dv/dx and du/dq1
  dobot_scan_for_duck: looking for the duckie by moving the dobot through the entire workspace
  move_to_grab_duck: locating the duckie once the dobot finds the duckie and move to grab it
```

## main
```
master_execute: execute the entire pick and place motion using all functions listed above
```

## Note
```
In the addpath section at the beginning of the master_execute file, make sure the to change the directroy to
corresponding directory listed on your local PC. IE, Current directory\Robotics1_Group_project\Control\function
```
