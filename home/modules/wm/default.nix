{ pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./tools
  ];

  home.packages = with pkgs; [
    swayimg
  ];
}
