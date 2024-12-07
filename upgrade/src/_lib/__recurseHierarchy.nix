{
  root,
  self,
}: name:
with builtins; let
  edition = root.packages.neovim.${name};
in
  if edition.manifest ? "basedOn"
  then ((self edition.manifest.basedOn) ++ [edition])
  else [edition]
