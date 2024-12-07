{
  pkgs,
  root,
  super,
}: {
  name,
  dependencies,
  dependenciesEnd,
  plugins,
  treesitterPlugins,
}: let
  # Collect all configurations into one Resource Configuration (RC) text content.
  customRC = super.collectConfig {configDir = ../packages/neovim/${name}/__config;};

  # Join the plugins and treesitter plugins into one plugins list.
  allPlugins = plugins ++ [(pkgs.vimPlugins.nvim-treesitter.withPlugins treesitterPlugins)];

  # Configure neovim with the RC and with the plugins list
  configuredNeovim = pkgs.wrapNeovim pkgs.neovim {
    configure = {
      inherit customRC;
      packages.all.start = allPlugins;
    };
  };

  # Create a derivation that aggregates symlinks of all runtime dependencies
  # from the list.
  joinedRuntimeDependencies = super.joinRuntimeDependencies {
    inherit dependencies ++ dependenciesEnd;
  };
in
  # Create a shell application that runs Neovim with the specified runtime
  # dependencies and environment variables.
  # TODO: env vars should also be passed from config
  pkgs.writeShellApplication {
    name = "nvim-${name}";
    runtimeInputs = [joinedRuntimeDependencies];

    text = ''
      NVIM_PRIMAMATERIA=${configuredNeovim}/bin/nvim \
      OPENAI_API_KEY=${root.secrets.openai-api-key} \
      ${configuredNeovim}/bin/nvim "$@"
    '';
  }
