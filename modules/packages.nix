{ pkgs, ... }:
{
  programs.wireshark = {
    enable = true;
    dumpcap.enable = true;
    usbmon.enable = true;
    package = pkgs.wireshark;
  };

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
    brave
    burpsuite
    gimp
    kdePackages.okular
    kdePackages.kclock
    monero-gui
    mpv
    nsxiv
    obs-studio
    openvpn
    ungoogled-chromium
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
