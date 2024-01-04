{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tlp
  ];

  wayland.windowManager.hyprland.settings.input = {
    kb_layout = "de";
  };

  wayland.windowManager.sway.config = {
    input = {
      "*" = {
        xkb_layout = "de";
      };
    };
  };
}
