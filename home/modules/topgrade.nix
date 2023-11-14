{ config, host, ... }:
{
  programs.topgrade = {
    enable = true;
    settings = {
      misc = { };
      # disable = [ 
      #   "system" 
      # ];
      commands = {
        "System update" = "nix flake update -I ${config.home.homeDirectory}/.nixos; sudo nixos-rebuild --upgrade --flake ${config.home.homeDirectory}/.nixos/#${host} switch";
        "Run garbage collection on Nix store" = "nix-collect-garbage";
      };
    };
  };
}
