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

---

<details>
<summary>
Create cleanup routine for yay & flatpak
</summary>

## Flatpak Package (root level)
```bash
sudo nano /etc/systemd/system/flatpak-cleanup.service
```

### Insert this on the file, save and exit
```bash
[Unit]
Description=Monthly Flatpak Cleanup

[Service]
Type=oneshot
ExecStart=/usr/bin/flatpak uninstall --unused -y
```
### Create timer file
```bash
sudo nano /etc/systemd/system/flatpak-cleanup.timer
```
### Insert this on the file, save and exit
``` bash
[Unit]
Description=Monthly Flatpak Cleanup Timer

[Timer]
OnCalendar=monthly
Persistent=true

[Install]
WantedBy=timers.target
```
### Activate timer service for flatpak
```bash
sudo systemctl daemon-reload
sudo systemctl enable --now flatpak-cleanup.timer
```

## yay package (user level) never put yay on root level

### Prepare folder systemd user
```bash
mkdir -p ~/.config/systemd/user
```

### Create file service yay
```bash
nano ~/.config/systemd/user/yay-cleanup.service
```

### Insert this script on it
```bash
[Unit]
Description=Monthly Yay Cleanup Routine

[Service]
Type=oneshot
ExecStart=/usr/bin/yay -Sc --noconfirm
ExecStart=/usr/bin/yay -Yc --noconfirm
```

### Create timer file service
```bash
nano ~/.config/systemd/user/yay-cleanup.timer
```

### Insert this script on it
```bash
[Unit]
Description=Monthly Yay Cleanup Routine

[Timer]
OnCalendar=monthly
Persistent=true

[Install]
WantedBy=timers.target
```

### Activate yay timer
```bash
systemctl --user daemon-reload
systemctl --user enable --now yay-cleanup.timer
```

</details>
