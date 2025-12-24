{pkgs}: let
  version = "1.2025.9";

  src = pkgs.fetchurl {
    url = "https://github.com/plantuml/plantuml/releases/download/v${version}/plantuml.jar";
    sha256 = "sha256-KA9KqX9PO3rzk1jdDXn2XjU7VKFjC18SGhOxZRFiGF0=";
  };
in
  pkgs.stdenvNoCC.mkDerivation {
    pname = "plantuml-jar";
    inherit version;

    dontUnpack = true;
    installPhase = ''
      install -Dm444 ${src} $out/share/java/plantuml.jar
    '';
  }
