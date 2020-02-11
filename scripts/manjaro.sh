
sudo pacman -Syu --noconfirm --needed \
	chromium \
	code \
	htop \
	tk aspell-en \
	seahorse \
	telegram-desktop \
	xclip \
	yay \
	;

# /usr/share/X11/xorg.conf.d/40-libinput.conf
# Section "InputClass"
#         Identifier "libinput touchpad catchall"
#         MatchIsTouchpad "on"
#         MatchDevicePath "/dev/input/event*"
#         Driver "libinput"
#         Option "NaturalScrolling" "True"
# EndSection

yay -S slack-desktop

# fetch correct time
sudo ntpdate ntp.metas.ch
# switch real time clock to local time zone
sudo timedatectl set-local-rtc 1
