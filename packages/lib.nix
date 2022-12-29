{ pkgs, overlay }:
let inherit (pkgs.lib) genAttrs systems;
in {
  defaultForEachFlakeSystem = definition:
    genAttrs systems.flakeExposed (system:
      let
        pkgsSystem = import pkgs {
          inherit system;
          overlays = [ overlay ];
        };
      in { default = definition pkgsSystem; });
}
