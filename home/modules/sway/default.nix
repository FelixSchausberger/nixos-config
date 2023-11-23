{ config
, pkgs
, ...
}:
let
  dunst = "${pkgs.dunst}/bin/dunstctl";
  gsettings = "${pkgs.glib}/bin/gsettings";
  swaylock = "${pkgs.swaylock-effects}/bin/swaylock --screenshots --indicator-radius 0 --effect-blur 4x5 --grace 10";
  wpctl = "${pkgs.wireplumber}/bin/wpctl";
  playerctl = "${pkgs.playerctl}/bin/playerctl";

  editor = "hx";
  browser = "firefox";
in
{
  xdg.configFile."sway/environment" = {
    executable = true;

    text = ''
      #!/bin/sh

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

  home.packages = with pkgs; [
    slurp
    swayimg
  ];

  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
    wrapperFeatures.gtk = true;
    extraSessionCommands = ''
      ## Internal variables
      SWAY_EXTRA_ARGS=""

      ## General exports
      export XDG_CURRENT_DESKTOP=sway
      export XDG_SESSION_DESKTOP=sway
      export XDG_SESSION_TYPE=wayland

      ## Hardware compatibility
      # We can't be sure that the virtual GPU is compatible with Sway.
      # We should be attempting to detect an EGL driver instead, but that appears
      # to be a bit more complicated.
      case $(systemd-detect-virt --vm) in
          "none"|"")
              ;;
          "kvm")
              # https://github.com/swaywm/sway/issues/6581
              export WLR_NO_HARDWARE_CURSORS=1
              # There's two drivers we can get here, depending on the 3D acceleration
              # flag state: either virtio_gpu/virgl or kms_swrast/llvmpipe.
              #
              # The former one causes graphical glitches in OpenGL apps when using
              # 'pixman' renderer. The latter will crash 'gles2' renderer outright.
              # Neither of those support 'vulkan'.
              #
              # The choice is obvious, at least until we learn to detect the driver
              # instead of abusing the virtualization technology identifier.
              #
              # See also: https://gitlab.freedesktop.org/wlroots/wlroots/-/issues/2871
              export WLR_RENDERER=pixman
              ;;
          *)
              # https://github.com/swaywm/sway/issues/6581
              export WLR_NO_HARDWARE_CURSORS=1
              ;;
      esac

      ## Load system environment customizations
      if [ -f /etc/sway/environment ]; then
          set -o allexport
          # shellcheck source=/dev/null
          . /etc/sway/environment
          set +o allexport
      fi

      ## Load user environment customizations
      if [ -f "''${XDG_CONFIG_HOME:-$HOME/.config}/sway/environment" ]; then
          set -o allexport
          # shellcheck source=/dev/null
          . "''${XDG_CONFIG_HOME:-$HOME/.config}/sway/environment"
          set +o allexport
      fi

      ## Unexport internal variables
      # export -n is not POSIX :(
      _SWAY_EXTRA_ARGS="$SWAY_EXTRA_ARGS"
      unset SWAY_EXTRA_ARGS

      # Start sway with extra arguments and send output to the journal
      # shellcheck disable=SC2086 # quoted expansion of EXTRA_ARGS can produce empty field
      exec systemd-cat -- sway $_SWAY_EXTRA_ARGS "$@"
    '';

    config = rec {
      terminal = "${pkgs.wezterm}/bin/wezterm";
      menu = "exec ${terminal} start --class=floating-mode ${scripts/result/bin/launcher}";
      modifier = "Mod4";

      startup = [
        { command = "${pkgs.autotiling}/bin/autotiling"; }
        { command = "${gsettings} set org.gnome.desktop.interface gtk-theme 'Adwaita-dark"; }
        { command = "${gsettings} set org.gnome.desktop.interface icon-theme 'Adwaita"; }
        { command = "exec ${pkgs.swayest-workstyle}/bin/sworkstyle &> /tmp/sworkstyle.log"; }
      ];

      output = {
        "*" = { bg = "${../../wallpaper.jpg} fill"; };
      };

      seat = {
        "*" = {
          hide_cursor = "10000";
          xcursor_theme = "breeze_cursors 10";
        };
      };

      keybindings = pkgs.lib.mkOptionDefault {
        "${modifier}+w" = "kill";
        "${modifier}+t" = "layout tabbed";

        # Application launcher
        "${modifier}+a" = "exec ${pkgs.nwg-drawer}/bin/nwg-drawer";

        # Browser
        "${modifier}+b" = "exec ${browser}";

        # Clipboard pickers
        "${modifier}+v" = "exec ${terminal} start --class=floating-mode ${scripts/result/bin/cliphist}";

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
        "--locked XF86AudioRaiseVolume" = "exec ${wpctl} set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+";
        "--locked XF86AudioLowerVolume" = "exec ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "--locked XF86AudioMute" = "exec ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle";
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

      window.commands = [
        # Volume Control
        {
          criteria = { app_id = "pavucontrol"; };
          command = "floating enable";
        }

        # Steam
        {
          criteria = { class = "Steam"; };
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

      bars = [{
        command = "waybar";
        mode = "hide";
      }];

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
      bar {
        swaybar_command waybar
        mode hide
        hidden_state show
        hidden_state hide
      }

      # bar {
      #   font pango:Fira Code 12
      #   position bottom
      #   status_command i3status-rs ${config.home.homeDirectory}/.config/i3status-rust/config-bottom.toml
      #   colors {
      #       separator #666666
      #       background #22222209
      #       statusline #dddddd
      #       focused_workspace #0088CC #0088CC #ffffff
      #       active_workspace #333333 #333333 #ffffff
      #       inactive_workspace #333333 #333333 #888888
      #       urgent_workspace #2f343a #900000 #ffffff
      #   }
      # }
      
      for_window [class="."] inhibit_idle fullscreen
      for_window [app_id="."] inhibit_idle fullscreen
      for_window [app_id="floating-mode"] floating enable
      
      # SwayFX settings
      shadows enable

      corner_radius 12

      blur enable
      blur_radius 7
      blur_passes 4

      layer_effects "gtk-layer-shell" blur enable; shadows enable; corner_radius 12
      layer_effects "notifications" blur enable; shadows enable; corner_radius 12
      layer_effects "panel" corner_radius 12
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
  systemd.user.services.polkit = {
    Unit.Description = "polkit daemon";
    Service.ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    Install.WantedBy = [ "sway-session.target" ];
  };

  systemd.user.services.wlsunset = {
    Unit.Description = "wlsunset daemon";
    Service.ExecStart = "${pkgs.wlsunset}/bin/wlsunset -l 45.5 -L -122.6 -g 0.8";
    Install.WantedBy = [ "sway-session.target" ];
  };
}
