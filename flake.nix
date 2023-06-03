{
  description = "PrimaMateria neovim flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs";
    };

    neovim = {
      url = "github:neovim/neovim/v0.9.0?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    telescope-recent-files-src = {
      url = "github:smartpde/telescope-recent-files";
      flake = false;
    };

    noneckpain-src = {
      url = "github:shortcuts/no-neck-pain.nvim";
      flake = false;
    };

    lsplens-src = {
      url = "github:VidocqH/lsp-lens.nvim";
      flake = false;
    };

    muren-src = {
      url = "github:AckslD/muren.nvim";
      flake = false;
    };

    navbuddy-src = {
      url = "github:SmiteshP/nvim-navbuddy";
      flake = false;
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };

  outputs = inputs@{ self, ... }:
    inputs.flake-utils.lib.eachDefaultSystem (system:
      let
        overlayFlakeInputs = prev: final: {
          neovim = inputs.neovim.packages.${prev.system}.neovim;

          vimPlugins = final.vimPlugins // {
            noneckpain = import ./packages/vimPlugins/noneckpain.nix {
              src = inputs.noneckpain-src;
              pkgs = prev;
            };

            muren = import ./packages/vimPlugins/muren.nix {
              src = inputs.muren-src;
              pkgs = prev;
            };

            telescope-recent-files = import ./packages/vimPlugins/telescopeRecentFiles.nix {
              src = inputs.telescope-recent-files-src;
              pkgs = prev;
            };

            lsplens = import ./packages/vimPlugins/lsplens.nix {
              src = inputs.lsplens-src;
              pkgs = prev;
            };

            navbuddy = import ./packages/vimPlugins/navbuddy.nix {
              src = inputs.navbuddy-src;
              pkgs = prev;
            };
          };
        };

        overlayNeovimPrimaMateria = prev: final: {
          neovimPrimaMateria = import ./packages/neovimPrimaMateria.nix {
            pkgs = prev;
          };
        };

        pkgs = import inputs.nixpkgs {
          system = system;
          overlays = [ overlayFlakeInputs overlayNeovimPrimaMateria ];
        };
      in
      {
        packages = rec {
          nvim = pkgs.neovimPrimaMateria;
          default = nvim;
        };

        apps = rec {
          nvim = inputs.flake-utils.lib.mkApp { drv = self.packages.${system}.nvim; };
          default = nvim;
        };
      });
}
