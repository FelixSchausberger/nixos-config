{ config, ... }:

{
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${config.home.homeDirectory}/.nixos/home/modules/wm/wallpaper.jpg
    wallpaper = ,${config.home.homeDirectory}/.nixos/home/modules/wm/wallpaper.jpg
  '';
}
