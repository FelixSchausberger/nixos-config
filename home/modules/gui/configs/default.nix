{ pkgs, ... }:

{
  imports = [
    ./polkit.nix
    ./xdg.nix
  ];

  home = {
    packages = with pkgs; [
      dconf
    ];
  };
}
