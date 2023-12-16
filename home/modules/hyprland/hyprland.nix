{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    settings = {
      decoration = {
        shadow_offset = "0 5";
        "col.shadow" = "rgba(00000099)";
        rounding = 10;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;

          vibrancy = 0.1696;
        };
      };

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      "$mod" = "SUPER";
      "$terminal" = "${pkgs.kitty}/bin/kitty";
      "$fileManager" = "spacedrive";
      "$menu" = "exec $terminal start --class=floating-mode ${../sway/scripts/result/bin/launcher}";

      exec-once = [
        "${pkgs.waybar}/bin/waybar"
        "${pkgs.hyprpaper}/bin/hyprpaper"
      ];

      misc = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        force_default_wallpaper = 0; # Set to 0 to disable the anime mascot wallpapers
      };

      bindm = [
        # mouse movements    "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];

      bind = [
        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        "$mod, Return, exec, $terminal"
        "$mod, F, exec, firefox"
        ", Print, exec, ${pkgs.shotman}/bin/shotman --capture region --copy"
        "$mod, Q, killactive"
        "$mod, E, exit"
        "$mod, A, exec, ${pkgs.nwg-drawer}/bin/nwg-drawer"
        "$mod, V, exec, $terminal start --class=floating-mode ${../sway/scripts/result/bin/cliphist}"

        # Move focus with mainMod + arrow keys
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # Example special workspace (scratchpad)
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mainMod + scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList
          (
            x:
            let
              ws =
                let
                  c = (x + 1) / 10;
                in
                builtins.toString (x + 1 - (c * 10));
            in
            [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );
    };

    # extraConfig = ''
    #   # $mod = SUPER
    #   # $terminal = wezterm

    #   bind = $mod, F, exec, firefox
    #   bind = , Print, exec, grimblast copy area

    #   # workspaces
    #   # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
    #   ${builtins.concatStringsSep "\n" (builtins.genList (
    #       x: let
    #         ws = let
    #           c = (x + 1) / 10;
    #         in
    #           builtins.toString (x + 1 - (c * 10));
    #       in ''
    #         bind = $mod, ${ws}, workspace, ${toString (x + 1)}
    #         bind = $mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
    #       ''
    #     )
    #     10)}
    # '';
  };
}
