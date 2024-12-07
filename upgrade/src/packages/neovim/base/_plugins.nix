{
  pkgs,
  root,
}:
with pkgs.vimPlugins;
with root.packages.vimPlugins; [
  # Look & feel
  # ----------------
  base16-nvim
  indent-blankline-nvim
  lualine-nvim
  noice-nvim
  nvim-colorizer-lua
  nvim-notify
  nvim-web-devicons
  vim-illuminate # highlight word under cursor
  todo-comments-nvim
  render-markdown-nvim

  # Navigation
  # ----------------
  harpoon
  nvim-tree-lua
  telescope-frecency-nvim
  telescope-fzf-native-nvim
  telescope-nvim
  fzf-lua # TODO: it shows lsp references on gh, not sure why telescope is not used

  # Refactoring
  # ----------------
  nvim-spectre # search & repace
  oil-nvim
  vim-abolish # subvert
  tabular

  # Versioning
  # ----------------
  lazygit-nvim
  vim-fugitive
  vim-gitgutter

  # Snippets
  # ----------------
  ultisnips

  # AI
  # ----------------
  # avante-nvim
  ChatGPT-nvim

  # Completition
  # ----------------
  cmp-buffer
  cmp-cmdline
  cmp-emoji
  cmp-nvim-lsp
  cmp-nvim-ultisnips
  cmp-path
  nvim-cmp

  # Language Server Protocol
  # ----------------
  lsp-status-nvim
  lsplens # references
  lspsaga-nvim
  nvim-lspconfig

  # Linting & formatting
  # ----------------
  nvim-lint
  conform-nvim
]
