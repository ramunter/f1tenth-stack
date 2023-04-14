# Start from a base image with ROS 2 Foxy installed
FROM f1tenth/focal-l4t-foxy:f1tenth-stack

# Clone the f1tenth_system repo from GitHub
RUN mkdir -p /f1tenth_ws/src
WORKDIR /f1tenth_ws/src
RUN git clone https://github.com/f1tenth/f1tenth_system.git

# Build the workspace
WORKDIR /f1tenth_ws
RUN /bin/bash -c '. /opt/ros/foxy/setup.bash; colcon build'

# Set the required environment variables
ENV DISPLAY $DISPLAY
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES all
ENV NVIDIA_REQUIRE_CUDA "cuda>=11.0"
ENV ROS_DOMAIN_ID 42

# Expose the X11 Unix socket and the /dev folder
VOLUME ["/tmp/.X11-unix", "/dev"]

# Set the entry point for the container
CMD ["/bin/bash"]