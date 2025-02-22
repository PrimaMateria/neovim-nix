{pkgs}:
pkgs.vimUtils.buildVimPlugin {
  name = "nvim-aider";
  src = pkgs.fetchFromGitHub {
    owner = "GeorgesAlkhouri";
    repo = "nvim-aider";
    rev = "master";
    hash = "sha256-OTSLFrROzHXemFAk7VAAJwpolZ0Ws2WJ0j5qgs5aW0A=";
  };
}
