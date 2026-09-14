# dotfiles

<details>
<summary>
machine preparation
</summary>

```bash
cat /sys/firmware/efi/fw_platform_size # Check machine architecture
```

```bash
lsblk # Disks list
```

```bash
iwctl 
```

```bash
device list
```

```bash
station wlan0 scan
```

```bash
station wlan0 get-networks
```

```bash
station wlan0 connect "WiFi Name"
```

```bash
exit
```

```bash
timedatectl set-ntp true
```

```bash
cfdisk /dev/nvme0n1 # change nvme0n1 if the disk name is different
```

```bash
mkfs.fat -F 32 /dev/nvme0n1p1
```

```bash
mkfs.ext4 /dev/nvme0n1p2
```

```bash
mount /dev/nvme0n1p2 /mnt
```

```bash
mkdir -p /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot
```

```bash
mkdir -p /mnt/data #change "data" dir whatever you want
mount -t ntfs3 /dev/sda1 /mnt/data
```

```bash
nano /etc/pacman.d/mirrorlist
```

```text
Server = https://mirrors.kernel.org/archlinux/$repo/os/$arch
```

```bash
nano /etc/pacman.conf
```

```bash
pacman -Syy
```

```bash
pacstrap /mnt base linux linux-firmware nano networkmanager
```

```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

```bash
arch-chroot /mnt
```

```bash
ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
```

```bash
hwclock --systohc
```

```bash
nano /etc/locale.gen
```

```bash
locale-gen
```

```bash
echo "LANG=en_US.UTF-8" > /etc/locale.conf
```

```bash
echo "PC NAME" > /etc/hostname
```

```bash
passwd
```

```bash
pacman -S grub efibootmgr
```

```bash
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
```

```bash
grub-mkconfig -o /boot/grub/grub.cfg
```

```bash
systemctl enable NetworkManager
```

```bash
exit
umount -R /mnt
reboot
```

```bash
useradd -m -G wheel -s /bin/bash yourname
```
```bash
passwd yourname
```

```bash
nmtui
```

```bash
pacman -S sudo
```

```bash
EDITOR=nano visudo
```
</details>

## Installation

To set up the dotfiles on a new system (or to re-apply links after adding new configs), simply run:

```bash
git clone https://github.com/RiiK26/dotfiles.git
cd dotfiles
```
Install Packages
```
./install-pkgs
```

Install Dotfiles
```bash
./install
```

This will automatically create symlinks from your home directory pointing to the files in this repository.