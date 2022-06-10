{ ultisnipsSnippets, luaConfig }:
  import ./nvim-init.nix
  + import ./nvim-fern.nix
  + import ./nvim-fugitive.nix
  + import ./nvim-lightline.nix
  + import ./nvim-setters.nix
  + import ./nvim-ultisnips.nix ultisnipsSnippets
  + import ./lua-loader.nix { inherit luaConfig; }
