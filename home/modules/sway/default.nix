{ pkgs, ... }:
{
  imports = [
    ./sway.nix
    ./sway-extra-condig.nix
    ./sway-extra-session-commands.nix
    ./swayidle.nix
  ];

  home.packages = with pkgs; [
    slurp
    swayimg
  ];
}
