{ pkgs, ... }:
let
  # FirefoxProfilePath = ".mozilla/firefox";
  NativeMessagingHostsPath = ".mozilla/native-messaging-hosts";
  ff-mpv = pkgs.writeScript "ff2mpv" (''
    #!${pkgs.python3}/bin/python
  ''
  + builtins.readFile ../config/firefox/NativeMessagingHosts/ff2mpv.py);
in
{
  programs.firefox = {
    enable = true;
    profiles."default" = {
      search = {
        force = true;
        engines = {
          "Nix" = {
            urls = [{ template = "https://search.nixos.org/options?type=options&query={searchTerms}"; }];
            iconURL = "https://nixos.org/favicon.ico";
            definedAliases = [ "@nx" ];
          };

          "GitHub" = {
            urls = [{ template = "https://github.com/search?q={searchTerms}&type=repositories"; }];
            iconURL = "https://github.com/favicon.ico";
            definedAliases = [ "@gh" ];
          };

          "YouTube" = {
            urls = [{ template = "https://www.youtube.com/results?search_query={searchTerms}"; }];
            iconURL = "https://www.youtube.com/favicon.ico";
            definedAliases = [ "@yt" ];
          };

          # disable default search engines
          "Amazon.com".metaData.hidden = true;
          "Bing".metaData.hidden = true;
          # "DuckDuckGo".metaData.hidden = true;
          "eBay".metaData.hidden = true;
          "Wikipedia (en)".metaData.hidden = true;
        };
      };
    };
  };

  #  https://support.mozilla.org/en-US/kb/understanding-depth-profile-installation
  #  Linux firefox wrapper set MOZ_LEGACY_PROFILES=1 by default
  #  Under macOS, we need to set System-level environment variable MOZ_LEGACY_PROFILES=1 by launchctl setenv, See modules/os/darwin/launchd.nix
  home.file = {
    # woodruffw/ff2mpv
    "${NativeMessagingHostsPath}/ff2mpv.json".text = ''
      {
        "name": "ff2mpv",
        "description": "ff2mpv's external manifest",
        "path": "${ff-mpv}",
        "type": "stdio",
        "allowed_extensions": ["ff2mpv@yossarian.net"]
      }
    '';
  };
}
