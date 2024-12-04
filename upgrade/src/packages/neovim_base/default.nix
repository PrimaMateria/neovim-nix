{
  pkgs,
  neovimNightly,
  super,
  root,
}: let
  customRC = root.lib.generateConfig {
    configDir = ./__config;
  };

  configuredNeovim = pkgs.wrapNeovim neovimNightly {
    configure = {
      inherit customRC;
      packages.all.start =
        super.plugins
        ++ [
          (pkgs.vimPlugins.nvim-treesitter.withPlugins super.treesitter)
        ];
    };
  };

  aggregatedDependenciesDerivation = root.lib.symlinkJoinDependencies {
    dependencies = super.dependencies;
  };
in
  pkgs.writeShellApplication {
    name = "nvim-base";
    runtimeInputs = [aggregatedDependenciesDerivation];
    text = ''
      NVIM_PRIMAMATERIA=${configuredNeovim}/bin/nvim \
      OPENAI_API_KEY=${root.secrets.openai-api-key} \
      ${configuredNeovim}/bin/nvim "$@"
    '';
  }
