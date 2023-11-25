{ pkgs, ... }:

let
  swaylock = "${pkgs.swaylock-effects}/bin/swaylock --screenshots --indicator-radius 0 --effect-blur 4x5 --grace 10";

  dpmsOffCommand = "swaymsg 'output * dpms off'";
  dpmsOnCommand = "swaymsg 'output * dpms on'";
in
{
  services.swayidle = {
    enable = true;
    events = [
      { event = "before-sleep"; command = "${swaylock}"; }
      { event = "lock"; command = "${swaylock}"; }
    ];
    timeouts = [
      { timeout = 300; command = "${swaylock}"; }
      { timeout = 600; command = "${dpmsOffCommand} && sleep 1 && ${dpmsOnCommand}"; }
    ];
  };
}

