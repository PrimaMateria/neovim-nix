{
  pkgs,
  extraPlugins,
}:
pkgs.vimUtils.buildVimPlugin {
  name = "codecompanion-copilot-enterprise-nvim";
  src = extraPlugins.plugin-codecompanion-copilot-enterprise-nvim;
  nvimSkipModule = [
    "codecompanion.adapters.http.copilot_enterprise.helpers"
    "codecompanion.adapters.http.copilot_enterprise.init"
  ];
}
