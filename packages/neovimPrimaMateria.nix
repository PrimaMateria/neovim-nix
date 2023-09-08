{ pkgs }:
let
  runtimeDeps = import ../runtimeDeps.nix { inherit pkgs; };
  secrets = import ../.secrets/secrets.nix;
  customRC = import ../config { inherit pkgs; };
  plugins = import ../plugins.nix { inherit pkgs; };

  neovimRuntimeDependencies = pkgs.symlinkJoin {
    name = "neovimRuntimeDependencies";
    paths = runtimeDeps;
    # see: https://ertt.ca/blog/2022/01-12-nix-symlinkJoin-nodePackages/
    postBuild = ''
        for f in $out/lib/node_modules/.bin/*; do
           path="$(readlink --canonicalize-missing "$f")"
           ln -s "$path" "$out/bin/$(basename $f)"
        done
    '';
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
  runtimeInputs = [ neovimRuntimeDependencies ];
  text = ''
    OPENAI_API_KEY=${secrets.openai-api-key} ${neovimPrimaMateriaUnwrapped}/bin/nvim "$@"
  '';
}

