{ pkgs, ... }:
{

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    noctalia
    nwg-look
    adw-gtk3
    capitaine-cursors
    papirus-icon-theme
  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
  };

  security.pam.services.login.fprintAuth = false;
}
