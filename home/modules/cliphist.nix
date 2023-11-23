{
  services.cliphist = {
    enable = true;

    # Specify the systemd target
    systemdTarget = "sway-session.target";
  };
}
