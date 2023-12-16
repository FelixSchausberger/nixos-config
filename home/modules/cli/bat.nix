{ pkgs, ... }:

{
  # Configuration for the 'bat' package
  programs.bat = {
    enable = true;

    # Additional packages from 'bat-extras'
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      batgrep
      batwatch
    ];
  };
}

