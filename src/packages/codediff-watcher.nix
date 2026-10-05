{pkgs}:
# File watcher used by codediff.nvim for instant refresh. The plugin would
# otherwise download it into its own (read-only) store path. Keep the version
# in sync with VERSION in codediff.nvim's lua/codediff/core/installer/watcher.lua.
pkgs.rustPlatform.buildRustPackage rec {
  pname = "codediff-watcher";
  version = "0.23.2";

  src = pkgs.fetchFromGitHub {
    owner = "esmuellert";
    repo = "codediff";
    rev = "v${version}";
    hash = "sha256-YiDCNp5buIYQhnquC/1hjLGBjGtzSMu6BAgHtcYCt5o=";
  };

  cargoHash = "sha256-wiyDnyYop2lbmUVt5H4SiizaE4Kl5pAkBn5r8c3M9UI=";

  cargoBuildFlags = ["-p" "watcher" "--bin" "codediff-watcher"];
  doCheck = false;
}
