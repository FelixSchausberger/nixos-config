{ pkgs, ... }: # pkgs-unstable, ... }:
{
  # Import configurations of graphical applications
  imports = [
    ./eww
    ./firefox
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

  home = {
    packages = [
      pkgs.celeste
      pkgs.krita
      pkgs.obsidian
      pkgs.overskride
      pkgs.qbittorrent
      pkgs.rnote
      pkgs.spacedrive
      pkgs.upscayl
    ];
  };
}
