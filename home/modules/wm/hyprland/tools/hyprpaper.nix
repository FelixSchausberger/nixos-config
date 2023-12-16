{ config, ... }:

{
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${config.home.homeDirectory}/.nixos/home/modules/wm/wallpaper.jpg
    wallpaper = monitor1,${config.home.homeDirectory}/.nixos/home/modules/wm/wallpaper.jpg
  '';
}
