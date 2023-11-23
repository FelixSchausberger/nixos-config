{
  programs.direnv = {
    # Enable direnv globally
    enable = true;

    # Enable nix-direnv integration for improved Nix support
    nix-direnv.enable = true;
  };
}
