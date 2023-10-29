{
  config,
  pkgs,
  ...
}: let
  cliphist = "${pkgs.cliphist}/bin/cliphist";
  dunst = "${pkgs.dunst}/bin/dunstctl";
  gsettings = "${pkgs.glib}/bin/gsettings";
  rofi = "${pkgs.rofi-wayland}/bin/rofi";
  slurp = "${pkgs.slurp}/bin/slurp";
  swaylock = "${pkgs.swaylock-effects}/bin/swaylock --screenshots --indicator-radius 0 --effect-blur 4x5 --grace 10";
  wayshot = "${pkgs.wayshot}/bin/wayshot";
  wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";
  wpctl = "${pkgs.wireplumber}/bin/wpctl";
  playerctl = "${pkgs.playerctl}/bin/playerctl";

  editor = "hx";
  browser = "firefox";
  footclient = "${pkgs.foot}/bin/footclient";
in {
  xdg.configFile."sway/environment" = {
    executable = true;

    text = ''
      #!/bin/sh

      export TERMINAL=${footclient}
      export BROWSER=${browser}
      export EDITOR=${editor}
      export SUDO_EDITOR=${editor}
      export VISUAL=${editor}

      export SDL_VIDEODRIVER="wayland"
      export QT_QPA_PLATFORM="wayland"
      export GDK_BACKEND="wayland,x11"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export JAVA_HOME=${pkgs.jdk11}/lib/openjdk

      export MOZ_ENABLE_WAYLAND=1
      export MOZ_WEBRENDER=1
      export MOZ_ACCELERATED=1
    '';
  };

  wayland.windowManager.sway = {
    enable = true;
    # package = pkgs.swayfx;

    config = rec {
      menu = "${rofi} -show drun";
      terminal = "${footclient}";
      modifier = "Mod4";

      startup = [
        {command = "autotiling";}
        {command = "eww daemon && eww open bar";}
        {command = "foot --server";}
        {command = "${gsettings} set org.gnome.desktop.interface gtk-theme 'Adwaita-dark";}
        {command = "${gsettings} set org.gnome.desktop.interface icon-theme 'Adwaita";}
        {command = "swww init && swww img ${../pixel-lofi-city-moewalls-com.gif}";}
      ];

      seat = {
        "*" = {
          hide_cursor = "10000";
          xcursor_theme = "Adwaita 24";
        };
      };

      keybindings = pkgs.lib.mkOptionDefault {
        "${modifier}+w" = "kill";
        "${modifier}+t" = "layout tabbed";

        # Browser
        "${modifier}+b" = "exec ${browser}";

        # Clipboard picker
        "${modifier}+v" = "exec ${cliphist} list | rofi -dmenu | ${cliphist} decode | ${wl-copy}";

        # Cycle through workspaces
        "${modifier}+tab" = "workspace next_on_output";
        "${modifier}+Shift+tab" = "workspace prev_on_output";

        # File Manager
        "${modifier}+e" = "exec ${footclient} -e ${pkgs.joshuto}/bin/joshuto";

        # Toggle bar
        "Control+Return" = "exec ~/.nixos/home/modules/eww/widgets/result/bin/toggle bar";

        # Notification daemon
        "Control+Space" = "exec ${dunst} close";
        "Control+Shift+Space" = "exec ${dunst} close-all";
        "Control+m" = "exec ${dunst} set-paused toggle";

        # Scratchpad
        "${modifier}+Shift+minus" = "move scratchpad";
        "${modifier}+minus" = "scratchpad show";

        # Screenshots
        "${modifier}+Shift+s" = "exec ${wayshot} -s $(${slurp}) | --stdout | ${wl-copy}";

        # Manual lock
        "--release ${modifier}+l" = "exec loginctl lock-session";

        # Multimedia
        "--locked XF86AudioRaiseVolume" = "exec ${wpctl} set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+";
        "--locked XF86AudioLowerVolume" = "exec ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "--locked XF86AudioMute" = "exec ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "--locked XF86AudioPlay" = "exec ${playerctl} play-pause";
        "--locked XF86AudioNext" = "exec ${playerctl} next";
        "--locked XF86AudioPrev" = "exec ${playerctl} previous";

        # Window switcher
        "${modifier}+a" = "exec ${rofi} -show window";

        # Move focused window
        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";
        # Ditto, with arrow keys
        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";
      };

      window.commands = [
        # Volume Control
        {
          criteria = {app_id = "pavucontrol";};
          command = "floating enable";
        }

        # Steam
        {
          criteria = {class = "Steam";};
          command = "floating enable";
        }
      ];

      modes = {
        resize = {
          h = "resize shrink width 25px";
          j = "resize grow height 25px";
          k = "resize shrink height 25px";
          l = "resize grow width 25px";

          Left = "resize shrink width 25px";
          Down = "resize grow height 25px";
          Up = "resize shrink height 25px";
          Right = "resize grow width 25px";

          Return = "mode \"default\"";
          Escape = "mode \"default\"";
        };
      };

      bars = [];

      gaps.inner = 10;

      floating.border = 3;
      window.border = 3;
      window.titlebar = false;

      colors = {
        focused = {
          background = "#181818"; # "#${config.colorScheme.colors.base00}";
          border = "#1a1a1a"; # "#${config.colorScheme.colors.base00}";
          childBorder = "#1a1a1a"; # "#${config.colorScheme.colors.base00}";
          indicator = "#1a1a1a"; # "#${config.colorScheme.colors.base00}";
          text = "#b7bcb9";
        };
        focusedInactive = {
          background = "#181818"; # "#${config.colorScheme.colors.base00}";
          border = "#1a1a1a"; # "#${config.colorScheme.colors.base00}";
          childBorder = "#1a1a1a"; # "#${config.colorScheme.colors.base00}";
          indicator = "#1a1a1a"; # "#${config.colorScheme.colors.base00}";
          text = "#b7bcb9";
        };
        unfocused = {
          background = "#181818"; # "#${config.colorScheme.colors.base00}";
          border = "#1a1a1a"; # "#${config.colorScheme.colors.base00}";
          childBorder = "#1a1a1a"; # "#${config.colorScheme.colors.base00}";
          indicator = "#1a1a1a"; # "#${config.colorScheme.colors.base00}";
          text = "#b7bcb9";
        };
        urgent = {
          background = "#${config.colorScheme.colors.base08}";
          border = "#${config.colorScheme.colors.base08}";
          childBorder = "#${config.colorScheme.colors.base08}";
          indicator = "#${config.colorScheme.colors.base08}";
          text = "#b7bcb9";
        };
      };
    };

    extraConfig = ''
      for_window [class="."] inhibit_idle fullscreen
      for_window [app_id="."] inhibit_idle fullscreen

      # SwayFX settings
      shadows enable

      corner_radius 12

      blur enable
      blur_radius 7
      blur_passes 4
    '';
  };

  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${swaylock}";
      }
      {
        event = "lock";
        command = "${swaylock}";
      }
    ];
    timeouts = [
      {
        timeout = 300;
        command = "${swaylock}";
      }
      {
        timeout = 600;
        command = "swaymsg 'output * dpms off' resume swaymsg 'output * dpms on'";
      }
    ];
  };

  # use systemd to manage some services
  systemd.user.services.autotiling = {
    Unit.Description = "autotiling daemon";
    Service.ExecStart = "${pkgs.autotiling}/bin/autotiling";
    Install.WantedBy = ["sway-session.target"];
  };

  systemd.user.services.polkit = {
    Unit.Description = "polkit daemon";
    Service.ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    Install.WantedBy = ["sway-session.target"];
  };

  systemd.user.services.rclone = {
    Unit.Description = "rclone daemon";
    Service.ExecStart = "mkdir -p ~/Shared && ${pkgs.rclone} --vfs-cache-mode writes mount 'gDrive': '~/Shared'";
    Install.WantedBy = ["sway-session.target"];
  };

  systemd.user.services.wl-clipbpoard = {
    Unit.Description = "clipboard daemon";
    Service.ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${cliphist} store";
    Install.WantedBy = ["sway-session.target"];
  };

  systemd.user.services.wlsunset = {
    Unit.Description = "wlsunset daemon";
    Service.ExecStart = "${pkgs.wlsunset}/bin/wlsunset -l 45.5 -L -122.6 -g 0.8";
    Install.WantedBy = ["sway-session.target"];
  };
}
