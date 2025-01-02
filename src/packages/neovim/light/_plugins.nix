{
  pkgs,
  root,
}:
with pkgs.vimPlugins;
with root.packages.vimPlugins; [
  # Look & feel
  # ----------------
  base16-nvim
  lualine-nvim
  noice-nvim
  nvim-notify
  which-key-nvim

  # Navigation
  # ----------------
  harpoon
  nvim-tree-lua
  telescope-frecency-nvim
  telescope-fzf-native-nvim
  telescope-nvim

  # Refactoring
  # ----------------
  vim-abolish # subvert
  tabular
]
