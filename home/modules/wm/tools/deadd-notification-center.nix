{ pkgs, ... }:
{
  home.packages = with pkgs; [
    deadd-notification-center
  ];
}
