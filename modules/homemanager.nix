{
  ags,
  wayland-pipewire-idle-inhibit,
  ...
}: {
  home-manager = {
    useUserPackages = true;

    users.fesch = {
      imports = [
        ../home
        ags.homeManagerModules.default
        wayland-pipewire-idle-inhibit.homeModules.default
      ];

      home = {
        homeDirectory = "/home/fesch";
        username = "fesch";
      };
    };
  };
}
