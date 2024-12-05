{
  pkgs,
  super,
  root,
}:
root.lib.assembleNeovim {
  name = "base";
  inherit (super) dependencies plugins treesitterPlugins;
  configDir = ./__config;
}
