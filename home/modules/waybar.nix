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

        modules-left = [ "sway/workspaces" ];
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
          format = "{:%d %b %H:%M}";
          tooltip-format = "{:%Y %B \t week: %V }\n<tt>{calendar}</tt>";
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

        "sway/workspaces" = {
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
        background-color: transparent;
        color: white;
      }
      
      #backlight,
      #battery,
      #clock,
      #idle_inhibitor,
      #network,
      #pulseaudio,
      #tray {
        background-color: #171717;
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
      }

      #idle_inhibitor {
        border-radius: 20px 0px 0px 20px;
        padding: 10px 20px;
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

      #workspaces button {
        background-color: #171717;
        border-radius: 20px;
        margin: 2px;
      }

      #workspaces button.focused {
        color: lightblue;
      }
    '';
  };
}
