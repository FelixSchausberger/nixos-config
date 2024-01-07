{ pkgs, ... }:

{
  imports = [
    ./hyprland
    ./tools
  ];

  home.packages = with pkgs; [
    slurp
    swayimg
  ];
}
