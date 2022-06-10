{ luaConfig }:
let 
in 
  builtins.concatStringsSep "" (
    builtins.map 
      ( luaConfigFile: "luafile ${luaConfig}/${luaConfigFile}\n") 
      ( builtins.attrNames (builtins.readDir luaConfig))
  )



