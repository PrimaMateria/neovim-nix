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

  # rust
  rustc
  rust-analyzer
  rustfmt
  cargo

  # puml
  zulu
  graphviz
]
