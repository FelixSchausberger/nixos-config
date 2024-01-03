{ anyrun, pkgs, ... }:

{
  programs.anyrun = {
    enable = true;
    config = {
      plugins = with anyrun.packages.${pkgs.system}; [
        applications # Search and run system & user specific desktop entries.
        # dictionary # Look up definitions for words.
        # kidex # File search provided by Kidex.
        # randr # Rotate and resize; quickly change monitor configurations on the fly.
        rink # Calculator & unit conversion.
        # shell # Run shell commands.
        # symbols # Search unicode symbols.
      ];
      y = { fraction = 0.5; };
    };

    extraCss = ''
      box#main {
        background-color: rgba(0, 0, 0, 0);
      }
    '';
  };
}
