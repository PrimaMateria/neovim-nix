{
  super,
  root,
}:
root.lib.assembleNeovim {
  name = "light";
  inherit (super) dependencies plugins treesitterPlugins;
}
