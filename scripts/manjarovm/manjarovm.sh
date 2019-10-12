#!/bin/bash

# configure gnome
gsettings set org.gnome.desktop.interface text-scaling-factor 1.5 # scale everything
gsettings set org.gnome.desktop.interface enable-animations false # disable animations
# dash-to-dock
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM # bottom bar
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 64 # big bar
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false # remove trash
# stand-by settings
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
# clock settings
#gsettings set org.gnome.desktop.interface clock-show-weekday false
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Super>d']"
# desktop icons
#gnome-shell-extension-tool -e desktop-icons@csoriano

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
