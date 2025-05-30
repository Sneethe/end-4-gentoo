#!/bin/sh

## First time install
### Prerequistite; Before installing end-4, do a full sync and update
#`sudo emaint sync && emerge --ask --verbose --update --deep --changed-use @world`
If you aren't in vdeo and input groups groups | grep -E "video|input"
do: sudo usermod -aG video,input "$(whoami)" # if this somehow doesn't work, just replace "$(whoami)" with your username

t=~/.cache/dots-hyprland # Let's not trash your home folder
command git clone https://github.com/end-4/dots-hyprland.git "$t" --filter=blob:none
cd "$t"

sudo mkdir /etc/portage/sets
sudo mv -ivu illogical-impulse /etc/portage/sets/
sudo eselect repository enable guru xoores
sudo emaint sync -r guru
sudo emaint sync -r xoores
sudo emerge --verbose --ask --autounmask-write --autounmask-continue @illogical-impulse

>&2 'printf' '\033[33mz4h\033[0m: fetching \033[4m~/.zshenv\033[0m\n'
if ! err="$($fetch "$zshenv" '--' "$url"/.zshenv 2>&1)"; then
  >&2 'printf' "%s\n" "$err"
  >&2 'printf' '\033[33mz4h\033[0m: failed to download \033[31m%s\033[0m\n' "$url"/.zshenv
  'exit' '1'
fi

./manual-install-helper.sh
Refer to https://end-4.github.io/dots-hyprland-wiki/en/i-i/01setup/#post-installation for post-installation

# Update process
command rsync -av --exclude='custom/*.conf' .config/hypr ~/.config/hypr/
command rsync -av --exclude='user_options.jsonc' .config/ags ~/.config/ags/
