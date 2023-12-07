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

  home = {
    packages = with pkgs; [
      krita
      obsidian
      rnote
      spacedrive
      upscayl
    ];
  };
}
