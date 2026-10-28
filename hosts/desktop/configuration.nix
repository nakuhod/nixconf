{ pkgs, config, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/system.nix
    ../../modules/de.nix
    ../../modules/nvidia.nix
    ../../modules/terminal.nix
    ../../modules/packages.nix
  ];

  networking.hostName = "nixos";

  # Bootloader
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
    };
  };

  # User
  users.users.dogukan = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
      "wireshark"
    ];
  };

  # Desktop specific packages
  environment.systemPackages = with pkgs; [
    steam
  ];
  services.hardware.openrgb = {
    enable = true;
    startupProfile = "Default.orp";
  };
}
