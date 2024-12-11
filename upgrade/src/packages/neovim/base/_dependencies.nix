{pkgs}:
with pkgs; [
  ripgrep
  clang # ?
  lazygit

  stylua
  luajitPackages.luacheck

  # nix
  statix
  alejandra
  #TODO: nix security issue
  # rnix-lsp
]
