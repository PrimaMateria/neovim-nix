{pkgs}:
pkgs.vimUtils.buildVimPlugin {
  name = "tiny-glimmer-nvim";
  src = pkgs.fetchFromGitHub {
    owner = "rachartier";
    repo = "tiny-glimmer.nvim";
    rev = "master";
    hash = "sha256-C5TvfIAg1htrVqcPfZsdc8CR6/ugFY9KdS5ru7BRXZQ=";
  };
  # a file used for testing
  nvimSkipModule = [
    "test"
  ];
}
