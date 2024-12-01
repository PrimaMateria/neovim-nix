{
  pkgs,
  src,
}:
pkgs.vimUtils.buildVimPlugin {
  name = "muren";
  inherit src;
  dontBuild = true;
}
