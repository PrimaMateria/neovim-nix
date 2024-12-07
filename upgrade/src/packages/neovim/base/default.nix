{
  super,
  root,
}:
root.lib.assembleNeovim {
  name = "base";
  # basedOn = "light";
  inherit (super) dependencies dependenciesEnd plugins treesitterPlugins;
}
