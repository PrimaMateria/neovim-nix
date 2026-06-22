{
  pkgs,
  extraPlugins,
}:
pkgs.vimUtils.buildVimPlugin {
  name = "rsvp-nvim";
  src = extraPlugins.plugin-rsvp-nvim;
}
