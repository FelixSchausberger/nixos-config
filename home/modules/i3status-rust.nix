{
  programs.i3status-rust = {
    enable = true;
    bar = {
      bottom = {
        blocks = [
          {
            block = "disk_space";
            path = "/";
            info_type = "available";
            interval = 60;
            warning = 20.0;
            alert = 10.0;
          }
          {
            block = "memory";
            format_mem = " $icon $mem_used_percents ";
            format_swap = " $icon $swap_used_percents ";
          }
          {
            block = "cpu";
            interval = 1;
          }
          {
            block = "load";
            interval = 1;
            format = " $icon $1m ";
          }
          { block = "sound"; }
          {
            block = "time";
            interval = 60;
            format = " $timestamp.datetime(f:'%a %d/%m %R') ";
          }
        ];
        settings = {
          theme = {
            theme = "solarized-dark";
            overrides = {
              idle_bg = "#123456";
              idle_fg = "#abcdef";
            };
          };
        };
        icons = "awesome5";
        theme = "gruvbox-dark";
      };
      blocks = [
        {
          block = "disk_space";
          path = "/";
          info_type = "available";
          interval = 60;
          warning = 20.0;
          alert = 10.0;
        }
        {
          block = "sound";
          format = " $icon $output_name {$volume.eng(w:2) |}";
          click = [
            {
              button = "left";
              cmd = "pavucontrol --tab=3";
            }
          ];
          mappings = {
            "alsa_output.pci-0000_00_1f.3.analog-stereo" = "";
            "bluez_sink.70_26_05_DA_27_A4.a2dp_sink" = "";
          };
        }
      ];
    };
  };
}
