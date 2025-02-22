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

  aider-chat
])
++ (with root.packages; [
  lazygit
])
