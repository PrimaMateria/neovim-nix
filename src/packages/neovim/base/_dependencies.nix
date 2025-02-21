{
  root,
  pkgs,
}:
(with pkgs; [
  ripgrep
  clang # ?

  stylua
  luajitPackages.luacheck

  # nix
  statix
  alejandra

  aider-chat
])
++ (with root.packages; [
  lazygit
])
