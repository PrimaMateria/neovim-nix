{
  pkgs,
  root,
  super,
}: {name}: let
  spec = super.getSpec name;

  # Configure neovim with the RC and with the plugins list
  configuredNeovim = pkgs.wrapNeovim pkgs.neovim {
    configure = {
      customRC = spec.config;
      packages.all.start = spec.plugins;
    };
  };
in
  # Create a shell application that runs Neovim with the specified runtime
  # dependencies and environment variables.
  # TODO: env vars should also be passed from config
  pkgs.writeShellApplication {
    name = "nvim-${name}";
    runtimeInputs = [spec.runtimeDeps];

    text = ''
      NVIM_PRIMAMATERIA=${configuredNeovim}/bin/nvim \
      OPENAI_API_KEY=${root.secrets.openai-api-key} \
      ${configuredNeovim}/bin/nvim "$@"
    '';
  }
