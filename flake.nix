{
  description = "Personal NixOS config";

  inputs = {
    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    # nixpkgs-wayland = {
    #   url = "github:nix-community/nixpkgs-wayland";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = {
    self,
    alejandra,
    home-manager,
    nix-colors,
    nixpkgs,
    # nixpkgs-wayland,
    ...
  }: let
    # outputs = inputs: let
    mkSystem = host:
      nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";

        specialArgs = {
          inherit home-manager host;
        };

        modules = [
          {
            environment.systemPackages = [alejandra.defaultPackage.${system}];
          }
          ./configuration.nix
          ./hosts/${host}

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.extraSpecialArgs = {
              inherit host nix-colors;
            };
          }
        ];

        # config.nixpkgs.overlays = [nixpkgs-wayland.overlay];
      };
  in {
    nixosConfigurations = {
      desktop = mkSystem "desktop";
      surface = mkSystem "surface";
    };
  };
}
