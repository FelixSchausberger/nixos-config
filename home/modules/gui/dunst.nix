{ pkgs, ... }:

{
  services.dunst = {
    enable = true;

    # Icon theme configuration
    iconTheme = {
      name = "Tela";
      package = pkgs.tela-icon-theme;
    };

    settings = {
      global = {
        width = 300;
        height = 300;
        offset = "30x50";
        origin = "top-right";
        transparency = 1;
        frame_color = "#37474f03";
        font = "Fira Code Nerd Font 14";
      };

      urgency_normal = {
        background = "#37474f03";
        foreground = "#b6bdca"; # "#eceff1";
        timeout = 10;
      };
    };
  };
}
