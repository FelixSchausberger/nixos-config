{ pkgs, ... }:

let
  audioControl = "${pkgs.wireplumber}/bin/wpctl";
  browser = "${pkgs.firefox}/bin/firefox";
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  editor = "${pkgs.helix}/bin/hx";
  gnomeSettings = "${pkgs.glib}/bin/gsettings";
  dunst = "${pkgs.dunst}/bin/dunstctl";
in
{
  xdg.configFile."sway/environment" = {
    executable = true;

    text = ''
      #!/bin/env bash

      export TERMINAL="${pkgs.wezterm}/bin/wezterm"
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
    package = pkgs.swayfx;
    wrapperFeatures.gtk = true;

    config = rec {
      terminal = "${pkgs.wezterm}/bin/wezterm";
      modifier = "Mod4";
      # menu = "exec anyrun";

      startup = [
        { command = "${pkgs.autotiling}/bin/autotiling"; }
        { command = "${gnomeSettings} set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'"; }
        { command = "${gnomeSettings} set org.gnome.desktop.interface icon-theme 'Adwaita'"; }
        { command = "exec ${pkgs.swayest-workstyle}/bin/sworkstyle &> /tmp/sworkstyle.log"; }
      ];

      keybindings = pkgs.lib.mkOptionDefault {
        "${modifier}+w" = "kill";
        "${modifier}+t" = "layout tabbed";

        # Application launcher
        "${modifier}+a" = "exec ${pkgs.nwg-drawer}/bin/nwg-drawer";

        # Browser
        "${modifier}+b" = "exec ${browser}";

        # Clipboard pickers
        "${modifier}+v" = "exec ${terminal} start --class=floating-mode ${../scripts/result/bin/cliphist}";

        # Cycle through workspaces
        "${modifier}+tab" = "workspace next_on_output";
        "${modifier}+Shift+tab" = "workspace prev_on_output";

        # File Manager
        "${modifier}+e" = "exec ${terminal} start --class=floating-mode ${pkgs.broot}/bin/broot";

        # Find
        "${modifier}+space" = "exec ${terminal} start --class=floating-mode ${pkgs.ripgrep-all}/bin/rga-fzf";

        # Manual lock
        "--release ${modifier}+l" = "exec loginctl lock-session";

        # Multimedia
        "--locked XF86AudioRaiseVolume" = "exec ${audioControl} set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+";
        "--locked XF86AudioLowerVolume" = "exec ${audioControl} set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "--locked XF86AudioMute" = "exec ${audioControl} set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "--locked XF86AudioPlay" = "exec ${playerctl} play-pause";
        "--locked XF86AudioNext" = "exec ${playerctl} next";
        "--locked XF86AudioPrev" = "exec ${playerctl} previous";

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

        # Notification daemon
        "Control+Space" = "exec ${dunst} close";
        "Control+Shift+Space" = "exec ${dunst} close-all";
        "Control+m" = "exec ${dunst} set-paused toggle";

        # Scratchpad
        "${modifier}+Shift+minus" = "move scratchpad";
        "${modifier}+minus" = "scratchpad show";

        # Screenshots
        "Print" = "exec ${pkgs.shotman}/bin/shotman --capture region --copy";

        # Show waybar
        "${modifier}" = "swaymsg bar hidden_state show";
      };

      output = {
        "*" = { bg = "${../wallpaper.jpg} fill"; };
      };

      seat = {
        "*" = {
          hide_cursor = "10000";
          xcursor_theme = "breeze_cursors 24";
        };
      };

      window.commands = [
        { criteria = { app_id = "pavucontrol"; }; command = "floating enable"; }
        { criteria = { class = "Steam"; }; command = "floating enable"; }
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

      bars = [{
        # command = "i3status-rs";
        command = "waybar";
        mode = "hide";
      }];

      gaps.inner = 10;

      floating.border = 3;
      window.border = 3;
      window.titlebar = false;

      colors = {
        focused = {
          background = "#181818";
          border = "#1a1a1a";
          childBorder = "#1a1a1a";
          indicator = "#1a1a1a";
          text = "#b7bcb9";
        };
        focusedInactive = {
          background = "#181818";
          border = "#1a1a1a";
          childBorder = "#1a1a1a";
          indicator = "#1a1a1a";
          text = "#b7bcb9";
        };
        unfocused = {
          background = "#181818";
          border = "#1a1a1a";
          childBorder = "#1a1a1a";
          indicator = "#1a1a1a";
          text = "#b7bcb9";
        };
        urgent = {
          background = "#e06c75";
          border = "#e06c75";
          childBorder = "#e06c75";
          indicator = "#e06c75";
          text = "#b7bcb9";
        };
      };
    };
  };
}
