{
  pkgs,
  extraPlugins,
}:
pkgs.vimUtils.buildVimPlugin {
  pname = "typescript-tools.nvim-fix";
  version = "2025-04-07-cbf908bcb9ec1699b5baeca4c206c37cd231fbd4";
  src = pkgs.fetchFromGitHub {
    owner = "pmizio";
    repo = "typescript-tools.nvim";
    rev = "cbf908bcb9ec1699b5baeca4c206c37cd231fbd4";
    sha256 = "sha256-T33hOoBa3/eHI/yyJk4chjPc0h4avjBI7409AUXu/E0=";
  };
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
