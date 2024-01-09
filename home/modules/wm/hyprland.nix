{ hycov, pkgs, ... }: # pkgs-unstable, ... }:

let
  browser = "${pkgs.firefox}/bin/firefox";
  dunst = "${pkgs.dunst}/bin/dunstctl";
  editor = "${pkgs.helix}/bin/hx";
  terminal = "${pkgs.wezterm}/bin/wezterm"; # "${pkgs.foot}/bin/footclient";
in
{
  wayland.windowManager.hyprland = {
    enable = true;

    plugins = [
      hycov.packages.${pkgs.system}.hycov
    ];

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
          "float, ^(pavucontrol)$"
          "float, ^(Steam)$"
          "float, ^(floating-mode)$"
        ];
      };

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      "$mod" = "SUPER";
      "$terminal" = "${terminal}";
      "$fileManager" = "${pkgs.spacedrive}/bin/spacedrive";

      exec-once = [
        "${pkgs.hyprpaper}/bin/hyprpaper"
        "${pkgs.udiskie}/bin/udiskie"
        # "${pkgs.foot}/bin/foot --server"
        "${pkgs.swayosd}/bin/swayosd-server"
        "${pkgs.sway-audio-idle-inhibit}/bin/sway-audio-idle-inhibit"
        # "[workspace special:magic silent] foot --app-id=floating-mode"
        "[workspace special:magic silent] $terminal --class=floating-mode"
      ];

      misc = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        force_default_wallpaper = 0; # Set to 0 to disable the anime mascot wallpapers
      };

      binde = [
        ", XF86AudioRaiseVolume, exec, ${pkgs.swayosd}/bin/swayosd-client --output-volume raise --max-volume 150"
        ", XF86AudioLowerVolume, exec, ${pkgs.swayosd}/bin/swayosd-client --output-volume lower --max-volume 150"
      ];

      bindm = [
        # mouse movements    "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];

      bindr = [
        "$mod, l, exec, loginctl lock-session"
        "CAPS, Caps_Lock, exec, ${pkgs.swayosd}/bin/swayosd-client --caps-lock"
      ];

      bind = [
        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        "$mod, Return, exec, $terminal"
        "$mod, F, exec, ${browser}"
        # ", Print, exec, ${pkgs.shotman}/bin/shotman --capture region --copy"
        ", Print, exec, ${pkgs.watershot}/bin/watershot -c -g ${pkgs.grim}/bin/grim directory ~/screenshots"
        "$mod SHIFT, Q, killactive"
        "$mod SHIFT, E, exit"
        "$mod, A, exec, ${pkgs.nwg-drawer}/bin/nwg-drawer"
        "$mod, V, exec, $terminal start --class=floating-mode ${../scripts/result/bin/cliphist}"
        # "$mod, V, exec, $terminal --app-id=floating-mode ${../scripts/result/bin/cliphist}"
        "ALT, SPACE, togglefloating"

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
        "$mod, mouse_up, workspace, e-1"

        "$mod, n, workspace, e+1"
        "$mod, p, workspace, e-1"
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
    '' + ''
      # hycov plugin
      bind = $mod, tab, hycov:enteroverview
      bind = $mod, tab, submap, switch
      submap = switch
        bind = $mod, left, hycov:movefocus,l
        bind = $mod, right, hycov:movefocus,r
        bind = $mod, up, hycov:movefocus,u
        bind = $mod, down, hycov:movefocus,d
        
        bind = , escape, hycov:leaveoverview
        bind = , escape, submap, reset
        bind = , return, hycov:leaveoverview
        bind = , return, submap, reset
        bind = $mod, tab, hycov:leaveoverview
        bind = $mod, tab, submap, reset
      submap = reset
      
      plugin {
          hycov {
            overview_gappo = 60 # gaps width from screen
            overview_gappi = 24 # gaps width from clients
      	    hotarea_size = 10 # hotarea size in bottom left,10x10
      	    enable_hotarea = 1 # enable mouse cursor hotarea
          }
      }
    '';
  };
}
