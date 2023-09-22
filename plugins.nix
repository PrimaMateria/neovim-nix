{ pkgs }:
with pkgs.vimPlugins; [
  gruvbox-community
  nvim-base16
  harpoon
  lualine-nvim
  lush-nvim
  (nvim-treesitter.withPlugins (
    p: [
      p.javascript
      p.typescript
      p.lua
      p.html
      p.bash
      p.css
      p.jsdoc
      p.nix
      p.scss
      p.tsx
      p.rust
      p.kotlin
    ]
  ))
  plenary-nvim
  nui-nvim
  popup-nvim
  tabular
  telescope-nvim
  sqlite-lua
  ultisnips
  vim-nix
  nvim-web-devicons
  nvim-tree-lua
  lspsaga-nvim
  vim-abolish
  vim-dirdiff
  ChatGPT-nvim
  lsplens
  indent-blankline-nvim
  nvim-colorizer-lua
  neogen
  muren

  nvim-navic
  navbuddy

  # Git
  vim-fugitive
  vim-gitgutter
  diffview-nvim
  lazygit-nvim
  git-messenger-vim

  # Commenting
  vim-commentary
  nvim-ts-context-commentstring

  # Completition
  nvim-cmp
  cmp-nvim-lsp
  cmp-buffer
  cmp-path
  cmp-cmdline
  cmp-nvim-ultisnips
  cmp-emoji

  nvim-lspconfig
  lsp-status-nvim
  null-ls-nvim
  telescope-recent-files
]
