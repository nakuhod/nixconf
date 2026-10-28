{
  description = "NixOS Config";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      mkHost =
        hostname:
        nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit self inputs;
          };

          modules = [
            ./hosts/${hostname}/configuration.nix

            {
              nixpkgs.overlays = [
                inputs.emacs-overlay.overlays.default
              ];
            }
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.dogukan = import ./home/dogukan.nix;
                backupFileExtension = "backup";
                extraSpecialArgs = {
                  inherit
                    self
                    inputs
                    system
                    hostname
                    ;
                };
              };
            }

          ];
        };
    in
    {
      nixosConfigurations = {
        desktop = mkHost "desktop";
        laptop = mkHost "laptop";

      };
    };
}
