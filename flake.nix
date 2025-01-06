{
  description = "PrimaMateria's neovim editions flake";

  outputs = {
    self,
    nixpkgs,
    utils,
    haumea,
    neovimNightlyOverlay,
    neovim-nix-utils,
    ...
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          config = {allowUnfree = true;};
          overlays = [neovimNightlyOverlay.overlays.default];
        };
        neovimNixLib = pkgs.lib.debug.traceVal neovim-nix-utils.lib;
      in (haumea.lib.load {
        src = ./src;
        inputs = {
          inherit pkgs;
          inherit neovimNixLib;
          inherit (pkgs.lib) debug;
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
      url = "/home/primamateria/dev/neovim-nix-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  inputs = {
    neovimNightlyOverlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
