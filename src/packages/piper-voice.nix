{pkgs}: let
  voice = "en_US-lessac-medium";

  base = "https://huggingface.co/rhasspy/piper-voices/resolve/main/en/en_US/lessac/medium/${voice}";

  model = pkgs.fetchurl {
    url = "${base}.onnx";
    hash = "sha256-Xv4J5pkCGHgnr2RuGm6dJp3udp+Yd9F7FrG0buqvAZ8=";
  };

  modelConfig = pkgs.fetchurl {
    url = "${base}.onnx.json";
    hash = "sha256-7+GcQXvtBV8taZCCSMa6ZQ+hNbyGiw5quz2hgdq2kKA=";
  };
in
  pkgs.stdenvNoCC.mkDerivation {
    pname = "piper-voice-${voice}";
    version = "1.0.0";

    dontUnpack = true;

    # piper picks up <model>.onnx.json from next to the model, so both files
    # have to land in the same directory.
    installPhase = ''
      install -Dm444 ${model} $out/share/piper-voices/${voice}.onnx
      install -Dm444 ${modelConfig} $out/share/piper-voices/${voice}.onnx.json
    '';

    passthru.modelPath = "/share/piper-voices/${voice}.onnx";
  }
