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
            interval = 60;
            format = " $timestamp.datetime(f:'%a %d.%m %R') ";
          }
        ];
        settings = {
          theme = {
            theme = "native";
            overrides = {
              # good_bg = "#24242407";
              idle_bg = "#123456";
              idle_fg = "#abcdef";
            };
          };
        };
        icons = "awesome6";
        theme = "gruvbox-dark";
      };
    };
  };
}
