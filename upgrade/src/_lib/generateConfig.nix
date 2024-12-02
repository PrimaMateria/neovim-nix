{
  pkgs,
  super,
}: {
  vimDir,
  vimnixDir,
  luaDir,
  luanixDir,
}: let
  # todo
  sourceConfigFiles = files:
    builtins.concatStringsSep "\n" (builtins.map (file:
      (
        if pkgs.lib.strings.hasSuffix "lua" file
        then "luafile"
        else "source"
      )
      + " ${file}")
    files);

  # Collect arrays of paths of all the configs.
  vim = super.collectRaw {dir = vimDir;};
  vimnix = super.collectNix {dir = vimnixDir;};
  lua = super.collectRaw {dir = luaDir;};
  luanix = super.collectNix {dir = luanixDir;};
in
  # todo
  builtins.concatStringsSep "\n"
  (builtins.map (configs: sourceConfigFiles configs) [vim vimnix lua luanix])
