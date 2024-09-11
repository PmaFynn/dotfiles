# My dotfiles

This directory contains the dotfiles for my system

## Requirements

Ensure you have the following installed on your system

### Git

```
pacman -S git
```

### Stow

```
pacman -S stow
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git

```
$ git clone git@github.com/pmafynn/dotfiles.git
$ cd dotfiles
$ git submodule update --init --recursive
```

then use GNU stow to create symlinks

```
$ stow .
```

# More concrete setup of individual arch env

## Packages to install
alacritty
bat
cal
gnome-screenshot
oath-toolkit
zip
ytfzf
yt-dlp
mpv
unzip
fastfetch
feh
firefox
htop
pass
pavucontrol
picom
stow
ttf-hack-nerd
fdupes
i3 
dmenu
wget
yazi
git
xdotool
xclip
zsh
neovim
fd
fzf
tmux
ripgrep
jq
zathura
zathura-pdf-poppler
poppler
zoxide
mandoc
interception-caps2esc
entr

## setting up symlink vi that points to nvim
```
sudo ln -s /usr/bin/nvim /usr/bin/vi
```
## setting up pass

##### Preparation
importing/exporting gpg keys 
trust level

## setting up caps2esc
[Remap Caps Lock to Escape and Control](https://ejmastnak.com/tutorials/arch/caps2esc/)
##### Install caps2esc

```
sudo pacman -S interception-caps2esc
```

##### Create the configuration file /etc/udevmon.yaml (if necessary) and inside it add the following job:
```
- JOB: "intercept -g $DEVNODE | caps2esc -m 1 | uinput -d $DEVNODE"
  DEVICE:
    EVENTS:
      EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
```

##### Create the systemd unit file /etc/systemd/system/udevmon.service (if necessary) and inside it add the contents

```
[Unit]
Description=udevmon
Wants=systemd-udev-settle.service
After=systemd-udev-settle.service

[Service]
ExecStart=/usr/bin/nice -n -20 /usr/bin/udevmon -c /etc/udevmon.yaml

[Install]
WantedBy=multi-user.target
```

##### Then enable and start the udevmon service:
```
sudo systemctl enable --now udevmon.service
```

## zathura as default pdf viewer
First, ensure a desktop entry for zathura exists at /usr/share/applications/org.pwmt.zathura.desktop. If it does not, download the desktop entry from from the zathura [repo](https://github.com/pwmt/zathura/blob/develop/data/org.pwmt.zathura.desktop.in) to /usr/share/applications/org.pwmt.zathura.desktop. 

```
[Desktop Entry]
Version=1.0
Type=Application
Name=Zathura
Comment=A minimalistic document viewer
Exec=zathura %U
# Translators: Icon of the desktop entry.
Icon=org.pwmt.zathura
Terminal=false
Categories=Office;Viewer;
# Translators: Search terms to find this application. Do not translate or
# localize the semicolons. The list must also end with a semicolon.
Keywords=PDF;PS;PostScript;DjVU;document;presentation;viewer;
```

Then, set zathura as default using xdg-mime(1)

```
xdg-mime default org.pwmt.zathura.desktop application/pdf
```

## Install all nerfonts 
```
sudo pacman -S $(pacman -Sgq nerd-fonts)
```

## get music (or vidoes) to phone
1. install vlc
2. activate "Sharing via Wi-Fi"
3. open localost (or whatever host is written there)
4. upload files

## mount harddisk:
```
sudo pacman -S ntfs-3g
lsblk
# expects [/dev/sdX1] [/mnt/usb]
# example: sudo mount -t ntfs-3g /dev/sda1 /mnt/usb
sudo mount -t ntfs-3g
```

## best script for yt-dlp
https://github.com/PmaFynn/yt-dlp-scripts:
### prep
1. git clone that shit
2. set up .gitignore:
```
*.txt
*.m4a
*.opus
*.describtion
*.json
*.webp
*.webm
*.mkv
*.log
```
### usage
1. potentially make .sh script executable
2. insert source (yt link) into source.txt 
3. execute .sh file

## oath-toolkit usage:
used for TOTP (time-based one time passwords)
```
oathtool --totp "YOUR_SECRET_KEY"
```
## setting up rclone (incl. potential systemd job)
1. 'rclone config'
2. n
3. enter name (e.g. mega)
4. select storage type (i.e. look for mega and use this number)
5. enter user name (i.e. mega email)
6. enter password (i.e. mega password)
7. finish the rest (nothing important -> defaults should work)
8. test connection with rclone ls name: (i.e. rclone ls mega:)

### setting up automatic syncing from local to remote:
#### Prerequisites:
1. sync remote to machine manually once
2. stowed dotfiles <- this includes the rclone-sync-to-remote.service file

#### Process
```
systemctl --user daemon-reload
systemctl --user restart rclone-sync-to-remote.service
systemctl --user status rclone-sync-to-remote.service
```

