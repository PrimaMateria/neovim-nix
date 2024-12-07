{super}:
with builtins;
  hierarchy:
    concatStringsSep "\n" (map super.collectEditionConfig hierarchy)
