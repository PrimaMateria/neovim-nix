{ luaConfigs }:
let
in builtins.concatStringsSep "" (builtins.map (luaConfig: ''
  luafile ${luaConfigs}/${luaConfig}
'') (builtins.attrNames (builtins.readDir luaConfigs)))
