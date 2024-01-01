{
  description = "Personal NixOS config";

  inputs = {
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devenv.url = "github:cachix/devenv";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
  };

  nixConfig = {
    extra-trusted-substituters = [
      "https://nix-community.cachix.org"
      "https://devenv.cachix.org"
      "https://anyrun.cachix.org"
    ];

    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
    ];
  };

  outputs =
    inputs@{
      # anyrun
      devenv
      # , flake-parts
    , home-manager
    , nixpkgs
    , nixpkgs-unstable
    , nur
    , self
    , ...
    }:
    let
      mkSystem = host:
        nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            flake-inputs = inputs;
            inherit home-manager host;
          };

          modules = [
            nur.nixosModules.nur
            # Add the Microsoft Surface module only if the host is "surface"
            # (if host == "surface" then
            #   nixos-hardware.nixosModules.microsoft-surface-pro-intel
            #     {
            #       microsoft-surface.ipts.enable = true;
            #       config.microsoft-surface.surface-control.enable = true;
            #     }
            # else { })

            # Include custom configurations
            ./configuration.nix
            ./hosts/${host}
            # Configure Home Manager
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.extraSpecialArgs = {
                # Read secrets from a JSON file
                secrets = builtins.fromJSON (builtins.readFile "${self}/secrets/secrets.json");
                flake-inputs = inputs;
                inherit host nixpkgs nixpkgs-unstable;
                pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
              };
            }
          ];
        };

      # Use stable packages for a specific architecture
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
    in
    {
      # Development shell configuration
      devShell.x86_64-linux = devenv.lib.mkShell {
        inherit inputs pkgs;
        modules = [{
          # Enable pre-commit hooks for various languages/tools
          pre-commit.hooks = {
            black.enable = true; # Python
            clang-format.enable = true; # C
            deadnix.enable = true; # Nix
            markdownlint.enable = true; # Markdown
            nil.enable = true; # Nix
            nixpkgs-fmt.enable = true; # Nix
            shellcheck.enable = true; # Shell
            taplo.enable = true; # Rust
            yamllint.enable = true; # YAML
          };
        }];
      };

      # NixOS system configurations
      nixosConfigurations = {
        desktop = mkSystem "desktop";
        surface = mkSystem "surface";
      };
    };
}
