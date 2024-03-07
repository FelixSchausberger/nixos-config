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

  # Nicely reload system units when changing configs.
  systemd.user.startServices = "sd-switch";

  # Automatically set some environment variables.
  targets.genericLinux.enable = true;
}
