{
  pkgs,
  extraPlugins,
}:
pkgs.vimUtils.buildVimPlugin {
  name = "tts-nvim";
  src = extraPlugins.plugin-tts-nvim;
}
