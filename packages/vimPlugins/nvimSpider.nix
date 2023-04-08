{ pkgs, src }:
pkgs.vimUtils.buildVimPlugin {
  name = "nvimSpider";
  inherit src;
}
