{ host, ... }: {
  # Import system-specific and module configurations
  imports = [
    ./hosts/${host}.nix
    ./modules/graphical-applications
    ./modules/hyprland
    ./modules/sway
    ./modules/tty-applications
  ];

  # Specify Home Manager release version
  home.stateVersion = "23.11";

  # Nicely reload system units when changing configs.
  systemd.user.startServices = "sd-switch";

  # Automatically set some environment variables.
  targets.genericLinux.enable = true;
}
