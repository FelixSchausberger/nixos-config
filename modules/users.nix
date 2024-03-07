{ home-manager, pkgs, ... }:

{
  imports = [
    # Import home-manager module
    home-manager.nixosModules.home-manager

    # Import Home-Manager configuration for user 'fesch'
    ./homemanager.nix
  ];

  users.users = {
    fesch = {
      isNormalUser = true;
      description = "Felix Schausberger";
      extraGroups = [ "networkmanager" "video" "wheel" ];
      # shell = pkgs.nushell;
    };
  };

  services.getty.autologinUser = "fesch";
  security.sudo.configFile = ''
    fesch  ALL=(ALL:ALL) NOPASSWD:ALL
  '';
}
