{ pkgs, ... }:
let
  swaylock = "${pkgs.swaylock-effects}/bin/swaylock --screenshots --indicator-radius 0 --effect-blur 4x5 --grace 10";
in
{
  services.swayidle = {
    enable = true;
    events = [{ event = "before-sleep"; command = "${swaylock}"; }
      { event = "lock"; command = "${swaylock}"; }];
    timeouts = [{ timeout = 300; command = "${swaylock}"; }
      { timeout = 600; command = "swaymsg 'output * dpms off' resume swaymsg 'output * dpms on'"; }];
  };
}
