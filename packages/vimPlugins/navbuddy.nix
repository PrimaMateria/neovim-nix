{ pkgs, src }:
pkgs.vimUtils.buildVimPlugin {
  name = "navbuddy";
  inherit src;
}
