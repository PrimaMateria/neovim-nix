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
  };

  outputs = inputs@{ self, ... }:
    let
      overlayFlakeInputs = final: prev: {
        neovim = inputs.neovim.packages.x86_64-linux.neovim;

        vimPlugins = prev.vimPlugins // {
          noneckpain = import ./packages/vimPlugins/noneckpain.nix {
            src = inputs.noneckpain-src;
            pkgs = final;
          };

          muren = import ./packages/vimPlugins/muren.nix {
            src = inputs.muren-src;
            pkgs = final;
          };

          telescope-recent-files = import ./packages/vimPlugins/telescopeRecentFiles.nix {
            src = inputs.telescope-recent-files-src;
            pkgs = final;
          };

          lsplens = import ./packages/vimPlugins/lsplens.nix {
            src = inputs.lsplens-src;
            pkgs = final;
          };

          navbuddy = import ./packages/vimPlugins/navbuddy.nix {
            src = inputs.navbuddy-src;
            pkgs = final;
          };
        };
      };

      overlayNeovimPrimaMateria = final: prev: {
        neovimPrimaMateria = import ./packages/neovimPrimaMateria.nix {
          pkgs = final;
        };
      };

      lib = import ./packages/lib.nix {
        pkgs = inputs.nixpkgs;
        overlays = [ overlayFlakeInputs overlayNeovimPrimaMateria ];
      };

    in {
      packages = lib.defaultForEachFlakeSystem (pkgs: pkgs.neovimPrimaMateria);

      apps = lib.defaultForEachFlakeSystem (pkgs: {
        type = "app";
        program = "${pkgs.neovimPrimaMateria}/bin/nvim";
      });

      formatter.x86_64-linux =
        inputs.nixpkgs.legacyPackages.x86_64-linux.nixfmt;
    };
}
