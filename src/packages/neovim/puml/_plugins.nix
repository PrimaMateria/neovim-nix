{
  pkgs,
  root,
}:
with pkgs.vimPlugins;
with root.packages.vimPlugins; [
  plantuml-previewer-vim
  open-browser-vim
  plantuml-syntax
]
