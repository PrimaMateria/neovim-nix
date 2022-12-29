{ ultisnipsSnippets, luaConfigs  }:
  import ./vim { inherit ultisnipsSnippets; }
  + import ./lua-loader.nix { inherit luaConfigs; }

