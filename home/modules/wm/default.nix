{ pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./tools
  ];

  home.packages = with pkgs; [
    slurp
    swayimg
  ];
}
