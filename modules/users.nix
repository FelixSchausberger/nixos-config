{home-manager, ...}: {
  imports = [
    home-manager.nixosModules.home-manager
  ];

  users.users = {
    fesch = {
      isNormalUser = true;
      description = "Felix Schausberger";
      extraGroups = ["networkmanager" "video" "wheel"];
    };
  };

  services.getty.autologinUser = "fesch";
  security.sudo.configFile = ''
    fesch  ALL=(ALL:ALL) NOPASSWD:ALL
  '';

  home-manager = {
    useUserPackages = true;
    users.fesch = {
      imports = [ ../home ];
      home = {
        homeDirectory = "/home/fesch";
        username = "fesch";
      };
    };
  };
}
