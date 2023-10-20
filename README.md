# Personal NixOS config

## Setup
  ```shell
  cd
  git clone https://github.com/FelixSchausberger/nixos-config .nixos
  sudo mv /etc/nixos/hardware-configuration.nix .nixos/hosts/HOSTNAME # don't forget to replace HOSTNAME with actual hostname
  sudo nixos-rebuild switch --flake '.nixos#HOSTNAME'
  ```

## To Do
  - Rofi Plugins: https://discourse.nixos.org/t/rofi-on-wayland-and-plugins/17354
  - Spacedrive, Overskride
