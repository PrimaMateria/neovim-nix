{
  description = "PrimaMateria neovim flake";

  inputs = {
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    neovim = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
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

  outputs = inputs@{
    self,
    nixpkgs-unstable,
    neovim,
    telescope-recent-files-src,
    noneckpain-src,
    ...
  }:
    let
      telescope-recent-files = pkgs: pkgs.vimUtils.buildVimPlugin {
        name = "telescope-recent-files";
        src = telescope-recent-files-src;
      };

      overlay = import ./overlay.nix { 
        inherit telescope-recent-files noneckpain-src neovim;
      };

      lib = import ./packages/lib.nix  {pkgs = nixpkgs-unstable; inherit overlay; };

    in {
      packages = lib.defaultForEachFlakeSystem (pkgs:
        pkgs.neovimPrimaMateriaWrapper
      );

      apps = lib.defaultForEachFlakeSystem (pkgs: { 
        type = "app";
        program = "${pkgs.neovimPrimaMateriaWrapper}/bin/nvim";
      });

      formatter.x86_64-linux = nixpkgs-unstable.legacyPackages.x86_64-linux.nixfmt;
    };
}
