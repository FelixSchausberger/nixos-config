{ host, ... }:

{
  programs.topgrade = {
    enable = true;
    settings = {
      disable = [ 
        "system" 
      ];
      commands = {
        "System update" = "sudo nixos-rebuild --flake ~/.nixos/#${host} switch --upgrade";
        "Run garbage collection on Nix store" = "nix-collect-garbage";
      };
    };
  };
}
