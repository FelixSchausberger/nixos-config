{ host, pkgs, ... }:

let
  editor = "${pkgs.helix}/bin/hx";
in
{
  # Import system-specific and module configurations
  imports = [
    ./hosts/${host}.nix
    ./modules/gui
    ./modules/tui
    ./modules/wm
  ];

  home.sessionVariables = {
    EDITOR = "${editor}";
    SUDO_EDITOR = "${editor}";
    VISUAL = "${editor}";
    NIXOS_OZONE_WL = "1"; # For electron apps
  };

  # Specify Home Manager release version
  home.stateVersion = "23.11";

  # Nicely reload system units when changing configs.
  systemd.user.startServices = "sd-switch";

  # Automatically set some environment variables.
  targets.genericLinux.enable = true;
}
