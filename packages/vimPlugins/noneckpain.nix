{ src }: (pkgs: pkgs.vimUtils.buildVimPlugin {
        name = "noneckpain";
        inherit src;
        dontBuild = true;
      })
