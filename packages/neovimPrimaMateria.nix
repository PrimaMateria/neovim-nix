{ pkgs, neovim, noneckpain-src, telescope-recent-files-src }:
let
  runtimeDeps = import ../runtimeDeps.nix;
  secrets = import ../.secrets/secrets.nix;
  ultisnipsSnippets = import ./ultisnipsSnippets.nix { inherit pkgs; };
  luaConfigs = import ./luaConfigs.nix { inherit pkgs; };
  plugins = import ../plugins.nix;

  noneckpain = import ./vimPlugins/noneckpain.nix { src = noneckpain-src; };
  telescope-recent-files = import ./vimPlugins/telescopeRecentFiles.nix {
    src = telescope-recent-files-src;
  };

  neovimRuntimeDependencies = pkgs.symlinkJoin {
    name = "neovimRuntimeDependencies";
    paths = runtimeDeps.deps1 pkgs;
  };
  neovimRuntimeDependencies2 = pkgs.symlinkJoin {
    name = "neovimRuntimeDependencies2";
    paths = runtimeDeps.deps2 pkgs;
  };

  neovimPrimaMateriaUnwrapped =
    pkgs.wrapNeovim neovim.packages.x86_64-linux.neovim {
      withNodeJs = true;
      configure = {
        customRC = import ../config { inherit ultisnipsSnippets luaConfigs; };
        packages.myVimPackage.start = plugins pkgs
          ++ [ (telescope-recent-files pkgs) (noneckpain pkgs) ];
      };
    };

in pkgs.writeShellApplication {
  name = "nvim";
  runtimeInputs = [ neovimRuntimeDependencies2 neovimRuntimeDependencies ];
  text = ''
    OPENAI_API_KEY=${secrets.openai-api-key} ${neovimPrimaMateriaUnwrapped}/bin/nvim "$@"
  '';
}

