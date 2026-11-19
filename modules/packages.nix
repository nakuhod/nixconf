{ pkgs, ... }:
{
  programs.thunar.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
    enableEarlyBootBlocking = false;
  };

  environment.systemPackages = with pkgs; [
    awww
    blanket
    firefox
    gimp
    kdePackages.kclock
    kdePackages.okular
    monero-gui
    mpv
    nsxiv
    obs-studio
    openvpn
    ungoogled-chromium
    (tomato-c.overrideAttrs (old: {
      patches = (old.patches or [ ]) ++ [
        ./patches/tomato-config.patch
      ];
    }))
    (emacsWithPackagesFromUsePackage {
      package = pkgs.emacs;
      config = ../dotfiles/emacs/config.el;
      alwaysEnsure = true;
      defaultInitFile = true;
      alwaysTangle = false;
    })
  ];
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
    nerd-fonts.caskaydia-mono
    nerd-fonts.fira-code
    terminus_font_ttf
  ];
}
