{ config, osConfig, pkgs, ... }:
{
  programs.mpv = {
    enable = true;
  };

  home = {
    packages = with pkgs; [
      ffmpeg
      yt-dlp
      mediainfo
    ];

    file = {
      ".config/mpv/mpv.conf".source = config.lib.file.mkOutOfStoreSymlink "${osConfig.settings.nixConfigDir}/config/mpv/mpv-linux.conf";
      ".config/mpv/scripts".source = config.lib.file.mkOutOfStoreSymlink "${osConfig.settings.nixConfigDir}/config/mpv/scripts";
      ".config/mpv/script-opts".source = config.lib.file.mkOutOfStoreSymlink "${osConfig.settings.nixConfigDir}/config/mpv/script-opts";
    };
  };
}
