#!/bin/bash

# disable password prompt for sudo
sudo sed -i '/%sudo\tALL=(ALL:ALL) ALL/c\%sudo\tALL=(ALL:ALL) NOPASSWD:ALL' /etc/sudoers

# install all basic packages
sudo apt update
sudo apt upgrade
sudo apt install htop open-vm-tools open-vm-tools-desktop gnome-core gnome-tweak-tool gnome-shell-extension-dash-to-panel git imwheel -y
#sudo apt purge firefox -y

# disable splash screen on boot
sudo sed -i 's/splash quiet//g' /etc/default/grub
sudo update-grub

# Enable GDM auto-login
sudo sed -i '/#  AutomaticLoginEnable = true/c\AutomaticLoginEnable = true' /etc/gdm3/custom.conf
sudo sed -i '/#  AutomaticLogin = user1/c\AutomaticLogin = '$USER /etc/gdm3/custom.conf

#### rerun script in GUI

# configure gnome
gsettings set org.gnome.desktop.interface text-scaling-factor 1.5
gsettings set org.gnome.desktop.background show-desktop-icons true
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
gsettings set org.gnome.desktop.interface clock-show-weekday false
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Super>d']"

# gnome shell extensions
sudo wget -O /usr/local/bin/gnomeshell-extension-manage "https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/ubuntugnome/gnomeshell-extension-manage"
sudo chmod +x /usr/local/bin/gnomeshell-extension-manage
# install dash to panel (https://extensions.gnome.org/extension/1160/dash-to-panel/)
gnomeshell-extension-manage --install --extension-id 1160 --system
#sudo cp /usr/share/gnome-shell/extensions/dash-to-panel@jderose9.github.com/schemas/org.gnome.shell.extensions.dash-to-panel.gschema.xml /usr/share/glib-2.0/schemas/ &&
sudo wget -O /usr/share/glib-2.0/schemas/org.gnome.shell.extensions.dash-to-panel.gschema.xml https://raw.githubusercontent.com/home-sweet-gnome/dash-to-panel/master/schemas/org.gnome.shell.extensions.dash-to-panel.gschema.xml
sudo glib-compile-schemas /usr/share/glib-2.0/schemas/
gsettings set org.gnome.shell.extensions.dash-to-panel panel-size 64
gsettings set org.gnome.shell.extensions.dash-to-panel appicon-margin 0
gsettings set org.gnome.shell.extensions.dash-to-panel appicon-padding 0
gsettings set org.gnome.shell.extensions.dash-to-panel location-clock 'STATUSRIGHT'
gsettings set org.gnome.shell.extensions.dash-to-panel animate-show-apps false
gsettings set org.gnome.shell.extensions.dash-to-panel trans-use-custom-opacity true
gsettings set org.gnome.shell.extensions.dash-to-panel trans-panel-opacity 0.0
gsettings set org.gnome.shell.extensions.dash-to-panel trans-use-custom-gradient true
gsettings set org.gnome.shell.extensions.dash-to-panel trans-gradient-top-opacity 0.05
gsettings set org.gnome.shell.extensions.dash-to-panel trans-gradient-bottom-opacity 0.3

# remove accesibility panel (https://extensions.gnome.org/extension/112/remove-accesibility/)
gnomeshell-extension-manage --install --extension-id 112 --system --version 3.2

#gsettings set org.gnome.settings-daemon.plugins.power active false
#gsettings set org.gnome.desktop.screensaver idle-activation-enabled false

# fix mouse wheel scrolling
cat <<EOF | install -D /dev/stdin ~/.config/autostart/imwheel.desktop
[Desktop Entry]
Type=Application
Name=imwheel
Exec=/usr/bin/imwheel --kill
Comment=Fix mouse scroll wheel issues.
EOF
cat > ~/.imwheelrc <<EOF
".*"
None,      Up,   Button4, 2
None,      Down, Button5, 2
Control_L, Up,   Control_L|Button4
Control_L, Down, Control_L|Button5
Shift_L,   Up,   Shift_L|Button4
Shift_L,   Down, Shift_L|Button5
EOF
imwheel --kill

# px4
# fix vmware graphics for gazebo
echo "export SVGA_VGPU10=0" >> ~/.profile
