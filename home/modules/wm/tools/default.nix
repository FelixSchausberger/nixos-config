{pkgs, ...}: {
  imports = [
    ./gammastep.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./wlsunset.nix
  ];

  home.packages = with pkgs; [
    swayimg
  ];
}
