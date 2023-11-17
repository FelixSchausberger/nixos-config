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
    ./modules/fzf.nix
    ./modules/git.nix
    ./modules/gtk.nix
    ./modules/helix.nix
    ./modules/nushell.nix
    ./modules/qt.nix
    ./modules/rbw.nix
    ./modules/rclone.nix
    ./modules/starship.nix
    ./modules/sway
    ./modules/sworkstyle.nix
    ./modules/tealdeer.nix
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
    ssh.enable = true;
    zoxide.enable = true;
  };

  services = {
    lorri.enable = true;
    playerctld.enable = true;
  };

  home = {
    packages = with pkgs; [
      dconf
      fd
      git-crypt
      keepassxc
      nwg-drawer
      obsidian
      pavucontrol
      pre-commit
      procs
      rm-improved
      ripgrep-all
      slurp
      swayimg
      swww
      tgpt
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
