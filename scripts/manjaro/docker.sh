sudo pacman -S docker
sudo gpasswd -a $USER docker # needs relogin
systemctl start docker.service
docker info

# PX4
cd Firmware
PX4_DOCKER_REPO=px4io/px4-dev-ros-melodic:2020-01-13 ./Tools/docker_run.sh bash
id # to check correct permissions
