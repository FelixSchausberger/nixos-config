{ pkgs, ... }:

{
  # Define a set of font packages using Nerd Fonts with FiraCode
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
}
