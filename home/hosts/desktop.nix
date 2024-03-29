{ pkgs, ... }: {
  home.packages = with pkgs; [
    freecad
    freetype
    linuxKernel.packages.linux_zen.xpadneo
    lutris
    minecraft
    prusa-slicer
    steam
    wineWowPackages.waylandFull
  ];

  wayland.windowManager.hyprland.settings.input = {
    kb_layout = "eu";
    kb_options = caps:swapescape # Swap Caps-Lock and Escape 
  };
}
