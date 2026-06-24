{
  pkgs,
  root,
}:
with pkgs.vimPlugins;
with root.packages.vimPlugins; [
  # Look & feel
  # ----------------
  indent-blankline-nvim
  nvim-colorizer-lua
  nvim-web-devicons
  vim-illuminate # highlight word under cursor
  todo-comments-nvim
  markview-nvim
  trouble-nvim

  # Navigation
  # ----------------

  # Refactoring
  # ----------------
  grug-far-nvim # search & replace
  oil-nvim
  vim-dirdiff

  # Versioning
  # ----------------
  lazygit-nvim
  vim-fugitive
  gitsigns-nvim
  diffview-nvim
  resolve-nvim

  # Snippets
  # ----------------
  luasnip

  # AI
  # ----------------
  copilot-lua
  codecompanion-nvim
  codecompanion-copilot-enterprise-nvim
  blink-copilot

  # Completition
  # ----------------
  blink-cmp
  blink-emoji-nvim

  # Language Server Protocol
  # ----------------
  nvim-treesitter
  nvim-ufo
  promise-async
  lsplens # references
  lspsaga-nvim
  nvim-lspconfig

  # Linting & formatting
  # ----------------
  nvim-lint
  conform-nvim

  # Commenting
  # ----------------
  vim-commentary

  # Reading
  # ----------------
  rsvp-nvim
]
