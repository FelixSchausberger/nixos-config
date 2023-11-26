{
  xdg = {
    enable = true;
    mime.enable = true;
    # portal.config.common.default = "*";

    configFile = {
      "mimeapps.list".text = ''
        [Default Applications]
        text/html=firefox.desktop
        text/plain=Helix.desktop
        
        x-scheme-handler/http=firefox.desktop
        x-scheme-handler/https=firefox.desktop

        image/gif=swayimg.desktop
        image/jpeg=swayimg.desktop
        image/png=swayimg.desktop

        video/mp4=mpv.desktop
        video/quicktime=mpv.desktop
      '';

      "user-dirs.dirs".text = ''
        # User directories
        XDG_DESKTOP_DIR="$HOME/Desktop"
        XDG_DOCUMENTS_DIR="$HOME/Documents"
        XDG_DOWNLOAD_DIR="$HOME/Downloads"
        XDG_MUSIC_DIR="$HOME/Music"
        XDG_PICTURES_DIR="$HOME/Pictures"
        XDG_PUBLICSHARE_DIR="$HOME/Public"
        XDG_TEMPLATES_DIR="$HOME/Templates"
        XDG_VIDEOS_DIR="$HOME/Videos"
      '';
    };
  };
}
