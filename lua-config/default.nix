{ luaConfig }:
let 
in 
  builtins.concatStringsSep "" (
    builtins.map 
      ( luaConfigFile: "luaFile ${luaConfig}/${luaConfigFile}\n") 
      ( builtins.attrNames (builtins.readDir luaConfig))
  )



