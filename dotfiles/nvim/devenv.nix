{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  env.GREET = "lua";
  languages.lua.enable = true;
}
