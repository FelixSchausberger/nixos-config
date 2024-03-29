{
  description = "Personal NixOS config";

  inputs = {
    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devenv.url = "github:cachix/devenv";
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    ironbar = {
      url = "github:JakeStanger/ironbar";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    scripts.url = "./home/modules/wm/scripts";
    wayland-pipewire-idle-inhibit = {
      url = "github:rafaelrc7/wayland-pipewire-idle-inhibit";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    extra-trusted-substituters = [
      "https://nix-community.cachix.org"
      # "https://devenv.cachix.org"
    ];

    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      # "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    ];
  };

  outputs = inputs @ {
    alejandra,
    devenv,
    home-manager,
    ironbar,
    nixpkgs,
    nur,
    self,
    scripts,
    wayland-pipewire-idle-inhibit,
    ...
  }: let
    mkSystem = host:
      nixpkgs.lib.nixosSystem {
        # rec {
        system = "x86_64-linux";
        specialArgs = {
          secrets = builtins.fromJSON (builtins.readFile "${self}/secrets/secrets.json");
          flake-inputs = inputs;
          inherit ironbar home-manager host wayland-pipewire-idle-inhibit;
        };

        modules = [
          nur.nixosModules.nur
          scripts.nixosModules
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
              inherit host ironbar nixpkgs;
            };
          }
        ];
      };

    # Use stable packages for a specific architecture
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
  in {
    # Development shell configuration
    devShell.x86_64-linux = devenv.lib.mkShell {
      inherit inputs pkgs;
      modules = [
        {
          # Enable pre-commit hooks for various languages/tools
          pre-commit.hooks = {
            alejandra.enable = true; # Nix: Rust, opinionated
            black.enable = true; # Python
            clang-format.enable = true; # C
            deadnix.enable = true; # Nix
            markdownlint.enable = true; # Markdown
            nil.enable = true; # Nix
            # nixfmt.enable = true; # Nix: Haskell, will probably become standard
            # nixpkgs-fmt.enable = true; # Nix: Rust, de-facto default formatter
            shellcheck.enable = true; # Shell
            taplo.enable = true; # Rust
            yamllint.enable = true; # YAML
          };
        }
      ];
    };

    # NixOS system configurations
    nixosConfigurations = {
      desktop = mkSystem "desktop";
      surface = mkSystem "surface";
    };
  };
}
