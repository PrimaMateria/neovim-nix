{ prev, ... }:
let 
  lazygitConfig = prev.writeTextFile {
    name = "lazygitConfig.yaml";
    text = ''
      os:
        # TODO: this still doesn't work. nvim command not found. Maybe I could
        # replicate the
        # https://github.com/jesseduffield/lazygit/blob/53f0c4aeffadabfc0bad783831843fdd128b51be/pkg/config/editor_presets.go#L54a
        # but feed the nvim from final 
        editPreset: 'nvim-remote'
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
