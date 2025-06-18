{
  description = "PrimaMateria's neovim editions flake";

  outputs = {
    self,
    nixpkgs,
    utils,
    haumea,
    neovimNightlyOverlay,
    neovim-nix-utils,
    plugin-avante,
    plugin-lsplens,
    plugin-aider,
    plugin-tiny-glimmer-nvim,
    plugin-typescript-tools-nvim,
    ...
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          config = {allowUnfree = true;};
          overlays = [neovimNightlyOverlay.overlays.default];
        };
        neovimNixLib = neovim-nix-utils.lib.${system};
      in (haumea.lib.load {
        src = ./src;
        inputs = {
          inherit pkgs;
          inherit neovimNixLib;
          inherit (pkgs.lib) debug;
          extraPlugins = {
            inherit
              plugin-avante
              plugin-lsplens
              plugin-aider
              plugin-tiny-glimmer-nvim
              plugin-typescript-tools-nvim
              ;
          };
        };
        transformer = haumea.lib.transformers.liftDefault;
      })
    );

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    utils.url = "github:numtide/flake-utils";
    haumea = {
      url = "github:nix-community/haumea";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nix-utils = {
      url = "github:PrimaMateria/neovim-nix-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  inputs = {
    neovimNightlyOverlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  inputs = {
    plugin-avante = {
      url = "github:yetone/avante.nvim";
      flake = false;
    };
    plugin-lsplens = {
      url = "github:VidocqH/lsp-lens.nvim";
      flake = false;
    };
    plugin-aider = {
      url = "github:GeorgesAlkhouri/nvim-aider";
      flake = false;
    };
    plugin-tiny-glimmer-nvim = {
      url = "github:rachartier/tiny-glimmer.nvim";
      flake = false;
    };
    plugin-typescript-tools-nvim = {
      url = "github:pmizio/typescript-tools.nvim";
      flake = false;
    };
  };
}
