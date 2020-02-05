
sudo pacman -Syu --noconfirm --needed \
	chromium \
	code \
	htop \
	tk aspell-en \
	seahorse \
	telegram-desktop \
	xclip \
	;

# /usr/share/X11/xorg.conf.d/40-libinput.conf
# Section "InputClass"
#         Identifier "libinput touchpad catchall"
#         MatchIsTouchpad "on"
#         MatchDevicePath "/dev/input/event*"
#         Driver "libinput"
#         Option "NaturalScrolling" "True"
# EndSection

sudo pacman -S telegram-desktop
yay -S slack-desktop

# switch real time clock to local time zone
sudo timedatectl set-local-rtc 1
# fetch correct time
sudo ntpdate ntp.metas.ch
