{pkgs, ...}: {
  imports = [
    ./gammastep.nix
    ./hypridle.nix
    ./hyprpaper.nix
    # ./swayidle.nix
    # ./wayland-pipewire-idle-inhibit.nix
    ./wlsunset.nix
  ];

  home.packages = with pkgs; [
    swayimg
  ];
}
