{
  pkgs,
  extraPlugins,
}:
pkgs.vimUtils.buildVimPlugin {
  name = "resolve-nvim";
  src = extraPlugins.plugin-resolve-nvim;
  # a file used for testing
  # nvimSkipModule = [
  #   "test"
  # ];
}
