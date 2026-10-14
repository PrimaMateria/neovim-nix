{
  pkgs,
  extraPlugins,
}:
pkgs.vimUtils.buildVimPlugin {
  name = "atlas-nvim";
  src = extraPlugins.plugin-atlas-nvim;
  # Optional picker/diff integrations (fzf-lua, snacks, codediff) fail the
  # auto-discovered require check in the sandbox.
  nvimRequireCheck = ["atlas"];
}
