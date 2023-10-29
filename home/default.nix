{
  host,
  nix-colors,
  pkgs,
  ...
}: {
  imports = [
    ./hosts/${host}.nix
    ./modules/bash.nix
    ./modules/bat.nix
    ./modules/blesh.nix
    ./modules/bottom.nix
    ./modules/dunst.nix
    ./modules/eww
    ./modules/firefox.nix
    ./modules/foot.nix
    ./modules/fzf.nix
    ./modules/git.nix
    ./modules/gtk.nix
    ./modules/helix.nix
    ./modules/home-manager.nix
    ./modules/mpv.nix
    ./modules/qt.nix
    ./modules/rofi.nix
    ./modules/starship.nix
    ./modules/sway.nix
    ./modules/tmux.nix
    ./modules/topgrade.nix
    # ./modules/udiskie.nix
    ./modules/vscode.nix
    ./modules/xdg.nix
    ./modules/zoxide.nix
    nix-colors.homeManagerModule
  ];

  colorScheme = nix-colors.colorSchemes.onedark;

  home = {
    homeDirectory = "/home/fesch";
    username = "fesch";

    packages = with pkgs; [
      autotiling
      eza
      deadnix
      fd
      joplin
      keepassxc
      keepmenu
      unzip
      pavucontrol
      rclone
      ripgrep
      rm-improved
      swayimg
      swww
      typst
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
    stateVersion = "23.05";
  };

  # Nicely reload system units when changing configs.
  systemd.user.startServices = "sd-switch";

  # Automatically set some environment variables.
  targets.genericLinux.enable = true;
}
