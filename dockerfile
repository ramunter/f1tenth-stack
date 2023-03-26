# Start from a base image with ROS 2 Foxy installed
FROM ros:foxy-ros-core-focal

# Set up workspace
RUN mkdir -p /ros2_ws/src
WORKDIR /ros2_ws
RUN colcon build
COPY f1tenth f1tenth

# Mount CPP files
VOLUME /ros2_ws/src/f1tenth

# Set entry point to run a roslaunch file
CMD ["ros2", "launch", "f1tenth", "stack.launch"]