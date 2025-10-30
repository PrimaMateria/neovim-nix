{
  pkgs,
  root,
}:
with pkgs;
with root.packages; [
  zulu
  graphviz
  plantuml-jar
]
