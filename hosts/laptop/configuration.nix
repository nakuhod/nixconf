{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/system.nix
    ../../modules/nvidia.nix
    ../../modules/de.nix
    ../../modules/terminal.nix
    ../../modules/packages.nix
  ];

  networking.hostName = "nixos-laptop";

  # Bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  # User
  users.users.dogukan = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };
  # Battery
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  # Laptop specific packages
  environment.systemPackages = with pkgs; [
    brightnessctl
  ];
}
