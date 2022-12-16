{
  description = "PrimaMateria neovim flake";

  inputs = {
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

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

  outputs = inputs@{ self, flake-utils, nixpkgs-unstable, neovim, telescope-recent-files-src, noneckpain-src, ... }:
    let
      telescope-recent-files = pkgs: pkgs.vimUtils.buildVimPlugin {
        name = "telescope-recent-files";
        src = telescope-recent-files-src;
      };

      noneckpain = pkgs: pkgs.vimUtils.buildVimPlugin {
        name = "noneckpain";
        src = noneckpain-src;
        dontBuild = true;
      };

      runtimeDeps = pkgs: with pkgs; [
        pyright
        nodePackages.typescript
        nodePackages.typescript-language-server
        nodePackages.eslint_d
        nodePackages.prettier
      ];

      runtimeDeps2 = pkgs: with pkgs; [
        ripgrep
        clang
        xsel
        stylua
        ltex-ls
        lazygit
      ];

      plugins = pkgs: with pkgs.vimPlugins; [
        gruvbox-community
        harpoon
        lualine-nvim
        lush-nvim
        nvim-treesitter
        plenary-nvim
        popup-nvim
        tabular
        telescope-nvim
        sqlite-lua
        ultisnips
        vim-nix
        nvim-web-devicons
        nvim-tree-lua
        lspsaga-nvim
        vim-abolish

        # Git
        # TODO: remove fugitive and gv in lazygit proves useful
        gv-vim 
        vim-fugitive
        vim-gitgutter
        diffview-nvim
        lazygit-nvim

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
        lsp-status-nvim
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

        luaConfigNix = prev.writeTextFile { 
          name = "nvimLspConfig.lua";
          text = import ./luanix/nvim-lspconfig.nix { pkgs = prev; };
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
            customRC = import ./config { inherit ultisnipsSnippets luaConfig luaConfigNix; };
            packages.myVimPackage.start = plugins final ++ [
              (telescope-recent-files prev)
              (noneckpain prev)
            ];
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
        pkgs = import nixpkgs-unstable {
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
