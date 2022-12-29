{
  deps1 = pkgs:
    with pkgs; [
      pyright
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.eslint_d
      nodePackages.prettier
    ];

  deps2 = pkgs: with pkgs; [ ripgrep clang xsel stylua ltex-ls lazygit ];
}
