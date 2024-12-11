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
])
++ (with root.packages; [
  lazygit
])
