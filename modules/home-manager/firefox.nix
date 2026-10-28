{
  pkgs,
  inputs,
  system,
  ...
}:

{
  programs.firefox = {
    enable = true;
    profiles.dogukan = {
      search = {
        force = true;
        default = "ddg";
        engines = {
          google = {
            urls = [
              {
                template = "https://www.google.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "https://www.google.com/favicon.ico";
            definedAliases = [ "@g" ];
          };
          duckduckgo = {
            urls = [
              {
                template = "https://noai.duckduckgo.com";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "https://duckduckgo.com/favicon.ico";
            definedAliases = [ "@ddg" ];
          };
          youtube = {
            urls = [
              {
                template = "https://youtube.com/results";
                params = [
                  {
                    name = "search_query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "https://youtube.com/favicon.ico";
            definedAliases = [ "@yt" ];
          };
          nix-packages = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          nix-options = {
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "type";
                    value = "options";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@no" ];
          };
        };
      };

      settings = {
        "dom.security.https_only_mode" = true;
        "browser.download.panel.shown" = true;
        "browser.bookmarks.addedImportButton" = false;
        "identity.fxaccounts.enabled" = false;
        "signon.rememberSignons" = false;
        "sidebar.verticalTabs" = true;
        "general.autoScroll" = true;
        "layout.css.prefers-color-scheme.content-override" = 0;
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "full-screen-api.warning.timeout" = 0;
        "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
        "browser.toolbars.bookmarks.visibility" = "always";
        "browser.uiCustomization.state" = ''
          {"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["sponsorblocker_ajay_app-browser-action"],
                            "nav-bar":["reset-pbm-toolbar-button","back-button","forward-button","stop-reload-button","home-button","sidebar-button","urlbar-container","vertical-spacer","ublock0_raymondhill_net-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","addon_darkreader_org-browser-action","unified-extensions-button","downloads-button"]
                                ,"toolbar-menubar":["menubar-items"],
                            "TabsToolbar":[],
                            "vertical-tabs":["tabbrowser-tabs"],
                            "PersonalToolbar":["import-button","personal-bookmarks"]},
              "seen":["reset-pbm-toolbar-button","developer-button","screenshot-button","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","addon_darkreader_org-browser-action","sponsorblocker_ajay_app-browser-action","ublock0_raymondhill_net-browser-action"],
              "dirtyAreaCache":["nav-bar","TabsToolbar","vertical-tabs","unified-extensions-area","toolbar-menubar","PersonalToolbar"],
              "currentVersion":24,
              "newElementCount":4}
        '';
      };

      extensions.packages = with inputs.firefox-addons.packages.${system}; [
        bitwarden
        ublock-origin
        sponsorblock
        darkreader
        foxyproxy-standard
      ];

    };
  };
}
