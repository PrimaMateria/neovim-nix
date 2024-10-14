{
  pkgs,
  src,
}:
pkgs.vimUtils.buildVimPlugin {
  name = "avante";
  inherit src;
  dontBuild = true;
}
