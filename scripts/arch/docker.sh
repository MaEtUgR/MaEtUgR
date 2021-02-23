sudo pacman -S docker
sudo gpasswd -a $USER docker # needs relogin
systemctl start docker.service
docker info

# PX4
cd Firmware
PX4_DOCKER_REPO=px4io/px4-dev-ros-melodic:2020-01-13 ./Tools/docker_run.sh bash
id # to check correct permissions
DONT_RUN=1 make px4_sitl gazebo # build sitl gazebo without running it
./test/rostest_px4_run.sh mavros_posix_tests_offboard_posctl.test mission:= vehicle:=iris # run SITL offboard test
DONT_RUN=1 make px4_sitl gazebo && PX4_SIM_SPEED_FACTOR=100 ./test/rostest_px4_run.sh mavros_posix_tests_offboard_posctl.test mission:= vehicle:=iris ;  mv /home/user/.ros/log/*/* .
