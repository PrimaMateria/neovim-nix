{
  pkgs,
  super,
}: let
  neovimPrimaMateriaUnwrapped = pkgs.wrapNeovim pkgs.neovim {
    withNodeJs = true;
    configure = {
      # inherit customRC;
      packages.all.start = super.plugins;
    };
  };
in
  pkgs.writeShellApplication {
    name = "nvim-base";
    runtimeInputs = [super.dependencies];
    text = ''
      NVIM_PRIMAMATERIA=${neovimPrimaMateriaUnwrapped}/bin/nvim /
      OPENAI_API_KEY=${super.secrets.openai-api-key} /
      ${neovimPrimaMateriaUnwrapped}/bin/nvim "$@"
    '';
  }
