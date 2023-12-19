{ pkgs, ... }:

{
  imports = [
    ./hyprland
    ./sway
    ./tools
  ];

  home.packages = with pkgs; [
    ironbar
    slurp
    swayimg
  ];
}
