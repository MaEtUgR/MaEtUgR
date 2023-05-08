loadkeys de_CH-latin1 # Swiss keyboard layout
ls /sys/firmware/efi/efivars # Check if under UEFI
ip a # Check if network connected
iwctl # Configure Wifi
    station wlan0 get-networks
    station wlan0 connect <3
    station wlan0 show
ping 8.8.8.8 # Check internet
ping google.com # Check DNS
timedatectl # Set time zone
    timedatectl set-timezone Europe/Zurich
lsblk # Prepare boot and system partition
    fdisk -l
    gdisk # 1 EFI 0-1G, 2 Root 1G-100G
    mkfs.fat -F 32 /dev/nvme0n1p1
    mkfs.xfs /dev/nvme0n1p2
    xfs_admin -L "Arch" /dev/nvme0n1p2
    mount /dev/nvme0n1p2 /mnt
    mount --mkdir /dev/nvme0n1p1 /mnt/boot
cat /etc/pacman.d/mirrorlist # Check if mirrors were optimized
pacstrap -K /mnt base linux linux-firmware # install Arch
genfstab -U /mnt >> /mnt/etc/fstab # save mounting table
arch-chroot /mnt # switch into and configure newly installed system
    ln -sf /usr/share/zoneinfo/Europe/Zurich /etc/localtime
    hwclock --systohc
    pacman -S vim
    vim /etc/locale.gen # uncomment US UTF8
    locale-gen
    echo "KEYMAP=de_CH-latin1" >> /etc/vconsole.conf
    echo "Speedy" >> /etc/hostname
    passwd
    pacman -S intel-ucode
        ls /boot/ # check intel-ucode.img was installed
sudo pacman -S efibootmgr
    efibootmgr --unicode # show efi boot entries
    # create entry
    efibootmgr --create --disk /dev/nvme0n1 --part 1 --label "Arch" --loader /vmlinuz-linux --unicode 'root="LABEL=Arch" rw initrd=\intel-ucode.img initrd=\initramfs-linux.img'
    # same later for nvidia driver
    sudo efibootmgr --create --disk /dev/nvme0n1 --part 1 --label "Arch" --loader /vmlinuz-linux --unicode 'root="LABEL=Arch" rw initrd=\intel-ucode.img initrd=\initramfs-linux.img nvidia_drm.modeset=1'
    # delete an entry
    efibootmgr -b 1 -B
cp /etc/systemd/netowrk/* /mnt/etc/systemd/network/ # copy over network config from install medium
umount -R /mnt
reboot
