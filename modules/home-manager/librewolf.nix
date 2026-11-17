{
  pkgs,
  ...
}:

{
  programs.librewolf = {
    enable = true;
    package = pkgs.librewolf-bin;

    profiles.default = {
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
        "full-screen-api.warning.timeout" = 0;
        "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
        "general.autoScroll" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.toolbars.bookmarks.visibility" = "never";
      };

      userChrome = ''
        #TabsToolbar { display: none !important; }
        #sidebar-header { display: none !important; }
        #sidebar-panel-header { display: none !important; }
        #sidebar-box { padding-inline-start: 0px !important; }

        * { border-radius: 0px !important; }
      '';
    };
  };
}
