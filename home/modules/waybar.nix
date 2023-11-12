{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        height = 35;
        spacing = 4;
        # margin-top = 10;
        # margin-bottom = 5;

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
          # format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = [ "" "" "" "" "" ];
        };

        "clock" = {
          format = "<big>{:%d %b %H:%M}</big>";
          # tooltip-format = "<big>{:%Y %B \t week: %V }\n<tt>{calendar}</tt></big>";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
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
          on-click = "NetworkManager";
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
          on-click = "pavucontrol";
        };

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };

        "tray" = {
          icon-size = 20;
          spacing = 10;
        };
      };
    };
    style = ''
      * {
        border: none;
        border-radius: 0px;
        /* `otf-font-awesome` is required to be installed for icons */
        font-family: Roboto, Helvetica, Arial, sans-serif;
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background-color: transparent;
        color: #ffffff;
        transition-property: background-color;
        transition-duration: .5s;
      }

      window#waybar.hidden {
        opacity: 0.2;
      }

      #workspaces button {
        background: #1f1f1f;
        color: #ffffff;
        border-radius: 20px;

      }

      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      #workspaces button:hover {
        background: lightblue;
        color: black;
        border-bottom: 3px solid #ffffff;

      }

      #workspaces button.focused {
        background: #1f1f1f;
      }

      #workspaces button.focused:hover {
        background: lightblue;
        color: black;
        border-bottom: 3px solid #ffffff;

      }

      #workspaces button.urgent {
        background-color: #eb4d4b;
      }

      #mode {
        background-color: #64727D;
        border-bottom: 3px solid #ffffff;
      }

      #clock,
      #battery,
      #backlight,
      #network,
      #pulseaudio,
      #tray,
      #idle_inhibitor,

      #window,
      #workspaces {
        margin: 0px 4px;
      }

      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
        margin-left: 0px;
      }

      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
        margin-right: 0px;
      }

      #clock {
        background-color: #171717;
        color: #ffffff;
      }

      #battery {
        background-color: #ffffff;
        color: #000000;
      }

      #battery.charging, #battery.plugged {
        color: #ffffff;
        background-color: #26A65B;
      }

      @keyframes blink {
        to {
          background-color: #ffffff;
          color: #000000;
        }
      }

      #battery.critical:not(.charging) {
        background-color: #f53c3c;
        color: #ffffff;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      label:focus {
        background-color: #000000;
      }

      #backlight {
        background-color: #90b1b1;
      }

      #network {
        background-color: #171717;
        color: #ffffff;
      }

      #network.disconnected {
        background-color: #171717;
        color: red;
      }

      #pulseaudio {
        background-color: #171717;
        color: #ffffff;
      }

      #pulseaudio.muted {
        background-color: #171717;
        color: red;
      }

      #taskbar{
        background-color: #171717;
        border-radius: 0px 20px 20px 0px;
      }

      #tray {
        background-color: #171717;
        color: #ffffff;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
        background-color: #171717;
        color: #ffffff;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background-color: #171717;
        color: #ffffff;
      }

      #idle_inhibitor {
        background-color: #171717;
        border-radius: 20px 0px 0px 20px;

      }

      #idle_inhibitor.activated {
        background-color: #171717;
        color: #ffffff;
        border-radius: 20px 0px 0px 20px;
      }
    '';
    systemd.enable = true;
    systemd.target = "sway-session.target";
  };
}
