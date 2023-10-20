{ pkgs, pkgs-unstable, ... }:

{ 
  home.packages = [
    pkgs.lutris
    pkgs-unstable.wineWowPackages.waylandFull
    pkgs.linuxKernel.packages.linux_zen.xpadneo
  ];
  
  wayland.windowManager.sway.config = {
    input = {
      "*" = {
	      xkb_layout = "eu";
      };
    };
  };
}
