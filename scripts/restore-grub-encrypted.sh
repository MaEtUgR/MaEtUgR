# derived from https://gist.github.com/samuelcolvin/43c5ed2807e7db004b1058d0c9bfb068

# Boot live media using UEFI and open terminal
sudo cryptsetup luksOpen /dev/nvme1n1p3 home_nvme # open encrypted luks drive with password
sudo mount /dev/mapper/home_nvme /mnt # mount root partition
for i in /dev /proc /sys; do sudo mount -o bind $i /mnt/@$i; done # bind crucial live system folders into root
chroot /mnt # enter root
# inside your installations root do
fdisk -l # to see the partition layout
# could look like this:
# ...
# /dev/nvme0n1p1     2048   1050623   1048576   512M EFI System
# ...
# /dev/nvme1n1p1  1050624   2050047    999424   488M Linux filesystem
# ...
mount /dev/nvme1n1p1 /boot # mount the boot partition of your linux installation
mount /dev/nvme0n1p1 /boot/efi # mount the efi partition of your system (can be on a separate SSD that has Windows installed)
grub-install
grub-install --recheck

cat /boot/grub/grub.cfg | grep menuentry # check for the entries you have after automatic grub repair, Linux and Windows there?
# If it's all verified reboot

# Other mounting method depending on encryption style:
sudo cryptsetup luksOpen /dev/nvme0n1p3 encrypted
sudo vgdisplay
sudo vgchange -ay
ls /dev/mapper/
sudo mount /dev/mapper/ubuntu--vg-ubuntu--lv /mnt
sudo mount -t proc /proc /mnt/proc
sudo mount -o bind /sys /mnt/sys
sudo mount -o bind /run /mnt/run
sudo mount --rbind /dev/ /mnt/dev/
