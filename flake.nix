{
  description = "Personal NixOS config";

  inputs = {   
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixos-hardware.url   = "github:NixOS/nixos-hardware";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, home-manager, nixpkgs, nixpkgs-unstable, nixos-hardware, nix-colors }: 
  let
    mkSystem = host: nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
            
      specialArgs = {
        inherit home-manager host nixos-hardware;
        pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
      };
      
      modules = [
        ./configuration.nix
        ./hosts/${host}

        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.extraSpecialArgs = { 
            inherit host nix-colors;
            pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};          };
        }
      ];
    };
  in {
    nixosConfigurations = {
      desktop   = mkSystem "desktop";
      surface   = mkSystem "surface";
    };
  };
}

