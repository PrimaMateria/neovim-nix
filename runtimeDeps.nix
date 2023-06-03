{ pkgs }:
with pkgs; [
    ripgrep
    clang
    xsel
    stylua
    ltex-ls
    lazygit
    # packages with results in /lib/node_modules/.bin must come at the end
    pyright
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.eslint_d
    nodePackages.prettier
  ]

