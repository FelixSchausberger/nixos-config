{ pkgs, ... }:

{
  imports = [
    ./hyprland
    ./sway
    ./tools
  ];

  home.packages = with pkgs; [
    light
    workstyle
    slurp
    swayimg
  ];
}
