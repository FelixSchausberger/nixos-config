# Personal NixOS config

## Setup

Don't forget to replace HOSTNAME with actual hostname:

```shell
  cd
  git clone https://github.com/FelixSchausberger/nixos-config .nixos
  sudo mv /etc/nixos/hardware-configuration.nix .nixos/hosts/HOSTNAME
  sudo nixos-rebuild switch --flake '.nixos#HOSTNAME'
```

## To Do

- Spacedrive
- Overskride
