{ pkgs }:
let
  runtimeDeps = import ../runtimeDeps.nix;
  secrets = import ../.secrets/secrets.nix;
  customRC = import ../config { inherit pkgs; };
  plugins = import ../plugins.nix;

  neovimRuntimeDependencies = pkgs.symlinkJoin {
    name = "neovimRuntimeDependencies";
    paths = runtimeDeps.deps1 pkgs;
  };
  neovimRuntimeDependencies2 = pkgs.symlinkJoin {
    name = "neovimRuntimeDependencies2";
    paths = runtimeDeps.deps2 pkgs;
  };

  # foo = builtins.trace pkgs "foo";

  neovimPrimaMateriaUnwrapped =
    pkgs.wrapNeovim pkgs.neovim {
      withNodeJs = true;
      configure = {
        inherit customRC;
        packages.all.start = plugins pkgs;
      };
    };

in pkgs.writeShellApplication {
  name = "nvim";
  # name = "nvim" + foo;
  runtimeInputs = [ neovimRuntimeDependencies2 neovimRuntimeDependencies ];
  text = ''
    OPENAI_API_KEY=${secrets.openai-api-key} ${neovimPrimaMateriaUnwrapped}/bin/nvim "$@"
  '';
}

