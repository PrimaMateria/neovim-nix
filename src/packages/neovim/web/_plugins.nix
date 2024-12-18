{
  pkgs,
  root,
}:
with pkgs.vimPlugins;
with root.packages.vimPlugins; [
  nvim-ts-context-commentstring
  debugprint-nvim
]
