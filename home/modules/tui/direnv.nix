{
  programs.direnv = {
    # Enable direnv globally
    enable = true;

    enableFishIntegration = true;

    # Enable nix-direnv integration for improved Nix support
    nix-direnv.enable = true;
  };
}
