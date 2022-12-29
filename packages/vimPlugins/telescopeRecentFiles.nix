{ src }:
pkgs:
pkgs.vimUtils.buildVimPlugin {
  name = "telescope-recent-files";
  inherit src;
}
