{pkgs}: hierarchy:
with builtins; let
  plugins = concatMap (edition:
    if edition ? plugins
    then edition.plugins
    else [])
  hierarchy;

  treesitterPluginsListers = map (edition:
    if edition ? treesitterPlugins
    then edition.treesitterPlugins
    else (p: []))
  hierarchy;

  treesitterPlugin = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: (
    concatMap (lister: (lister p)) treesitterPluginsListers
  ));
in
  # Join the plugins and treesitter plugins into one plugins list.
  # Collect all configurations into one Resource Configuration (RC) text content.
  plugins ++ [treesitterPlugin]
