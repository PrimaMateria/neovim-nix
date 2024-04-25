{pkgs}:
with pkgs.vimPlugins; [
  # vim-nix

  base16-nvim
  harpoon
  lualine-nvim

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
      p.markdown
      p.markdown_inline
    ]
  ))

  tabular

  telescope-nvim
  telescope-recent-files
  telescope-frecency-nvim

  ultisnips

  nvim-web-devicons
  nvim-tree-lua

  vim-abolish # Subvert
  vim-dirdiff
  diffview-nvim

  ChatGPT-nvim
  lsplens # references
  indent-blankline-nvim
  nvim-colorizer-lua
  vim-illuminate

  noice-nvim
  nvim-notify

  # Git
  vim-fugitive
  vim-gitgutter
  lazygit-nvim

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
  lspsaga-nvim
  nvim-lint
  conform-nvim

  fzf-lua
  todo-comments-nvim
]
