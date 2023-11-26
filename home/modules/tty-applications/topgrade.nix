{ config, ... }:
{
  programs.topgrade = {
    enable = true;
    settings = {
      misc = { };
      commands = {
        "Run garbage collection on Nix store" = "nix-collect-garbage";
      };
      linux = {
        nix_arguments = "--flake ${config.home.homeDirectory}/.nixos";
      };
    };
  };
}
