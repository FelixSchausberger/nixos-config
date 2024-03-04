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

      programs.ags = {
        enable = true;

        # null or path, leave as null if you don't want hm to manage the config
        configDir = ./ags;

        # additional packages to add to gjs's runtime
        # extraPackages = with pkgs; [
        #   gtksourceview
        #   webkitgtk
        #   accountsservice
        # ];
      };

      home = {
        homeDirectory = "/home/fesch";
        username = "fesch";
      };
    };
  };
}
