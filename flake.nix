{
  description = "PrimaMateria neovim flake";

  # Input source for our derivation
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";
    DSL.url = "github:DieracDelta/nix2lua";
    nix2vim = {
      url = "github:gytis-ivaskevicius/nix2vim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim = {
      url =
        "github:neovim/neovim?rev=e502e8106a4cde676190cd6d5c0c018eb6fd1d65&dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, flake-utils, nixpkgs, neovim, nix2vim, DSL, ... }:
    let
      # Function to override the source of a package
      withSrc = pkg: src: pkg.overrideAttrs (_: { inherit src; });
      # Vim2Nix DSL
      dsl = nix2vim.lib.dsl;

      overlay = prev: final: rec {
        # Building neovim package with dependencies and custom config
        customNeovim = DSL.neovimBuilderWithDeps.legacyWrapper neovim.defaultPackage.x86_64-linux {
          # Dependencies to be prepended to PATH env variable at runtime. Needed by plugins at runtime.
          extraRuntimeDeps = with prev; [
            ripgrep
            clang
            xsel
          ];

          # Build with NodeJS
          withNodeJs = true;

          # Passing in raw lua config
          configure.customRC = import ./config;

          configure.packages.myVimPackage.start = with prev.vimPlugins; [
            # Plugins from nixpkgs
            fern-vim
            goyo-vim
            gruvbox-community
            harpoon
            lightline-gruvbox-vim
            lightline-vim
            lush-nvim
            nvim-compe
            nvim-treesitter
            plenary-nvim
            popup-nvim
            tabular
            telescope-nvim
            telescope-project-nvim
            ultisnips
            vim-nix
            vim-sandwich

            # Git
            gv-vim
            vim-fugitive
            vim-gitgutter

            # Commenting
            vim-commentary
            nvim-ts-context-commentstring

            # Completition
            nvim-cmp
            cmp-nvim-lsp
            cmp-buffer
            cmp-path
            cmp-cmdline
            cmp-nvim-ultisnips

            nvim-lspconfig
            nvim-lsp-ts-utils
            null-ls-nvim

            # Compile syntaxes into treesitter
            (prev.vimPlugins.nvim-treesitter.withPlugins
              (plugins: with plugins; [ tree-sitter-nix tree-sitter-rust ]))
          ];
        };

      };

    in flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ nix2vim.overlay overlay ];
        };
      in {
        # The packages: our custom neovim
        packages = { inherit (pkgs) customNeovim; };

        # The package built by `nix build .`
        defaultPackage = pkgs.customNeovim;

        # The app run by `nix run .`
        defaultApp = {
          type = "app";
          program = "${pkgs.customNeovim}/bin/nvim";
        };
      });
}
