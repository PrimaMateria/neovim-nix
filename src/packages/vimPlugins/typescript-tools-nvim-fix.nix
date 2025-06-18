{
  pkgs,
  extraPlugins,
}:
pkgs.vimUtils.buildVimPlugin {
  pname = "typescript-tools.nvim-fix";
  version = "master";
  src = extraPlugins.plugin-typescript-tools-nvim;
  nvimSkipModule = [
    "typescript-tools.internal_commands"
    "typescript-tools.api"
    "typescript-tools.capabilities"
    "typescript-tools.process"
    "typescript-tools.tsserver"
    "typescript-tools"
    "typescript-tools.tsserver_provider"
    "typescript-tools.async"
    "typescript-tools.protocol.text_document.code_action.init"
    "typescript-tools.protocol.initialize"
    "typescript-tools.user_commands"
    "typescript-tools.rpc"
    "typescript-tools.autocommands.diagnostics"
    "typescript-tools.autocommands.init"
    "typescript-tools.autocommands.jsx_close_tag"
  ];
}
