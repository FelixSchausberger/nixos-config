{ pkgs, ... }:
{
  imports = [
    ./extra-config.nix
    ./extra-session-commands.nix
    ./sway.nix
  ];
}
