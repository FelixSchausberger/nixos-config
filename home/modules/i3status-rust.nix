{
  programs.i3status-rust = {
    enable = true;
    bars = {
      bottom = {
        blocks = [
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
            interval = 60;  # Update time block every 60 seconds
            format = " $timestamp.datetime(f:'%a %d.%m %R') ";
          }
        ];

        # Bar settings
        settings = {
          theme = {
            theme = "native";
            overrides = {
              # Uncomment the following line to set a background color for a specific state
              # good_bg = "#24242407";

              idle_bg = "#123456";  # Background color when idle
              idle_fg = "#abcdef";  # Foreground color when idle
            };
          };
        };

        icons = "awesome6";     # Icon set for the bar
        theme = "gruvbox-dark";  # Color theme for the bar
      };
    };
  };
}
