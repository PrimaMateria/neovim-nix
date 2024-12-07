{
  pkgs,
  root,
  super,
  debug,
}: {name}: let
  inputs = super.collectHierarchyInputs name;

  # Configure neovim with the RC and with the plugins list
  configuredNeovim = pkgs.wrapNeovim pkgs.neovim {
    configure = {
      customRC = inputs.customRC;
      packages.all.start = inputs.allPlugins;
    };
  };
in
  # Create a shell application that runs Neovim with the specified runtime
  # dependencies and environment variables.
  # TODO: env vars should also be passed from config
  pkgs.writeShellApplication {
    name = "nvim-${name}";
    runtimeInputs = [inputs.joinedRuntimeDependencies];

    text = ''
      NVIM_PRIMAMATERIA=${configuredNeovim}/bin/nvim \
      OPENAI_API_KEY=${root.secrets.openai-api-key} \
      ${configuredNeovim}/bin/nvim "$@"
    '';
  }
