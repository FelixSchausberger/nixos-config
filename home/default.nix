{ host
, nix-colors
, pkgs
, ...
}: {
  imports = [
    ./hosts/${host}.nix
    ./modules/bat.nix
    ./modules/broot.nix
    ./modules/cliphist.nix
    ./modules/direnv.nix
    ./modules/dunst.nix
    # ./modules/eww
    ./modules/fzf.nix
    ./modules/git.nix
    ./modules/gtk.nix
    ./modules/helix.nix
    ./modules/ironbar.nix
    ./modules/nushell.nix
    ./modules/qt.nix
    ./modules/starship.nix
    ./modules/sway
    ./modules/topgrade.nix
    ./modules/vscode.nix
    ./modules/waybar.nix
    ./modules/wezterm.nix
    ./modules/xdg.nix
    nix-colors.homeManagerModule
  ];

  colorScheme = nix-colors.colorSchemes.onedark;

  programs = {
    bottom.enable = true;
    firefox.enable = true;
    home-manager.enable = true;
    mpv.enable = true;
    nix-index.enable = true;
    ripgrep.enable = true;
    zoxide.enable = true;
  };

  services = {
    playerctld.enable = true;
  };

  home = {
    packages = with pkgs; [
      fd
      dconf
      joplin
      keepassxc
      keepmenu
      obsidian
      pavucontrol
      procs
      rclone
      rm-improved
      ripgrep-all
      swayimg
      swww
      typst
      unzip
      upscayl
      wl-clipboard
    ];

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "23.11";
  };

  # Nicely reload system units when changing configs.
  systemd.user.startServices = "sd-switch";

  # Automatically set some environment variables.
  targets.genericLinux.enable = true;
}
