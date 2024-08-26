{ pkgs, src }:
pkgs.vimUtils.buildVimPlugin {
  name = "lsplens";
  inherit src;
}
