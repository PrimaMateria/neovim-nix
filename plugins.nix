{ pkgs }:
with pkgs.vimPlugins; [
  gruvbox-community
  nvim-base16
  harpoon
  lualine-nvim
  lush-nvim
  nvim-treesitter
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

  # Git
  gv-vim
  vim-fugitive
  vim-gitgutter
  diffview-nvim
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

  nvim-lspconfig
  lsp-status-nvim
  null-ls-nvim
  telescope-recent-files
]
