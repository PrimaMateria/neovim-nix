{
  pkgs,
  root,
  neovimNixLib,
}: let
  initializedNeovimNixLib = neovimNixLib.init {
    neovimPackage = pkgs.neovim;
    editionsDir = ./packages/neovim;
    editionsSet = root.packages.neovim;
  };
in {
  assembleNeovim = {name}:
    initializedNeovimNixLib.assembleNeovim {inherit name;};
}
