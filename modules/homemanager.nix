{ inputs, ... }:

{
  home-manager = {
    useUserPackages = true;

    users.fesch = {
      imports = [
        ../home
        inputs.wayland-pipewire-idle-inhibit.homeModules.default
      ];

      home = {
        homeDirectory = "/home/fesch";
        username = "fesch";
      };
    };
  };
}
