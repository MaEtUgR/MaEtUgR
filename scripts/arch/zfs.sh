kate /etc/pacman.conf
# add the following lines
# -----------------------
[archzfs]
# Origin Server - France
Server = http://archzfs.com/$repo/x86_64
# Mirror - Germany
Server = http://mirror.sum7.eu/archlinux/archzfs/$repo/x86_64
# Mirror - Germany
Server = https://mirror.biocrafting.net/archlinux/archzfs/$repo/x86_64
# Mirror - India
Server = https://mirror.in.themindsmaze.com/archzfs/$repo/x86_64
# Mirror - US
Server = https://zxcvfdsa.com/archzfs/$repo/$arch

[zfs-linux]
Server = http://kernels.archzfs.com/$repo/
# -----------------------

# Add archzfs gpg key and sign it as trustworthy
wget https://archzfs.com/archzfs.gpg
sudo pacman-key -a archzfs.gpg
sudo pacman-key --lsign-key DDF7DB817396A49B2A2723F7403BD972F75D9D76
rm archzfs.gpg

# Update and install zfs for Arch, this might downgrade the kernel to a compatible version
pacman -Syu
sudo pacman -S archzfs-linux
# reboot into installed kernel
zpool status # to check the kernel module is running

# Clean disk to be used by zfs
sudo gdisk /dev/sdx
# p to show partitions
# x for expert functions
# z to delete everything from the disk

# List disks by id/serial number to use in zfs
ls -lh /dev/disk/by-id/

# Spin down disk to find order of physical disks
sudo hdparm -Y /dev/sdx

# Create "RAID5" pool of 4 disks, ids in the correct order from by-id list before
sudo zpool create -f -o ashift=12 -m /mnt/hdpool hdpool raidz ata-WDC_WD60EFRX-68L0BN1_WD-WX31D9584NU9 ata-WDC_WD60EFRX-68L0BN1_WD-WX31D95849RU ata-WDC_WD60EFRX-68L0BN1_WD-WX32D502UTH2 ata-WDC_WD60EFRX-68L0BN1_WD-WX32D50E583D

# Automatically mount pool on boot
sudo systemctl enable --now zfs-import-cache
sudo systemctl enable --now zfs-mount
