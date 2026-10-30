{
  pkgs,
  ...
}:

{
  packages = [ pkgs.nixfmt ];
  env.GREET = "nix";
  languages.nix.enable = true;
}
