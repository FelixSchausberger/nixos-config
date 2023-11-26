{ pkgs, ... }:
{
  imports = [
    ./tools
    ./sway.nix
    ./extra-config.nix
    ./extra-session-commands.nix
  ];

  home.packages = with pkgs; [
    slurp
    swayimg
  ];
}
