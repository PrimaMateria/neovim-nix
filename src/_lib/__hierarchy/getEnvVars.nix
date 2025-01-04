{pkgs}: hierarchy:
with builtins;
with pkgs.lib; let
  # collect list of env vars sets
  editionEnvVarsSets = map (edition:
    if edition ? envVars
    then edition.envVars
    else {})
  hierarchy;

  # fold it all to one big set
  envVarsSet = foldl (accumulator: editionEnvVarsSet: accumulator // editionEnvVarsSet) {} editionEnvVarsSets;

  # transform the big set to shell var string
  envVarsString = concatStringsSep " " (mapAttrsToList toShellVar envVarsSet);
in
  envVarsString
