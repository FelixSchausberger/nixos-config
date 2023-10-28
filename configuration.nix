# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  host,
  pkgs,
  ...
}: let
  start-sway = pkgs.writeTextFile {
    name = "start-sway";
    destination = "/bin/start-sway";
    executable = true;

    text = ''
      #!/bin/sh

      ## Internal variables
      SWAY_EXTRA_ARGS=""

      ## General exports
      export XDG_CURRENT_DESKTOP=sway
      export XDG_SESSION_DESKTOP=sway
      export XDG_SESSION_TYPE=wayland

      ## Hardware compatibility
      # We can't be sure that the virtual GPU is compatible with Sway.
      # We should be attempting to detect an EGL driver instead, but that appears
      # to be a bit more complicated.
      case $(systemd-detect-virt --vm) in
          "none"|"")
              ;;
          "kvm")
              # https://github.com/swaywm/sway/issues/6581
              export WLR_NO_HARDWARE_CURSORS=1
              # There's two drivers we can get here, depending on the 3D acceleration
              # flag state: either virtio_gpu/virgl or kms_swrast/llvmpipe.
              #
              # The former one causes graphical glitches in OpenGL apps when using
              # 'pixman' renderer. The latter will crash 'gles2' renderer outright.
              # Neither of those support 'vulkan'.
              #
              # The choice is obvious, at least until we learn to detect the driver
              # instead of abusing the virtualization technology identifier.
              #
              # See also: https://gitlab.freedesktop.org/wlroots/wlroots/-/issues/2871
              export WLR_RENDERER=pixman
              ;;
          *)
              # https://github.com/swaywm/sway/issues/6581
              export WLR_NO_HARDWARE_CURSORS=1
              ;;
      esac

      ## Load system environment customizations
      if [ -f /etc/sway/environment ]; then
          set -o allexport
          # shellcheck source=/dev/null
          . /etc/sway/environment
          set +o allexport
      fi

      ## Load user environment customizations
      if [ -f "''${XDG_CONFIG_HOME:-$HOME/.config}/sway/environment" ]; then
          set -o allexport
          # shellcheck source=/dev/null
          . "''${XDG_CONFIG_HOME:-$HOME/.config}/sway/environment"
          set +o allexport
      fi

      ## Unexport internal variables
      # export -n is not POSIX :(
      _SWAY_EXTRA_ARGS="$SWAY_EXTRA_ARGS"
      unset SWAY_EXTRA_ARGS

      # Start sway with extra arguments and send output to the journal
      # shellcheck disable=SC2086 # quoted expansion of EXTRA_ARGS can produce empty field
      exec systemd-cat -- sway $_SWAY_EXTRA_ARGS "$@"
    '';
  };
in {
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

  environment = {
    systemPackages = with pkgs; [
      gnome.adwaita-icon-theme
      gnome.gnome-themes-extra
      start-sway
      wayland
      xdg-utils
    ];

    loginShellInit = ''
      [[ "$(tty)" == /dev/tty1 ]] && sway
    '';

    # Get bash completion for system packages
    pathsToLink = ["/share/bash-completion"];

    etc."ssh/ssh_host_ed25519_key.pub".source =
      if builtins.pathExists ./hosts/${host}/ssh_host_ed25519_key.pub
      then ./hosts/${host}/ssh_host_ed25519_key.pub
      else null;
  };

  services.dbus.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # Needed to make gtk apps happy.
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
  };

  # Configure system wide privileges.
  security.pam.services.swaylock.text = ''
    # PAM configuration file for the swaylock screen locker. By default, it includes
    # the 'login' configuration file (see /etc/pam.d/login)
    auth include login
  '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system = {
    autoUpgrade = {
      enable = true;
      allowReboot = true;
    };
    stateVersion = "23.05"; # Did you read the comment?
  };
}
