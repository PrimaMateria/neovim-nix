{
  description = "PrimaMateria neovim flake";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    neovim = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, flake-utils, nixpkgs, neovim, ... }:
    let
      runtimeDeps = pkgs: with pkgs; [
        pyright
        nodePackages.typescript-language-server
        nodePackages.eslint_d
      ];

      runtimeDeps2 = pkgs: with pkgs; [
        ripgrep
        clang
        xsel
        stylua
      ];

      plugins = pkgs: with pkgs.vimPlugins; [
        goyo-vim
        gruvbox-community
        harpoon
        lualine-nvim
        lush-nvim
        nvim-treesitter
        plenary-nvim
        popup-nvim
        tabular
        telescope-nvim
        ultisnips
        vim-nix
        vim-sandwich
        hop-nvim
        nvim-web-devicons
        nvim-tree-lua
        lsp_lines-nvim

        # Git
        gv-vim
        vim-fugitive
        vim-gitgutter
        diffview-nvim

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
      ];

      overlay = prev: final: rec {
        # Collection of snippets which are passed to UltiSnip plugins
        ultisnipsSnippets = prev.stdenv.mkDerivation {
          name = "ultisnipsSnippets";
          src = ./ultisnips;
          installPhase = ''
            mkdir -p $out/
            cp ./*.snippets $out/
          '';
        };

        # Collection of "raw" lua config files which will be loaded from neovim RC
        luaConfig = prev.stdenv.mkDerivation {
          name = "nvimLuaConfig";
          src = ./lua;
          installPhase = ''
            mkdir -p $out/
            cp ./* $out/
          '';
        };

        # Collection of packages which will be available on PATH when running neovim
        neovimRuntimeDependencies = prev.symlinkJoin {
          name = "neovimRuntimeDependencies";
          paths = runtimeDeps prev;
        };
        neovimRuntimeDependencies2 = prev.symlinkJoin {
          name = "neovimRuntimeDependencies2";
          paths = runtimeDeps2 prev;
        };

        # Use wrapper from nixpkgs which will supply config file and plugins
        neovimPrimaMateria = prev.wrapNeovim neovim.packages.x86_64-linux.neovim {
          withNodeJs = true;
          configure = {
            customRC = import ./config { inherit ultisnipsSnippets luaConfig; };
            packages.myVimPackage.start = plugins prev;
          };
        };

        # Another wrapper which just enhances PATH with runtime dependencies
        neovimPrimaMateriaWrapper = prev.writeShellApplication {
          name = "nvim";
          runtimeInputs = [ neovimRuntimeDependencies2 neovimRuntimeDependencies ];
          text = ''
            ${neovimPrimaMateria}/bin/nvim "$@"
          '';
        };
      };

    in flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ overlay ];
        };
      in {
        packages = rec {
          inherit (pkgs) neovimPrimaMateriaWrapper;
          default = neovimPrimaMateriaWrapper;
        };

        apps = rec {
          neovimPrimaMateriaWrapper = {
            type = "app";
            program = "${pkgs.neovimPrimaMateriaWrapper}/bin/nvim";
          };
          default = neovimPrimaMateriaWrapper;
        };
      });
}
