{ pkgs }:
{
  deps1 = with pkgs; [
      pyright
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.eslint_d
      nodePackages.prettier
    ];

  deps2 =  with pkgs; [ ripgrep clang xsel stylua ltex-ls lazygit ];
}
