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
      secrets = import ./.secrets/secrets.nix;

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
        nui-nvim
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
        ChatGPT-nvim

        # Git
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

      overlay = import ./overlay.nix { 
        inherit runtimeDeps runtimeDeps2 plugins telescope-recent-files noneckpain secrets neovim;
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
