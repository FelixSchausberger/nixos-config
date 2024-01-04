{ pkgs, ... }:
{
  systemd.user.services.swayosd = {
    Unit.Description = "swayosd daemon";
    Service.ExecStart = "${pkgs.swayosd}/bin/swayosd-libinput-backend";
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
