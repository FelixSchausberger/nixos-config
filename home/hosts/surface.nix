{ config, pkgs, ... }:

{ 
  home.packages = [
    pkgs.light
    pkgs.tlp
  ];
    
  wayland.windowManager.sway.config = {
    input = {
      "*" = {
	      xkb_layout = "de";
      };
    };
    
    keybindings = pkgs.lib.mkOptionDefault {
      # Brightness
      "XF86MonBrightnessDown" = "exec light -U 10";
      "XF86MonBrightnessUp" = "exec light -A 10";

      # Volume
      "XF86AudioRaiseVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ +1%'";
      "XF86AudioLowerVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ -1%'";
      "XF86AudioMute" = "exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'";
    };
  };
}
