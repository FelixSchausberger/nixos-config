{pkgs, ...}: let
  swaylock = "${pkgs.swaylock-effects}/bin/swaylock -f --screenshots --indicator-radius 0 --effect-blur 4x5 --grace 10 --fade-in 8";

  dpmsOffCommand = "hyprctl dispatch dpms off";
  dpmsOnCommand = "hyprctl dispatch dpms on";
in {
  home = {
    packages = with pkgs; [
      hypridle
    ];

    file.".config/hypr/hypridle.conf".text = ''
      general {
        lock_cmd = ${swaylock} # dbus/sysd lock command (loginctl lock-session)
      }

      listener {
        timeout = 300
        on-timeout = ${swaylock}
      }

      listener {
        timeout = 600
        on-timeout = ${dpmsOffCommand}
        on-resume = ${dpmsOnCommand}
      }
    '';
  };
}
