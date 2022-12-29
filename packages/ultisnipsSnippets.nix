# Collection of snippets which are passed to UltiSnip plugins
{ pkgs }:
pkgs.stdenv.mkDerivation {
  name = "ultisnipsSnippets";
  src = ../ultisnips;
  installPhase = ''
    mkdir -p $out/
    cp ./*.snippets $out/
  '';
}
