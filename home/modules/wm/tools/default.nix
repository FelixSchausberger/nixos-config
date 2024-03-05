{pkgs, ...}: {
  imports = [
    ./gammastep.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./ironbar.nix
    ./wlsunset.nix
  ];

  home.packages = with pkgs; [
    swayimg
  ];
}
