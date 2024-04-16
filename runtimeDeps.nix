{ pkgs }:
with pkgs; [
  bashInteractive
  ripgrep
  clang
  xsel
  stylua
  luajitPackages.luacheck

  ltex-ls
  lazygit

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

  # packages with results in /lib/node_modules/.bin must come at the end
  pyright
  nodePackages.typescript
  nodePackages.typescript-language-server
  nodePackages.eslint_d
  nodePackages.prettier
]

