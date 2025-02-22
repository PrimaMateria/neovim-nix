{pkgs}:
pkgs.vimUtils.buildVimPlugin {
  name = "nvim-aider";
  src = pkgs.fetchFromGitHub {
    owner = "GeorgesAlkhouri";
    repo = "nvim-aider";
    rev = "master";
    hash = "sha256-Nh6LMDsQJfuPKHGHn+J2GokY6cAzjebdzfgPlUa+JDc=";
  };
}
