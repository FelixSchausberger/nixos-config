# {
#   systemd.user.services.wayland-pipewire-idle-inhibit = {
#     Unit = {
#       Description = "Inhibit Wayland idling when media is played through pipewire";
#       Documentation = "https://github.com/rafaelrc7/wayland-pipewire-idle-inhibit";
#     };

#     Service = {
#       ExecStart = "wayland-pipewire-idle-inhibit";
#       Restart = "always";
#       RestartSec = 10;
#     };

#     Install.WantedBy = ["graphical-session.target"];
#   };
# }

{
  services.wayland-pipewire-idle-inhibit = {
    enable = true;
    systemdTarget = "graphical-session.target";
    settings = {
      verbosity = "INFO";
      media_minimum_duration = 10;
      # sink_whitelist = [
      #   { name = "Starship/Matisse HD Audio Controller Analog Stereo"; }
      # ];
      # node_blacklist = [
      #   { name = "spotify"; }
      #   { app_name = "Music Player Daemon"; }
      # ];
    };
  };
}
