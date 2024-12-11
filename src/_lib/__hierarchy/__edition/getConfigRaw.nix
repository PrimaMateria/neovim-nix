{pkgs}: {dir}: let
  # config dir is a united derivation that holds oll the raw config filex
  configDir = pkgs.stdenv.mkDerivation {
    name = "nvim-${dir}-configs";
    src = dir;
    installPhase = ''
      mkdir -p $out/
      cp ./* $out/
    '';
  };
in
  # return array of paths to the raw config files from the nix store
  builtins.map (file: "${configDir}/${file}")
  (builtins.attrNames (builtins.readDir configDir))
