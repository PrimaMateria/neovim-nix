{ luaConfigs }:
let 
in 
  builtins.concatStringsSep "" (
    builtins.map 
      ( luaConfig: "luafile ${luaConfigs}/${luaConfig}\n") 
      ( builtins.attrNames (builtins.readDir luaConfigs))
  )
