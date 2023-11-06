{ pkgs }:
with pkgs.vimPlugins; [
  # plenary-nvim
  # nui-nvim
  # popup-nvim
  # lush-nvim
  # sqlite-lua
  # diffview-nvim 
  # git-messenger-vim

  nvim-base16
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

  ultisnips
  vim-nix

  nvim-web-devicons
  nvim-tree-lua
  lspsaga-nvim

  vim-abolish # Subvert
  vim-dirdiff

  ChatGPT-nvim
  lsplens # references
  indent-blankline-nvim
  nvim-colorizer-lua
  muren

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
  null-ls-nvim
  telescope-recent-files
]
