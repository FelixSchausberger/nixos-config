{ host
, nix-colors
, pkgs
, ...
}: {
  # Import system-specific and module configurations
  imports = [
    ./hosts/${host}.nix
    ./modules/bat.nix
    ./modules/broot.nix
    ./modules/cliphist.nix
    ./modules/direnv.nix
    ./modules/dunst.nix
    ./modules/fzf.nix
    ./modules/gammastep.nix
    ./modules/git.nix
    ./modules/gtk.nix
    ./modules/helix.nix
    ./modules/i3status-rust.nix
    ./modules/nushell.nix
    ./modules/nwg-drawer.nix
    ./modules/qt.nix
    ./modules/rbw.nix
    ./modules/rclone.nix
    ./modules/starship.nix
    ./modules/sway
    ./modules/sway/sway-extra-config.nix
    ./modules/sway/sway-extra-session-commands.nix
    ./modules/tealdeer.nix
    ./modules/topgrade.nix
    ./modules/vscode.nix
    ./modules/waybar.nix
    ./modules/wezterm.nix
    ./modules/xdg.nix
    nix-colors.homeManagerModule
  ];

  # Set color scheme
  colorScheme = nix-colors.colorSchemes.onedark;

  # Configure enabled programs and services
  programs = {
    bottom.enable = true;
    firefox.enable = true;
    home-manager.enable = true;
    mpv.enable = true;
    nix-index.enable = true;
    ripgrep.enable = true;
    sioyek.enable = true;
    ssh.enable = true;
    zoxide.enable = true;
  };

  services = {
    lorri.enable = true;
    playerctld.enable = true; # Custom services with comments
  };

  # Configure additional packages
  home = {
    packages = with pkgs; [
      dconf
      fd
      gitoxide
      obsidian
      procs
      rm-improved
      ripgrep-all
      tgpt
      typst
      unzip
      upscayl
      wl-clipboard
    ];

    # Specify Home Manager release version
    stateVersion = "23.11";
  };

  # Nicely reload system units when changing configs.
  systemd.user.startServices = "sd-switch";

  # Automatically set some environment variables.
  targets.genericLinux.enable = true;
}
