{ config, pkg, ... }:

{
  networking.networkmanager = {
    enable = true;
  };
}
