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
  fzf-lua # TODO: it shows lsp references on gh, not sure why telescope is not used

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
  # avante-nvim
  ChatGPT-nvim

  # Completition
  # ----------------
  cmp-buffer
  cmp-cmdline
  cmp-emoji
  cmp-nvim-lsp
  cmp-path
  nvim-cmp

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
