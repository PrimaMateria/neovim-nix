{
  pkgs,
  root,
  neovimNixLib,
}: let
  initializedNeovimNixLib = neovimNixLib.init {
    neovimPackage = pkgs.neovim;
    editionsDir = ./packages/neovim;
    editionsSet = root.packages.neovim;
    extraPackages = root.packages;
  };
in {
  assembleNeovim = {name}:
    initializedNeovimNixLib.assembleNeovim {inherit name;};
}
