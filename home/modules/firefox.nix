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

      settings = {
        # Performance settings
        "gfx.webrender.all" = true; # Force enable GPU acceleration
        "media.ffmpeg.vaapi.enabled" = true;
        "widget.dmabuf.force-enabled" = true; # Required in recent Firefoxes

        # Hide the "sharing indicator", it's especially annoying
        # with tiling WMs on wayland
        "privacy.webrtc.legacyGlobalIndicator" = false;

        # Actual settings
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.contentblocking.category" = "strict";
        # "browser.ctrlTab.recentlyUsedOrder" = false;
        "browser.discovery.enabled" = false;
        "browser.laterrun.enabled" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" =
          false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" =
          false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned" = "";
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.searchEngines" = "";
        "browser.newtabpage.activity-stream.section.highlights.includePocket" =
          false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.pinned" = false;
        "browser.protections_panel.infoMessage.seen" = true;
        "browser.quitShortcut.disabled" = true;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.ssb.enabled" = true;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.urlbar.placeholderName" = "DuckDuckGo";
        "browser.urlbar.suggest.openpage" = false;
        "datareporting.policy.dataSubmissionEnable" = false;
        "datareporting.policy.dataSubmissionPolicyAcceptedVersion" = 2;
        "dom.security.https_only_mode" = true;
        "dom.security.https_only_mode_ever_enabled" = true;
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "extensions.pocket.enabled" = false;
        "identity.fxaccounts.enabled" = false;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
      };
    };
  };
}
