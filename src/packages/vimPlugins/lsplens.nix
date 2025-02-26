{
  pkgs,
  extraPlugins,
}:
pkgs.vimUtils.buildVimPlugin {
  name = "lsplens";
  src = extraPlugins.plugin-lsplens;
}
