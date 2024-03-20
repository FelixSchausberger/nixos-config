{pkgs, ...}: {
  imports = [
    ./deadd-notification-center.nix
    ./dunst.nix
    ./gammastep.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./ironbar
    ./wayland-pipewire-idle-inhibit.nix
    ./wlsunset.nix
  ];

  home.packages = with pkgs; [
    swayimg
  ];
}
