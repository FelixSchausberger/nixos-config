{pkgs, ...}: let
  hyprlock = "${pkgs.hyprlock}/bin/hyprlock";

  dpmsOffCommand = "hyprctl dispatch dpms off";
  dpmsOnCommand = "hyprctl dispatch dpms on";
in {
  home = {
    file = {
      ".config/hypr/hypridle.conf".text = ''
        general {
          lock_cmd = ${hyprlock}
        }

        listener {
          timeout = 300
          on-timeout = ${hyprlock}
        }

        listener {
          timeout = 600
          on-timeout = ${dpmsOffCommand}
          on-resume = ${dpmsOnCommand}
        }
      '';

      ".config/hypr/hyprlock.conf".text = ''
        background {
          monitor =
          path = screenshot   # only png supported for now

          # all these options are taken from hyprland, see https://wiki.hyprland.org/Configuring/Variables/#blur for explanations
          blur_passes = 1 # 0 disables blurring
          blur_size = 7
          noise = 0.0117
          contrast = 0.8916
          brightness = 0.8172
          vibrancy = 0.1696
          vibrancy_darkness = 0.0
        }

        label {
          monitor =
          text = $TIME
          font_size = 85
          font_family = Fira Code NF bold

          position = 0, 80
          halign = center
          valign = center
        }
      '';
    };
  };
}
