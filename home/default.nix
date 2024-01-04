{ host, ... }:

{
  # Import system-specific and module configurations
  imports = [
    ./hosts/${host}.nix
    ./modules/gui
    ./modules/tui
    ./modules/wm
    ./xdg.nix
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # For electron apps
  };

  # Specify Home Manager release version
  home.stateVersion = "24.05";

  # Nicely reload system units when changing configs.
  systemd.user.startServices = "sd-switch";

  # Automatically set some environment variables.
  targets.genericLinux.enable = true;
}
