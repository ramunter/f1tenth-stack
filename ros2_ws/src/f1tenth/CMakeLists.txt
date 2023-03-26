cmake_minimum_required(VERSION 3.5)
project(f1tenth)

# Find dependencies
find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(std_msgs REQUIRED)

# Add executables
add_executable(navigation_node src/navigation_node.cpp)
add_executable(perception_node src/perception_node.cpp)

# Link against dependencies
target_link_libraries(navigation_node ${rclcpp_LIBRARIES} ${std_msgs_LIBRARIES})
target_link_libraries(perception_node ${rclcpp_LIBRARIES} ${std_msgs_LIBRARIES})

# Install executables
install(TARGETS
  navigation_node
  perception_node
  DESTINATION lib/${PROJECT_NAME})

# Install launch files
install(DIRECTORY launch
  DESTINATION share/${PROJECT_NAME})

# Install package.xml
ament_package()