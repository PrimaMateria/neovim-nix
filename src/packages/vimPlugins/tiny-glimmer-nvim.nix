{
  pkgs,
  extraPlugins,
}:
pkgs.vimUtils.buildVimPlugin {
  name = "tiny-glimmer-nvim";
  src = extraPlugins.plugin-tiny-glimmer-nvim;
  # a file used for testing
  nvimSkipModule = [
    "test"
  ];
}
