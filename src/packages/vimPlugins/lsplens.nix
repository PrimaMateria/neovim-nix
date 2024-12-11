{pkgs}:
pkgs.vimUtils.buildVimPlugin {
  name = "lsplens";
  src = pkgs.fetchFromGitHub {
    owner = "VidocqH";
    repo = "lsp-lens.nvim";
    rev = "master";
    hash = "sha256-zj/Gn/40jnDNh05OFc23LNNuFn1PnIAUDfPquEWpAlk=";
  };
}
