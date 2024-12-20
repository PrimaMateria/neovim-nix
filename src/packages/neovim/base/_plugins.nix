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
  render-markdown-nvim

  # Navigation
  # ----------------

  # Refactoring
  # ----------------
  nvim-spectre # search & repace
  oil-nvim
  vim-dirdiff

  # Versioning
  # ----------------
  lazygit-nvim
  vim-fugitive
  vim-gitgutter
  diffview-nvim

  # Snippets
  # ----------------
  # ultisnips # TODO: replace

  # AI
  # ----------------
  avante-nvim
  ChatGPT-nvim

  # Completition
  # ----------------
  blink-cmp

  # Language Server Protocol
  # ----------------
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
]
