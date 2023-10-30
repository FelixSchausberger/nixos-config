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

    devenv.url = "github:cachix/devenv";
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = {
    # self,
    alejandra,
    home-manager,
    nix-colors,
    nixpkgs,
    # nixpkgs-wayland,
    devenv,
    ...
  } @ inputs: let
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
              inherit host nixpkgs nix-colors;
            };
          }
        ];

        # config.nixpkgs.overlays = [nixpkgs-wayland.overlay];
      };

    pkgs = nixpkgs.legacyPackages."x86_64-linux";
  in {
    devShell.x86_64-linux = devenv.lib.mkShell {
      inherit inputs pkgs;
      modules = [
        ({pkgs, ...}: {
          # This is your devenv configuration
          packages = [pkgs.hello];

          enterShell = ''
            hello
          '';

          processes.run.exec = "hello";
        })
      ];
    };

    nixosConfigurations = {
      desktop = mkSystem "desktop";
      surface = mkSystem "surface";
    };
  };
}
