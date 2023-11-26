{ pkgs, ... }:

{
  gtk = {
    # Enable GTK configuration
    enable = true;

    # Theme configuration
    theme = {
      name = "Arc-Dark";
      package = pkgs.arc-theme;
    };

    # Icon theme configuration
    iconTheme = {
      name = "Tela";
      package = pkgs.tela-icon-theme;
    };

    # Cursor theme configuration
    cursorTheme = {
      name = "breeze_cursors";
      package = pkgs.breeze-gtk;
    };
  };
}
