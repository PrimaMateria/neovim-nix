{
  root,
  neovimNixLib,
  debug,
}: let
  initializedNeovimNixLib = (debug.traceVal neovimNixLib.x86_64-linux).init {
    editionsDir = ./packages/neovim;
    editionsSet = root.packages.neovim;
  };
in {
  assembleNeovim = {name}:
    initializedNeovimNixLib.assembleNeovim {inherit name;};
}
