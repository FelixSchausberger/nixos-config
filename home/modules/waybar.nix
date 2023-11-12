{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        height = 35;
        spacing = 4;
        margin-top = 10;
        margin-bottom = 5;

        modules-left = [ "sway/workspaces" ];
        modules-center = [ ];
        modules-right = [ "idle_inhibitor" "pulseaudio" "backlight" "battery" "network" "tray" "clock" ];

        "backlight" = {
          format = "{percent}% {icon}";
          format-icons = [ "" "" ];
        };

        "battery" = {
          states = {
            # "good" = 95;
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% 󰂄";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = [ "" "" "" "" "" ];
        };

        # "clock" = {       
        #   tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        #   format-alt = "{:%Y-%m-%d}";
        # };

        "clock" = {
          # interval = 60;
          format = "<big>{:%d %b %H:%M}</big>";
          # tooltip = true;
          tooltip-format = "<big>{:%Y %B \t week: %V }\n<tt>{calendar}</tt></big>";
          # on-click = "foot --hold -e $HOME/.config/waybar/scripts/clock";
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
          format-bluetooth = "{volume}% {icon}";
          format-bluetooth-muted = "{icon} {format_source}";
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
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #custom-media,
      #custom-launcher,
      #custom-power,
      #custom-layout,
      #custom-updater,
      #custom-snip,
      #taskbar,
      #tray,
      #mode,
      #idle_inhibitor,
      #mpd {
          padding: 0 10px;
          color: #ffffff;
      }

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

      #cpu {
          background-color: #171717;
          color: #ffffff;
      }

      #memory {
          background-color: #171717;
          color: #ffffff;
      }

      #disk {
          background-color: #171717;
          color: #ffffff;
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

      #custom-media {
          background-color: #8EC5FC;
          background-image: linear-gradient(62deg, #8EC5FC 0%, #E0C3FC 100%);
          color: black;
          border-radius: 20px;
          margin-right: 5px;
          margin-left: 5px;
      }

      #custom-media.custom-spotify {
          background-color: #8EC5FC;
          background-image: linear-gradient(62deg, #8EC5FC 0%, #E0C3FC 100%);
          color: black;
          border-radius: 20px;
          margin-right: 5px;

      }

      #custom-media.custom-vlc {
          background-color: #8EC5FC;
          background-image: linear-gradient(62deg, #8EC5FC 0%, #E0C3FC 100%);
          color: black;
          border-radius: 20px;
          margin-right: 5px;
      }

      #custom-power{
          background-color: #171717;
          font-size: 18px;
          border-radius: 0px 20px 20px 0px;
          margin-right: 5px;

      }

      #custom-launcher{
          background-color: #171717;
          font-size: 20px;
          border-radius: 20px 0px 0px 20px;
          margin-left: 5px;

      }

      #custom-layout{
          background-color: #171717;
          color: white;
          font-size:20px;
      }

      #custom-updater {
          background-color: #171717;
          color: white;
      }

      #custom-snip {
          background-color: #171717;
          color: skyblue;
          font-size: 20px;
      }


      #taskbar{
          background-color: #171717;
          border-radius: 0px 20px 20px 0px;
      }

      #temperature {
          background-color: #171717;
          color: #ffffff;
      }

      #temperature.critical {
          background-color: #eb4d4b;
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

      #language {
          background-color: #171717;
          color: #ffffff;
          min-width: 16px;
      }

      #keyboard-state {
          background: #97e1ad;
          color: #000000;
          min-width: 16px;
      }

      #keyboard-state > label {
          padding: 0px 5px;
      }

      #keyboard-state > label.locked {
          background: rgba(0, 0, 0, 0.2);
      }
    '';
    systemd.enable = true;
    systemd.target = "sway-session.target";
  };
}
