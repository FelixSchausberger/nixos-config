{ pkgs, ... }:

{
  systemd.user.sevices.i2pd = {
    Unit.Description = "i2p deamon";
    Service.ExecStart = "${pkgs.i2pd}/bin/i2pd";
    Install.WantedBy = [ "sway-session.target" ];
  };
}
