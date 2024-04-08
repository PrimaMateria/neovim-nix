{ prev, ... }:
let 
  lazygitConfig = prev.writeTextFile {
    name = "lazygitConfig.yaml";
    text = ''
      os:
        edit: '$NVIM_PRIMAMATERIA --server "$NVIM" --remote-tab {{filename}}'
        editAtLine: '$NVIM_PRIMAMATERIA --server "$NVIM" --remote-tab {{filename}}; [ -z "$NVIM" ] || $NVIM_PRIMAMATERIA --server "$NVIM" --remote-send ":{{line}}<CR>"'
        editAtLineAndWait: '$NVIM_PRIMAMATERIA +{{line}} {{filename}}'
        openDirInEditor: '$NVIM_PRIMAMATERIA --server "$NVIM" --remote-tab {{dir}}'
        suspend: false

      git:
        commitPrefixes:
          # TODO: add real projects' names or create a generator
          experiment-lazygitConfig:
            pattern: "^\\w+\\/(\\w+-\\w+).*"
            replace: '$1:'
    '';
  };
in prev.writeShellApplication {
  name = "lazygit";
  text = ''
    ${prev.lazygit}/bin/lazygit --use-config-file ${lazygitConfig} "$@"
  '';
}
