{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tlp
  ];

  wayland.windowManager.hyprland.settings = {
    input = {
      kb_layout = "de";
    };

    binde = [
      ", XF86MonBrightnessUp, exec, ${pkgs.swayosd}/bin/swayosd-client --brightness raise"
      ", XF86MonBrightnessDown, exec, ${pkgs.swayosd}/bin/swayosd-client --brightness lower"

      "$mod, m, exec, ${pkgs.swayosd}/bin/swayosd-client --brightness raise"
      "$mod, m, exec, ${pkgs.light}/bin/light -A 10"

      "$mod, k, exec, ${pkgs.swayosd}/bin/swayosd-client --brightness lower"
      "$mod, k, exec, ${pkgs.light}/bin/light -U 10"

      # ", XF86MonBrightnessUp, exec, ${pkgs.light}/bin/light -A 10"
      # ", XF86MonBrightnessDown, exec, ${pkgs.light}/bin/light -U 10"
    ];
  };
}
