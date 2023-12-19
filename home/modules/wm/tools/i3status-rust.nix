{
  programs.i3status-rust = {
    enable = true;
    bars = {
      bottom = {
        blocks = [
          {
            block = "battery";
            format = " $percentage {$time |}";
            device = "DisplayDevice";
            driver = "upower";
            missing_format = "";
          }
          {
            block = "bluetooth";
            mac = "F8:4E:17:6A:E0:15"; # WH-1000XM4
            disconnected_format = "";
            format = " $icon ";
            # battery_state = [
            #   "0..20" = "critical";
            #   "21..70" = "warning";
            #   "71..100" = "good";
            # ];
          }
          # {
          #   block = "bluetooth";
          #   mac = "6C:93:08:60:64:F8"; # Keychron K8 Pro
          #   disconnected_format = "";
          #   format = " $icon ";
          #   # battery_state = [
          #   #   "0..20" = "critical";
          #   #   "21..70" = "warning";
          #   #   "71..100" = "good";
          #   # ];
          # }
          # {
          #   block = "bluetooth";
          #   mac = "68:6C:E6:5F:DD:29"; # Xbox Wireless Controller
          #   disconnected_format = "";
          #   format = " $icon ";
          #   # battery_state = [
          #   #   "0..20" = "critical";
          #   #   "21..70" = "warning";
          #   #   "71..100" = "good";
          #   # ];
          # }
          {
            block = "net";
            format = " $icon ";
            format_alt = " $icon {$signal_strength $ssid $frequency|Wired connection} via $device ";
          }
          {
            block = "sound";
            click = [
              {
                button = "left";
                cmd = "pavucontrol --tab=3";
              }
            ];
          }
          {
            block = "time";
            interval = 60; # Update time block every 60 seconds
            format = " $timestamp.datetime(f:'%a %d.%m %R') ";
          }
        ];

        # Bar settings
        settings = {
          theme = {
            theme = "semi-native";
            overrides = {
              # Uncomment the following line to set a background color for a specific state
              # good_bg = "#242424";

              # idle_bg = "#123456";  # Background color when idle
              # idle_fg = "#abcdef";  # Foreground color when idle
            };
          };
        };

        icons = "awesome5"; # Icon set for the bar
        theme = "gruvbox-dark"; # Color theme for the bar
      };
    };
  };
}
