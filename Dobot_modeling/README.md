# function:
## cam_image:
###### input:
```
cam: pinhole camera object
Toc: camera location in reference frame
P0: objects in 3D in the world frame 
```
###### output:
```
uv: objects in pixel
uvw: homogeneous coordinate of P0
P1: target points in the camera frame
```

## defineRobot:
###### input:
```
robotRigidBodyTree: contain robot.q, robot.T, robot.h, robot.P, robot.joint_type
```
###### output:
```
robot collision object
```

## pnp_general
###### input:
```
uv = image coordinates in pixels of target points
P0 = locations of target points in reference frame
K = camera intrinsic calibration matrix
```
###### output:
```
Test = T_C0 estimate
Zest = depth estimate of each target point
```
# Main:
```
duckie_model: define duckie models in the world frame
DobotRigidBodyTree: construct dobot with camera mounted on the end effector, will also generate image base of T_TC
```

