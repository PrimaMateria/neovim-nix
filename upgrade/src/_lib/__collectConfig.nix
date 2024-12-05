{
  pkgs,
  super,
}: {configDir}: let
  # It maps file to a vimscript source command. If the file has lua extenstion,
  # then it sources it via `luafile`, otherwise it is assumed that it is
  # vimscript file, and it sources it with `source`.
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
  vim =
    if builtins.pathExists "${configDir}/vim"
    then super.collectConfigRaw {dir = "${configDir}/vim";}
    else [];

  vimnix =
    if builtins.pathExists "${configDir}/vimnix"
    then super.collectConfigNix {dir = "${configDir}/vimnix";}
    else [];

  lua =
    if builtins.pathExists "${configDir}/lua"
    then super.collectConfigRaw {dir = "${configDir}/lua";}
    else [];

  luanix =
    if builtins.pathExists "${configDir}/luanix"
    then super.collectConfigNix {dir = "${configDir}/luanix";}
    else [];
in
  # Transform config file sets to source command block and concatenate the
  # blocks with new line.
  builtins.concatStringsSep "\n"
  (builtins.map (configs: sourceConfigFiles configs) [vim vimnix lua luanix])
