{ host, ... }:

{
  programs.topgrade = {
    enable = true;
    settings = {
      misc = {};
      # disable = [ 
      #   "system" 
      # ];
      commands = {
        # "System update" = "sudo nixos-rebuild --flake ~/.nixos/#${host} switch --upgrade";
        "Run garbage collection on Nix store" = "nix-collect-garbage";
      };
    };
  };
}
