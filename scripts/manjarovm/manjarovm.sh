#!/bin/bash

# configure gnome
gsettings set org.gnome.desktop.interface text-scaling-factor 1.3 # scale everything
gsettings set org.gnome.desktop.interface enable-animations false # disable animations
# dash-to-dock
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM # bottom bar
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 45 # big bar
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false # remove trash
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true # app launcher first icon
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true # don't autohide
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height true # extend to screen edge
gsettings set org.gnome.shell.extensions.dash-to-dock multi-monitor true # show dock on all screens
# stand-by settings
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
# clock settings
#gsettings set org.gnome.desktop.interface clock-show-weekday false
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Super>d']"
gsettings set org.gnome.desktop.interface enable-hot-corners false
# desktop icons
gnome-extensions enable desktop-icons@csoriano
# laptop specific
#gsettings set org.gnome.desktop.interface show-battery-percentage true
#gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true

sudo pacman -Syu --noconfirm --needed \
	chromium \
	code \
	htop \
	imwheel \
	tk aspell-en \
	;

sudo pacman -R firefox

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
