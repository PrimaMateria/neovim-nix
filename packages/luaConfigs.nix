{ pkgs }:
let
  lspConfig = pkgs.writeTextFile {
    name = "nvimLspConfig.lua";
    text = import ../config/luanix/nvim-lspconfig.nix { inherit pkgs; };
  };
in pkgs.stdenv.mkDerivation {
  name = "nvimLuaConfig";
  src = ../config/lua;
  installPhase = ''
    mkdir -p $out/
    cp ./* $out/
    ln -s ${lspConfig} $out/
  '';
}

