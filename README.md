# Personal NixOS Configuration

## Setup

Clone the NixOS configuration repository and replace `HOSTNAME` with your actual hostname:

```shell
cd
git clone https://github.com/FelixSchausberger/nixos-config .nixos
sudo mv /etc/nixos/hardware-configuration.nix .nixos/hosts/HOSTNAME
sudo nixos-rebuild switch --flake '.nixos#HOSTNAME'
```

Decrypt secret file:

```shell
git-crypt unlock ./secrets/secret-key
```
