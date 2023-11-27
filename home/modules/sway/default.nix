{ pkgs, ... }:
{
  imports = [
    ./tools
    ./extra-config.nix
    ./extra-session-commands.nix
    ./sway.nix
  ];

  home.packages = with pkgs; [
    ironbar
    slurp
    swayimg
  ];
}
