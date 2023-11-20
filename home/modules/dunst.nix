{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 300;
        height = 300;
        offset = "30x50";
        origin = "top-right";
        transparency = 10;
        frame_color = "#37474f03";
        font = "Fira Code NF 14";
      };

      urgency_normal = {
        background = "#37474f03";
        foreground = "#eceff1";
        timeout = 10;
      };
    };
  };
}
