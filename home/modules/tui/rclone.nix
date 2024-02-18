{
  pkgs,
  secrets,
  ...
}: let
  mountdir = "/mnt/gdrive";
in {
  systemd.user.services.gdrive_mount = {
    Unit = {
      Description = "mount gdrive dirs";
      After = ["network-online.target"];
    };
    Install.WantedBy = ["graphical-session.target"];
    Service = {
      ExecStartPre = "/run/current-system/sw/bin/mkdir -p ${mountdir}";
      ExecStart = ''
        ${pkgs.rclone}/bin/rclone mount \
            --drive-client-id ${secrets.drive.client-id} \
            --drive-client-secret ${secrets.drive.client-secret} gdrive: ${mountdir} \
              --dir-cache-time 48h \
              --vfs-cache-mode full \
              --vfs-cache-max-age 48h \
              --vfs-read-chunk-size 10M \
              --vfs-read-chunk-size-limit 512M \
              --buffer-size 512M
      '';
      ExecStop = "/run/wrappers/bin/fusermount -u ${mountdir}";
      Type = "notify";
      Restart = "always";
      RestartSec = "10s";
      Environment = ["PATH=/run/wrappers/bin/:$PATH"];
    };
  };
}
