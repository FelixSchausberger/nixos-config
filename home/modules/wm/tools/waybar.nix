{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        ipc = true;
        layer = "top";
        position = "bottom";
        height = 45;

        modules-left = [ "hyprland/workspaces" "sway/workspaces" ];
        modules-center = [ ];
        modules-right = [ "idle_inhibitor" "pulseaudio" "backlight" "battery" "network" "tray" "clock" ];

        "backlight" = {
          format = "{percent}% {icon}";
          format-icons = [ "" "" ];
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% 󰂄";
          format-alt = "{time} {icon}";
          format-icons = [ "" "" "" "" "" ];
        };

        "clock" = {
          format = "{:%H:%M}";
          format-alt = "{:%A, %B %d, %Y (%R)}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-click-forward = "tz_up";
            on-click-backward = "tz_down";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };

        "network" = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "󰈀";
          tooltip-format = "{ifname} via {gwaddr}";
          format-linked = "{ifname} (No IP)";
          format-disconnected = "⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };

        "pulseaudio" = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}";
          format-bluetooth-muted = "{icon} {format_source}";
          format-muted = "{format_source}";
          format-source = "";
          format-source-muted = "";
          format-icons = {
            headphone = "󰋋";
            hands-free = "󰋋";
            headset = "󰋎";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        };

        "hyprland/workspaces" = {
          format = "{name}"; # "{icon}";
          disable-scroll = true;
          all-outputs = true;
          spacing = 10;
        };

        "sway/workspaces" = {
          format = "{icon}";
          disable-scroll = true;
          all-outputs = true;
          spacing = 10;
        };

        "tray" = {
          icon-size = 21;
          spacing = 10;
        };
      };
    };
    style = ''
      * {
        border: none;
        border-radius: 0px;
        font-family: FiraCode;
        font-size: 18px;
        min-height: 0;
        /* background-color: transparent; */
        color: white;
      }
      
      #backlight,
      #battery,
      #clock,
      #idle_inhibitor,
      #network,
      #pulseaudio,
      #tray {
        background-color: rgba(24, 24, 24, 0.7);
        color: white;
        padding: 10px;
      }

      @keyframes blink {
        to {
          color: red;
        }
      }

      #battery.critical:not(.charging) {
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #clock {
        border-radius: 0px 20px 20px 0px;
        padding: 10px 20px;
        margin: 0px 2px 2px 0px;
      }

      #idle_inhibitor {
        border-radius: 20px 0px 0px 20px;
        padding: 10px 20px;
        margin: 0px 0px 2px 0px;
      }
      
      #network.disconnected,
      #pulseaudio.muted,
      #workspaces button.urgent {
        color: red;
      }
      
      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
      }

      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
        margin-left: 0px;
      }

      window#waybar {
        background: transparent;
      }

      #workspaces button {
        background-color: rgba(24, 24, 24, 0.7);
        border-radius: 20px;
        margin: 2px;
      }

      #workspaces button.focused {
        color: lightblue;
      }
    '';
  };
}
