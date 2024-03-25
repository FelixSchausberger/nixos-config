{pkgs, ...}: let
  browser = "${pkgs.firefox}/bin/firefox";
  dunst = "${pkgs.dunst}/bin/dunstctl";
  editor = "${pkgs.helix}/bin/hx";
  terminal = "${pkgs.wezterm}/bin/wezterm";
in {
  wayland.windowManager.hyprland = {
    enable = true;

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
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "${pkgs.hypridle}/bin/hypridle"
        "${pkgs.hyprpaper}/bin/hyprpaper"
        "${pkgs.udiskie}/bin/udiskie"
        "${pkgs.swayosd}/bin/swayosd-server"
        "[workspace special:magic silent] wezterm start --class=floating-mode"
      ];

      misc = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        force_default_wallpaper = 0; # Set to 0 to disable the anime mascot wallpapers
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      binde = [
        ", XF86AudioRaiseVolume, exec, ${pkgs.swayosd}/bin/swayosd-client --output-volume raise --max-volume 150"
        ", XF86AudioLowerVolume, exec, ${pkgs.swayosd}/bin/swayosd-client --output-volume lower --max-volume 150"
      ];

      bindm = [
        # mouse movements    "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod alt, mouse:272, resizewindow"
      ];

      bindr = [
        "$mod, l, exec, loginctl lock-session"
        "caps, caps_lock, exec, ${pkgs.swayosd}/bin/swayosd-client --caps-lock"
      ];

      bind =
        [
          # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
          "$mod, return, exec, $terminal"
          "$mod, f, exec, ${browser}"
          ", print, exec, ${pkgs.wl-clipboard}/bin/wl-copy < <(${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" -)"
          "$mod shift, q, killactive"
          "$mod shift, e, exit"
          "$mod, a, exec, ${pkgs.nwg-drawer}/bin/nwg-drawer"
          "$mod, o, exec, $terminal start --class=floating-mode ${editor} \"/mnt/gdrive/Obsidian/10 Projects/11 To Do.md\""
          "$mod, p, exec, $terminal start --class=floating-mode ${./scripts/result/bin/rbw-fzf}"
          "$mod, v, exec, $terminal start --class=floating-mode ${./scripts/result/bin/cliphist}"
          "alt, space, togglefloating"
          "$mod, c, exec, ironbar toggle-popup ironbar clock"
          "$mod, i, exec, bash -c ${./scripts/src/bin/toggle_ironbar.sh}"
          "$mod, x, exec, bash -c ${./scripts/src/bin/toggle_idle_inhibit.sh}"
          
          # Move focus with mod + arrow keys
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

          "$mod shift, left, movewindow, l"
          "$mod shift, right, movewindow, r"
          "$mod shift, up, movewindow, u"
          "$mod shift, down, movewindow, d"

          # Notification daemon
          # "ctrl, space, exec, ${dunst} close"
          # "ctrl shift, space, exec, ${dunst} close-all"
          # "ctrl, m, exec, ${dunst} set-paused, toggle"
          "$mod, n, exec, kill -s USR1 $(pidof ${pkgs.deadd-notification-center}/bin/deadd-notification-center)"
          "$mod, m, exec, notify-send.py a --hint boolean:deadd-notification-center:true string:type:pausePopups"
          "$mod, l, exec, notify-send.py a --hint boolean:deadd-notification-center:true string:type:unpausePopups"

          # Example special workspace (scratchpad)
          "$mod, s, togglespecialworkspace, magic"
          "$mod shift, s, movetoworkspace, special:magic"

          # Cycle through workspaces
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"

          "$mod shift, right, workspace, e+1"
          "$mod shift, left, workspace, e-1"

          # "CTRL, Return, exec. ${config.home.homeDirectory}/.nixos/home/modules/wm/scripts/eww/widgets/result/bin/toggle bar"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList
            (
              x: let
                ws = let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c * 10));
              in [
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
