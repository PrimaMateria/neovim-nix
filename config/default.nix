{ ultisnipsSnippets, luaConfigs  }:
  import ./nvim-init.nix
  + import ./nvim-fugitive.nix
  + import ./nvim-setters.nix
  + import ./nvim-ultisnips.nix ultisnipsSnippets
  + import ./nvim-lazygit.nix
  + import ./lua-loader.nix { inherit luaConfigs; }

