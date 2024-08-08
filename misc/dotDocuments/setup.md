### Settig up my personal (arch) linux env

## Packages to install
alacritty
bat
gnome-screenshot
fastfetch
feh
firefox
htop
pass
pavucontrol
picom
stow
ttf-hack-nerd
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
poppler
zoxide
mandoc
interception-caps2esc

## setting up symlink vi that points to nvim
sudo ln -s /usr/bin/nvim /usr/bin/vi

## setting up caps2esc
[Remap Caps Lock to Escape and Control](https://ejmastnak.com/tutorials/arch/caps2esc/)
# Install caps2esc
sudo pacman -S interception-caps2esc

# Create the configuration file /etc/udevmon.yaml (if necessary) and inside it add the following job:
- JOB: "intercept -g $DEVNODE | caps2esc -m 1| uinput -d $DEVNODE"
  DEVICE:
    EVENTS:
      EV_KEY: [KEY_CAPSLOCK, KEY_ESC]

# Create the systemd unit file /etc/systemd/system/udevmon.service (if necessary) and inside it add the contents

[Unit]
Description=udevmon
Wants=systemd-udev-settle.service
After=systemd-udev-settle.service

[Service]
ExecStart=/usr/bin/nice -n -20 /usr/bin/udevmon -c /etc/udevmon.yaml

[Install]
WantedBy=multi-user.target

# Then enable and start the udevmon service:
sudo systemctl enable --now udevmon.service


