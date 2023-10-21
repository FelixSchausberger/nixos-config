{ pkgs, pkgs-unstable, ... }:

{ 
  home.packages = [
    pkgs-unstable.freecad
    pkgs.linuxKernel.packages.linux_zen.xpadneo    
    pkgs.lutris
    pkgs-unstable.wineWowPackages.waylandFull
  ];
  
  wayland.windowManager.sway.config = {
    input = {
      "*" = {
	      xkb_layout = "eu";
      };
    };
  };
}
