{
  description = "Personal NixOS config";

  inputs = {
    # External inputs for the flake
    devenv.url = "github:cachix/devenv";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
  };

  nixConfig = {
    # Nix configuration settings
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-trusted-substituters = "https://devenv.cachix.org";
  };

  outputs =
    inputs@{ devenv
    , home-manager
    , nixpkgs
    , nur
    , self
    , ...
    }:
    let
      # Helper function to create NixOS system configurations
      mkSystem = host:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            flake-inputs = inputs;
            inherit home-manager host; # nixos-hardware home-manager
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
                inherit host nixpkgs;
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
