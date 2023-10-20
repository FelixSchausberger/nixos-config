{ pkgs, ... }:

{
  gtk = {
    enable = true;
    
    theme = {
      name = "Arc-Dark";
      package = pkgs.arc-theme;
    };
    
    # iconTheme = {
    #   name = "Tela";
    #   package = pkgs.tela-icon-theme;
    # };
 
    # cursorTheme = {
    #   name = "breeze_cursors";
    #   package = pkgs.breeze-gtk;
    # };
  };
}
