{
  description = "Personal NixOS config";

  inputs = {   
    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";

    nixos-hardware.url   = "github:NixOS/nixos-hardware";    
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # nixos-23.05";
    # nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
  let
    mkSystem = host: nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
            
      specialArgs = {
        inherit home-manager host nixos-hardware;
        # pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
      };
      
      modules = [
        {
          environment.systemPackages = [ alejandra.defaultPackage.${system} ];
        }
        ./configuration.nix
        ./hosts/${host}

        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.extraSpecialArgs = { 
            inherit host nix-colors;
            # pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
          };
        }
      ];

      nixpkgs.overlays = [ nixpkgs-wayland.overlay ];
    };
  in {
    nixosConfigurations = {
      desktop   = mkSystem "desktop";
      surface   = mkSystem "surface";
    };
  };
}

