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
])
