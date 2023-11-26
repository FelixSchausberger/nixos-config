{ pkgs, ... }:
{
  # Import configurations of graphical applications
  imports = [
    ./firefox
    ./configs
    ./libraries
    ./dunst.nix
    ./i3status-rust.nix
    ./mpv.nix
    ./nwg-drawer.nix
    ./vscode.nix
    ./waybar.nix
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
      obsidian
      upscayl
    ];
  };
}
