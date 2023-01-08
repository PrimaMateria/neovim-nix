{
  description = "PrimaMateria neovim flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs";
    };

    neovim = {
      url = "github:neovim/neovim?dir=contrib";
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
  };

  outputs = inputs@{ self, ... }:
    let
      overlayFlakeInputs = prev: final: {
        neovim = inputs.neovim.packages.x86_64-linux.neovim;

        vimPlugins = final.vimPlugins // {
          noneckpain = import ./packages/vimPlugins/noneckpain.nix {
            src = inputs.noneckpain-src;
            pkgs = prev;
          };

          telescope-recent-files = import ./packages/vimPlugins/telescopeRecentFiles.nix {
            src = inputs.telescope-recent-files-src;
            pkgs = prev;
          };
        };
      };

      overlayNeovimPrimaMateria = prev: final: {
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
