{ pkgs, ... }:

{
  xdg.configFile."sway/environment" = {
    executable = true;
    text = ''
      #!/bin/sh

      export TERMINAL="${pkgs.wezterm}/bin/wezterm"
      export BROWSER="${pkgs.firefox}/bin/firefox"
      export EDITOR="${pkgs.helix}/bin/helix"
      export SUDO_EDITOR="${pkgs.helix}/bin/helix"
      export VISUAL="${pkgs.helix}/bin/helix"

      export SDL_VIDEODRIVER="wayland"
      export QT_QPA_PLATFORM="wayland"
      export GDK_BACKEND="wayland,x11"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export JAVA_HOME="${pkgs.jdk11}/lib/openjdk"

      export MOZ_ENABLE_WAYLAND=1
      export MOZ_WEBRENDER=1
      export MOZ_ACCELERATED=1
    '';
  };
}
