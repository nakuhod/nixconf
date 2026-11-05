{
  config,
  pkgs,
  hostname,
  ...
}:
let
  repo_name = "nixconf";
  dotfiles = "${config.home.homeDirectory}/${repo_name}/dotfiles";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    ghostty = "ghostty";
    hypr = "hypr";
    nvim = "nvim";
    noctalia = "noctalia";
  };
in
{
  imports = [
    ../modules/home-manager/firefox.nix
  ];
  home.username = "dogukan";
  home.homeDirectory = "/home/dogukan";
  home.stateVersion = "26.05";

  programs.firefox.enable = true;
  programs.neovim.defaultEditor = true;
  programs.tmux = {
    enable = true;
    plugins = [ pkgs.tmuxPlugins.resurrect ];
    extraConfig = ''
      source-file "${dotfiles}/tmux/config.conf"
    '';
  };

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}/";
    recursive = true;
  }) configs;

  home.packages = with pkgs; [
    kitty
    gcc
    gnumake
    neovim
    ripgrep
  ];

}
