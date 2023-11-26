{ flake-inputs, ... }:
{
  nix = {
    settings = {
      warn-dirty = false;
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  nixpkgs = {
    configallowUnfree = true;
    overlays = [ flake-inputs.nur.overlay ];
  };
}
