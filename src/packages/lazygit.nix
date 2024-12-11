{pkgs}: let
  lazygitConfig = (pkgs.formats.yaml {}).generate "lazygit-config.yaml" {
    os = {
      edit = ''$NVIM_PRIMAMATERIA --server "$NVIM" --remote-tab {{filename}}'';
      editAtLine = ''$NVIM_PRIMAMATERIA --server "$NVIM" --remote-tab {{filename}}; [ -z "$NVIM" ] || $NVIM_PRIMAMATERIA --server "$NVIM" --remote-send ":{{line}}<CR>"'';
      editAtLineAndWait = ''$NVIM_PRIMAMATERIA +{{line}} {{filename}}'';
      openDirInEditor = ''$NVIM_PRIMAMATERIA --server "$NVIM" --remote-tab {{dir}}'';
      suspend = false;
    };
    git.commitPrefixes = builtins.listToAttrs (
      map (projectName: {
        name =
          projectName;
        value = {
          pattern = "^\\w+\\/(\\w+-\\w+).*";
          replace = "$1: ";
        };
      })
      [
        "finapi-cms"
        "finapi-customer-dashboard-ui"
        "finapi-design-system"
        "finapi-hostpages"
        "finapi-js-loader"
        "finapi-js-static-resources"
        "finapi-widget-library"
        "web-form"
        "web-form-ui"
        "web-form-loader"
      ]
    );
  };
in
  pkgs.writeShellApplication {
    name = "lazygit";
    text = ''
      ${pkgs.lazygit}/bin/lazygit --use-config-file ${lazygitConfig} "$@"
    '';
  }
