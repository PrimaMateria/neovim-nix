{pkgs}: {dir}:
builtins.map (file:
    pkgs.writeTextFile {
      name = pkgs.lib.strings.removeSuffix ".nix" file;
      text = import "${dir}/${file}" {inherit pkgs;};
    }) (builtins.attrNames (builtins.readDir dir))
