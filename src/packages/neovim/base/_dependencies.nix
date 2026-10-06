{
  root,
  pkgs,
}:
(with pkgs; [
  ripgrep
  clang # ?

  stylua
  lua-language-server

  # nix
  statix
  alejandra
])
++ (with root.packages; [
  lazygit
  plantuml-jar
])
++ (with pkgs; [
  zulu
  graphviz
])
++ (with pkgs; [
  # tts.nvim
  curl # openai backend
  mpv # audio playback
])
++ (with root.packages; [
  piper-tts # local tts backend
])
