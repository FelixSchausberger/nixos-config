{ host
, nix-colors
  # , pkgs
, ...
}: {
  # Import system-specific and module configurations
  imports = [
    ./hosts/${host}.nix
    ./modules/graphical-applications
    ./modules/gammastep.nix
    ./modules/gtk.nix
    ./modules/qt.nix
    ./modules/sway
    ./modules/tty-applications
    ./modules/xdg.nix
    nix-colors.homeManagerModule
  ];

  # Set color scheme
  colorScheme = nix-colors.colorSchemes.onedark;

  # Specify Home Manager release version
  home.stateVersion = "23.11";

  # Nicely reload system units when changing configs.
  systemd.user.startServices = "sd-switch";

  # Automatically set some environment variables.
  targets.genericLinux.enable = true;
}
