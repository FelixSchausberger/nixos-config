{
  description = "Personal NixOS config";

  inputs = {
    devenv.url = "github:cachix/devenv";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-23.05";
  };

  nixConfig = {
    extra-trusted-public-keys =
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-trusted-substituters = "https://devenv.cachix.org";
  };

  outputs = { home-manager, devenv, nix-colors, nixpkgs, nixpkgs-stable, ... }@inputs:
    let
      mkSystem = host:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = { inherit home-manager host; };

          modules = [
            ./configuration.nix
            ./hosts/${host}

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.extraSpecialArgs = {
                inherit host nixpkgs nixpkgs-stable nix-colors;
              };
            }
          ];
        };

      pkgs = nixpkgs.legacyPackages."x86_64-linux";
    in
    {
      devShell.x86_64-linux = devenv.lib.mkShell {
        inherit inputs pkgs;
        modules = [{
          pre-commit.hooks = {
            # black.enable = true; # python
            # cargo-check.enable = true; # rust
            # clang-format.enable = true; # c
            # clippy.enable = true; # rust
            deadnix.enable = true; # nix
            markdownlint.enable = true; # markdown
            nil.enable = true; # nix
            nixpkgs-fmt.enable = true; # nix
            # shellcheck.enable = true; # shell
            # taplo.enable = true; # rust
            # yamllint.enable = true; # yaml
          };
        }];
      };

      nixosConfigurations = {
        desktop = mkSystem "desktop";
        surface = mkSystem "surface";
      };
    };
}
