{super}:
with builtins;
  hierarchy:
    concatStringsSep "\n" (map super.edition.getConfig hierarchy)
