{pkgs}: let
  lazygitConfig = (pkgs.formats.yaml {}).generate "lazygit-config.yaml" {
    os = {
      edit = ''$NVIM_SELF --server "$NVIM" --remote-tab {{filename}}'';
      editAtLine = ''$NVIM_SELF --server "$NVIM" --remote-tab {{filename}}; [ -z "$NVIM" ] || $NVIM_SELF --server "$NVIM" --remote-send ":{{line}}<CR>"'';
      editAtLineAndWait = ''$NVIM_SELF +{{line}} {{filename}}'';
      openDirInEditor = ''$NVIM_SELF --server "$NVIM" --remote-tab {{dir}}'';
      editInTerminal = false;
    };

    git.commitPrefix = [
      {
        pattern = "^\\w+\\/(\\w+-\\w+).*";
        replace = "$1: ";
      }
    ];
  };
in
  pkgs.writeShellApplication {
    name = "lazygit";
    text = ''
      ${pkgs.lazygit}/bin/lazygit --use-config-file ${lazygitConfig} "$@"
    '';
  }
