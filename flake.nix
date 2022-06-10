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
        ultisnipsSnippets = prev.stdenv.mkDerivation {
          name = "ultisnipsSnippets";
          src = ./ultisnips;
          installPhase = ''
            mkdir -p $out/
            cp ./*.snippets $out/
          '';
        };

        luaConfig = prev.stdenv.mkDerivation {
          name = "nvim-lua-config";
          src = ./lua;
          installPhase = ''
            mkdir -p $out/
            cp ./* $out/
          '';
        };

        # Building neovim package with dependencies and custom config
        customNeovim = DSL.neovimBuilderWithDeps.legacyWrapper neovim.defaultPackage.x86_64-linux {
          # Dependencies to be prepended to PATH env variable at runtime. Needed by plugins at runtime.
          extraRuntimeDeps = [
            prev.ripgrep
            prev.clang
            prev.xsel
            prev.stylua
            ultisnipsSnippets
          ];

          # Build with NodeJS
          withNodeJs = true;

          # TODO: would extracting config to separate derivation prevent neovim
          # rebuilds when it's changed?

          # Passing in raw config
          configure.customRC = (import ./config ultisnipsSnippets) + (import ./lua-config { inherit luaConfig; });

          configure.packages.myVimPackage.start = with prev.vimPlugins; [
            # Plugins from nixpkgs
            fern-vim
            goyo-vim
            gruvbox-community
            harpoon
            lightline-gruvbox-vim
            lightline-vim
            lush-nvim
            nvim-treesitter
            plenary-nvim
            popup-nvim
            tabular
            telescope-nvim
            telescope-project-nvim
            ultisnips
            vim-nix
            vim-sandwich
            hop-nvim

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
