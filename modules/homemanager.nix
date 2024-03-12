{
  ironbar,
  wayland-pipewire-idle-inhibit,
  ...
}: {
  home-manager = {
    useUserPackages = true;

    users.fesch = {
      imports = [
        ../home
        ironbar.homeManagerModules.default
        wayland-pipewire-idle-inhibit.homeModules.default
      ];

      home = {
        homeDirectory = "/home/fesch";
        username = "fesch";

        sessionVariables = {
          NIXOS_OZONE_WL = "1"; # For electron apps
          XDG_RUNTIME_DIR = "/run/user/$UID";
        };

        # Specify Home Manager release version
        stateVersion = "24.05";
      };
    };
  };
}
