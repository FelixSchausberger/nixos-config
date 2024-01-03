{ anyrun, ... }:

{
  home-manager = {
    useUserPackages = true;
    users.fesch = {
      imports = [
        anyrun.homeManagerModules.anyrun
        ../home
      ];

      home = {
        homeDirectory = "/home/fesch";
        username = "fesch";
      };
    };
  };
}
