{ pkgs, pkgs-unstable, ... }:

let
  #   audioControl = "${pkgs.wireplumber}/bin/wpctl";
  #   playerctl = "${pkgs.playerctl}/bin/playerctl";
  browser = "${pkgs.firefox}/bin/firefox";
  dunst = "${pkgs.dunst}/bin/dunstctl";
  editor = "${pkgs.helix}/bin/hx";
  terminal = "${pkgs.foot}/bin/footclient"; # "${pkgs.wezterm}/bin/wezterm";
in
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

        "TERMINAL,${terminal}"
        "BROWSER,${browser}"
        "EDITOR,${editor}"
        "SUDO_EDITOR,${editor}"
        "VISUAL,${editor}"
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
          "float,^(floating-mode)$"

          # Idle inhibit while watching videos
          "idleinhibit focus, class:^(mpv|.+exe|celluloid)$"
          "idleinhibit focus, class:^(firefox)$, title:^(.*YouTube.*)$"
          "idleinhibit fullscreen, class:^(firefox)$"
        ];
      };

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      "$mod" = "SUPER";
      "$terminal" = "${terminal}";
      "$fileManager" = "${pkgs-unstable.spacedrive}/bin/spacedrive";

      exec-once = [
        "${pkgs.waybar}/bin/waybar"
        "${pkgs.hyprpaper}/bin/hyprpaper"
        "${pkgs.udiskie}/bin/udiskie"
        "${pkgs.foot}/bin/foot --server"
        # "${pkgs.workstyle}/bin/workstyle &> /tmp/workstyle.log"
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

      bindr = [
        "$mod, l, exec, loginctl lock-session"
      ];

      bind = [
        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        "$mod, Return, exec, $terminal"
        "$mod, F, exec, ${browser}"
        ", Print, exec, ${pkgs.shotman}/bin/shotman --copy --capture region"
        "$mod SHIFT, Q, killactive"
        "$mod SHIFT, E, exit"
        "$mod, A, exec, ${pkgs.nwg-drawer}/bin/nwg-drawer"
        # "$mod, V, exec, $terminal start --class=floating-mode ${../scripts/result/bin/cliphist}"
        "$mod, V, exec, $terminal --app-id=floating-mode ${../scripts/result/bin/cliphist}"

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
        "CTRL, Space, exec, ${dunst} close"
        "CTRL SHIFT, Space, exec, ${dunst} close-all"
        "CTRL, m, exec, ${dunst} set-paused, toggle"

        # Example special workspace (scratchpad)
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"

        # Cycle through workspaces
        "$mod, mouse_down, workspace, e+1"
        "$mod, tab, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
        "$mod Shift, tab, workspace, e-1"
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
