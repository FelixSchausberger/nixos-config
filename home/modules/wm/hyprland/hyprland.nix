{ pkgs, ... }:

# let
#   audioControl = "${pkgs.wireplumber}/bin/wpctl";
#   playerctl = "${pkgs.playerctl}/bin/playerctl";
#   gnomeSettings = "${pkgs.glib}/bin/gsettings";
# dunst = "${pkgs.dunst}/bin/dunstctl";
# in
{
  wayland.windowManager.hyprland = {
    settings = {
      env = [
        "QT_QPA_PLATFORM,wayland"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "MOZ_ENABLE_WAYLAND,1"
        "MOZ_WEBRENDER,1"
        "MOZ_ACCELERATED,1"
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
          "float, app_id='floating-mode'"

          # Idle inhibit while watching videos
          "idleinhibit focus, class:^(mpv|.+exe|celluloid)$"
          "idleinhibit focus, class:^(firefox)$, title:^(.*YouTube.*)$"
          "idleinhibit fullscreen, class:^(firefox)$"
        ];
      };

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      "$mod" = "SUPER";
      "$terminal" = "${pkgs.wezterm}/bin/wezterm";
      "$fileManager" = "spacedrive";
      "$menu" = "anyrun";

      exec-once = [
        "${pkgs.waybar}/bin/waybar"
        "${pkgs.hyprpaper}/bin/hyprpaper"
        "${pkgs.udiskie}/bin/udiskie"
        "${pkgs.workstyle}/bin/workstyle &> /tmp/workstyle.log"
      ];

      misc = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        force_default_wallpaper = 0; # Set to 0 to disable the anime mascot wallpapers
      };

      bindm = [
        # mouse movements    "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];

      # Show waybar when mod is pressed
      # bindt = ", Super_L, exec, pkill -SIGUSR1 waybar";
      # bindrt = "SUPER, Super_L, exec, pkill -SIGUSR1 waybar";

      bind = [
        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        "$mod, Return, exec, $terminal"
        "$mod, Space, exec, $menu"
        "$mod, F, exec, firefox"
        ", Print, exec, ${pkgs.shotman}/bin/shotman --capture region --copy"
        "$mod SHIFT, Q, killactive"
        "$mod SHIFT, E, exit"
        "$mod, A, exec, ${pkgs.nwg-drawer}/bin/nwg-drawer"
        "$mod, V, exec, $terminal start --class=floating-mode ${../scripts/result/bin/cliphist}"

        # Move focus with mod + arrow keys
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"

        # Notification daemon
        # "CTRL, exec ${dunst} close"
        # "Control SHIFT, Space, exec ${dunst} close-all"
        # "Control, m, exec ${dunst} set-paused toggle"

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

    extraConfig = ''
      # window resize
      bind = $mod, R, submap, resize
      submap = resize
      binde = , right, resizeactive, 10 0
      binde = , left, resizeactive, -10 0
      binde = , up, resizeactive, 0 -10
      binde = , down, resizeactive, 0 10
      bind = , escape, submap, reset
      submap = reset
    '';
  };
}
