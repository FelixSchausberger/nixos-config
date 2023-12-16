{ host, ... }: {
  # Import system-specific and module configurations
  imports = [
    ./hosts/${host}.nix
    ./modules/cli
    ./modules/gui
    ./modules/wm
  ];

  # Specify Home Manager release version
  home.stateVersion = "23.11";

  # Nicely reload system units when changing configs.
  systemd.user.startServices = "sd-switch";

  # Automatically set some environment variables.
  targets.genericLinux.enable = true;
}
