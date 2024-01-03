{ pkgs, ... }:

{
  imports = [
    ./hyprland
    ./sway
    ./tools
  ];

  home.packages = with pkgs; [
    workstyle
    slurp
    swayimg
  ];
}
