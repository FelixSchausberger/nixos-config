{ pkgs, pkgs, ... }: # pkgs-unstable, ... }:

{ 
  home.packages = with pkgs; [
    freecad # -unstable
    linuxKernel.packages.linux_zen.xpadneo    
    lutris
    wineWowPackages.waylandFull # -unstable
  ];
  
  wayland.windowManager.sway.config = {
    input = {
      "*" = {
	      xkb_layout = "eu";
      };
    };
  };
}
