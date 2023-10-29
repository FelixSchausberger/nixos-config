{pkgs, ...}: {
  home.packages = with pkgs; [
    # freecad
    linuxKernel.packages.linux_zen.xpadneo
    lutris-unwrapped
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
