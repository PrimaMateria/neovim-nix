{
  pkgs,
  extraPlugins,
}:
pkgs.vimUtils.buildVimPlugin {
  name = "nvim-aider";
  src = extraPlugins.plugin-aider;
}
