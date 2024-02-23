# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ host, pkgs, ... }:

{
  imports = [
    ./hosts/${host}/hardware-configuration.nix
    ./modules/bluetooth.nix
    ./modules/bootloader.nix
    ./modules/development.nix
    ./modules/fonts.nix
    ./modules/nix.nix
    ./modules/polkit.nix
    ./modules/sound.nix
    ./modules/users.nix
    ./modules/wifi.nix
  ];

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_AT.UTF-8";
    LC_IDENTIFICATION = "de_AT.UTF-8";
    LC_MEASUREMENT = "de_AT.UTF-8";
    LC_MONETARY = "de_AT.UTF-8";
    LC_NAME = "de_AT.UTF-8";
    LC_NUMERIC = "de_AT.UTF-8";
    LC_PAPER = "de_AT.UTF-8";
    LC_TELEPHONE = "de_AT.UTF-8";
    LC_TIME = "de_AT.UTF-8";
  };

  environment.systemPackages = with pkgs; [
    dconf
    wayland
    xdg-utils
  ];

  # Configure system-wide files.
  environment.etc = {
    "fuse.conf".text = ''
      user_allow_other
    '';

    "nixos/configuration.nix" = {
      source = "/home/fesch/.nixos/configuration.nix";
    };

    "nixos/hardware-configuration.nix" = {
      source = "/home/fesch/.nixos/hosts/${host}/hardware-configuration.nix";
    };

    "ssh/ssh_host_ed25519_key.pub".source =
      if builtins.pathExists ./hosts/${host}/ssh_host_ed25519_key.pub
      then ./hosts/${host}/ssh_host_ed25519_key.pub
      else null;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  services.dbus.enable = true;

  xdg.portal = {
    enable = true;
    config.common.default = "*";
    wlr.enable = true;
    # Needed to make gtk apps happy.
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # Configure system-wide privileges.
  security = {
    pam.services.swaylock.text = ''
      # PAM configuration file for the swaylock screen locker. By default, it includes
      # the 'login' configuration file (see /etc/pam.d/login)
      auth include login
    '';

    # Don't ask for password for wheel group
    sudo.wheelNeedsPassword = false;

    # wrappers = {
    #   fusermount.source = "${pkgs.fuse}/bin/fusermount";
    # };
  };

  # Auto upgrade settings.
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
  };
  system.stateVersion = "24.05";
}
