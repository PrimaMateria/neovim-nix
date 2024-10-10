{
  description = "PrimaMateria neovim flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/master";
    };

    neovim = {
      # url = "github:neovim/neovim/v0.9.5?dir=contrib";
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-plugins = {
      url = "github:zachcoyle/neovim-plugins-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    telescope-recent-files-src = {
      url = "github:smartpde/telescope-recent-files";
      flake = false;
    };

    lsplens-src = {
      url = "github:VidocqH/lsp-lens.nvim";
      flake = false;
    };

    avante-src = {
      url = "github:yetone/avante.nvim";
      flake = false;
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };

  outputs = inputs @ {self, ...}:
    inputs.flake-utils.lib.eachDefaultSystem (system: let
      overlayFlakeInputs = final: prev: {
        neovim = inputs.neovim.packages.${prev.system}.neovim;

        vimPlugins =
          prev.vimPlugins
          // {
            telescope-recent-files = import ./packages/vimPlugins/telescopeRecentFiles.nix {
              src = inputs.telescope-recent-files-src;
              pkgs = prev;
            };

            lsplens = import ./packages/vimPlugins/lsplens.nix {
              src = inputs.lsplens-src;
              pkgs = prev;
            };

            avante = import ./packages/vimPlugins/avante.nix {
              src = inputs.avante-src;
              pkgs = prev;
            };
          };
      };

      overlayNeovimPrimaMateria = final: prev: {
        neovimPrimaMateria = import ./packages/neovimPrimaMateria.nix {
          pkgs = final;
        };

        lazygit = import ./packages/lazygit.nix {
          inherit final prev;
        };
      };

      pkgs = import inputs.nixpkgs {
        system = system;
        overlays = [
          inputs.neovim-plugins.overlays.default
          overlayFlakeInputs
          overlayNeovimPrimaMateria
        ];
      };
    in {
      packages = rec {
        nvim = pkgs.neovimPrimaMateria;
        default = nvim;
      };

      apps = rec {
        nvim = inputs.flake-utils.lib.mkApp {drv = self.packages.${system}.nvim;};
        default = nvim;
      };
    });
}
