{ pkgs }:
let
  runtimeDeps = import ../runtimeDeps.nix { inherit pkgs; };
  customRC = import ../config { inherit pkgs; };
  plugins = import ../plugins.nix { inherit pkgs; };

  neovimRuntimeDependencies = pkgs.symlinkJoin {
    name = "neovimRuntimeDependencies";
    paths = runtimeDeps.deps1;
  };
  neovimRuntimeDependencies2 = pkgs.symlinkJoin {
    name = "neovimRuntimeDependencies2";
    paths = runtimeDeps.deps2;
  };
  neovimPrimaMateriaUnwrapped =
    pkgs.wrapNeovim pkgs.neovim {
      withNodeJs = true;
      configure = {
        inherit customRC;
        packages.all.start = plugins;
      };
    };

in pkgs.writeShellApplication {
  name = "nvim";
  runtimeInputs = [ neovimRuntimeDependencies2 neovimRuntimeDependencies ];
  text = ''
    ${neovimPrimaMateriaUnwrapped}/bin/nvim "$@"
  '';
}

