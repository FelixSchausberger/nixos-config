{ config, pkgs, pkgs-unstable, ... }:

{  
  programs.rofi = {
    enable = true;
    package = pkgs-unstable.rofi-wayland-unwrapped;
    # plugins = with pkgs; [
    #   rofi-calc
    #   rofi-bluetooth
    #   rofi-emoji
    #   rofi-power-menu
    #   rofi-pulse-select
    #   rofi-systemd
    # ];
    font = "Fira Code NF 18";
    terminal = "${pkgs.foot}/bin/footclient";
    # icon-theme = "Tela";
    theme = "Arc-Dark";
    # theme = 
    #   let
    #     # Use `mkLiteral` for string-like values that should show without
    #     # quotes, e.g.:
    #     # {
    #     #   foo = "abc"; => foo: "abc";
    #     #   bar = mkLiteral "abc"; => bar: abc;
    #     # };
    #     inherit (config.lib.formats.rasi) mkLiteral;
    #   in {
    #     "*" = {
    #       background-color = mkLiteral "#${config.colorScheme.colors.base00}";
    #       foreground-color = mkLiteral "#${config.colorScheme.colors.base0F}";
    #       border-color = mkLiteral "#FFFFFF";
    #       width = 512;
    #     };

    #     "#inputbar" = {
    #       children = map mkLiteral [ "prompt" "entry" ];
    #     };

    #     "#textbox-prompt-colon" = {
    #       expand = false;
    #       str = ":";
    #       margin = mkLiteral "0px 0.3em 0em 0em";
    #       text-color = mkLiteral "@foreground-color";
    #     };
    #   };
    extraConfig = {
      modi = "drun,filebrowser,window";
      kb-primary-paste = "Control+V,Shift+Insert";
      kb-secondary-paste = "Control+v,Insert";
    };
  };
}
