sudo pacman -S ntp
sudo systemctl enable --now ntpd
ntpq -p
timedatectl status
