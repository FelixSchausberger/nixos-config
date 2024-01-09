{
  xdg = {
    enable = true;
    mime.enable = true;

    mimeApps = {
      enable = true;
      defaultApplications = {
        # "mimetype1" = [ "default1.desktop" "default2.desktop" ];
        "text/html" = "firefox.desktop";
        "text/plain" = "Helix.desktop";

        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";

        "image/gif" = "swayimg.desktop";
        "image/jpeg" = "swayimg.desktop";
        "image/png" = "swayimg.desktop";

        "video/mp4" = "mpv.desktop";
        "video/quicktime" = "mpv.desktop";
      };
    };

    userDirs = {
      enable = true;
    };
  };
}
