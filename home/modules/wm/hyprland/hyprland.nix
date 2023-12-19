{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    settings = {
      env = [
        "QT_QPA_PLATFORM,wayland"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
      ];

      monitor = "HDMI-A-1,1920x1080@60,0x0,1"; # Desktop

      decoration = {
        shadow_offset = "0 5";
        "col.shadow" = "rgba(00000099)";
        rounding = 10;

        blur.enabled = true;

        layerrule = [
          "blur,gtk-layer-shell"
          "blur,notifications"
        ];

        windowrule = [
          "float,^(pavucontrol)$"
          "float,^(Steam)$"
        ];
      };

      group = {
        groupbar = {
          font_family = "Fira Code NF";
          font_size = 14;
        };
      };

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      "$mod" = "SUPER";
      "$terminal" = "${pkgs.kitty}/bin/kitty";
      "$fileManager" = "spacedrive";
      "$menu" = "exec $terminal start --class=floating-mode ${../scripts/result/bin/launcher}";

      exec-once = "${pkgs.waybar}/bin/waybar & hyprctl exec ${pkgs.hyprpaper}/bin/hyprpaper wallpaper ',${config.home.homeDirectory}/.nixos/home/modules/wm.wallpaper.jpg' & ${pkgs.udiskie}/bin/udiskie";

      # misc = {
      #   # See https://wiki.hyprland.org/Configuring/Variables/ for more
      #   force_default_wallpaper = 0; # Set to 0 to disable the anime mascot wallpapers
      # };

      bindm = [
        # mouse movements    "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];

      bind = [
        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        "$mod, Return, exec, $terminal"
        "$mod, F, exec, firefox"
        ", Print, exec, ${pkgs.shotman}/bin/shotman --capture region --copy"
        "$mod, Q, killactive"
        "$mod, E, exit"
        "$mod, A, exec, ${pkgs.nwg-drawer}/bin/nwg-drawer"
        "$mod, V, exec, $terminal start --class=floating-mode ${../scripts/result/bin/cliphist}"

        # Move focus with mainMod + arrow keys
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # Example special workspace (scratchpad)
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mainMod + scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList
          (
            x:
            let
              ws =
                let
                  c = (x + 1) / 10;
                in
                builtins.toString (x + 1 - (c * 10));
            in
            [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );
    };
  };
}
