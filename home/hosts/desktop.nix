{ pkgs, ... }: {
  home.packages = with pkgs; [
    freecad
    freetype
    linuxKernel.packages.linux_zen.xpadneo
    lutris-unwrapped
    prusa-slicer
    steam
    wineWowPackages.waylandFull
    # wine-wayland
    # winetricks
  ];

  wayland.windowManager.sway.config.input."*" = {
    xkb_layout = "eu";
  };
}
