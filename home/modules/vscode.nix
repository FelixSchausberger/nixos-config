{
  programs.vscode = {
    enable = true;
  };

  # Set environment variable for NixOS Ozone Wayland integration
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
