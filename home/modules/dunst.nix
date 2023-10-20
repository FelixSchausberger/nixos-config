{ config, ... }: 

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
        frame_color = "#${config.colorScheme.colors.base00}"; # "#eceff1";
        font = "Fira Code NF 9";
      };
      
      urgency_normal = {
        background = "#${config.colorScheme.colors.base05}"; # "#37474f";
        foreground = "#${config.colorScheme.colors.base00}"; # "#eceff1";
        timeout = 10;
      };
    };
  };
}
