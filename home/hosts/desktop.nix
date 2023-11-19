{ pkgs, ... }: {
  home.packages = with pkgs; [
    freecad
    linuxKernel.packages.linux_zen.xpadneo
    lutris-unwrapped
    prusa-slicer
    steam
    wineWowPackages.waylandFull
  ];

  wayland.windowManager.sway.config = {
    input = {
      "*" = {
        xkb_layout = "eu";
      };
    };
  };
}
