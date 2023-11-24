{
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
