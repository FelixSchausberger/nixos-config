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
}
