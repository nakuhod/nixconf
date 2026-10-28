{ lib, pkgs, ... }:
{
  system.stateVersion = "26.05";
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        user = "greeter";
        command = lib.getExe pkgs.tuigreet + " --time --remember --remember-session";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    tuigreet
    pavucontrol
    playerctl
  ];

  # rsync daemon
  services.rsyncd = {
    enable = true;
    port = 873;
    socketActivated = true;
  };

  # Sound
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;

  time.timeZone = "Europe/Istanbul";
  i18n.defaultLocale = "en_GB.UTF-8";
  networking = {
    firewall = {
      allowedTCPPorts = [ 873 ]; # 873 - rsyncd
    };
    networkmanager.enable = true;
  };
  programs.nm-applet.enable = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  nix.optimise = {
    automatic = true;
    persistent = true;
    dates = [ "Mon 03:45" ];
  };
  nix.settings.auto-optimise-store = true;

  fonts.fontconfig = {
    enable = true;
    hinting.enable = true;
    antialias = true;
  };
}
