{ pkgs, ... }:
{
  programs.mpv = {
    enable = true;
  };

  home = {
    packages = with pkgs; [
      ffmpeg
      # yt-dlp
      # mediainfo
    ];
  };
}
