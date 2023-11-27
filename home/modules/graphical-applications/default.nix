{ pkgs, ... }:
{
  # Import configurations of graphical applications
  imports = [
    ./firefox
    ./configs
    ./libraries
    ./dunst.nix
    ./mpv.nix
    ./nwg-drawer.nix
    ./vscode.nix
    ./wezterm.nix
  ];

  # Enabled graphical applications
  programs = {
    sioyek.enable = true;
  };

  # Add packages
  home = {
    packages = with pkgs; [
      dconf
      krita
      obsidian
      rnote
      upscayl
    ];
  };
}
