{super}: hierarchy:
with builtins; let
  dependencies = concatMap (edition:
    if edition ? dependencies
    then edition.dependencies
    else [])
  hierarchy;
  dependenciesEnd = concatMap (edition:
    if edition ? dependenciesEnd
    then edition.dependenciesEnd
    else [])
  hierarchy;
in
  # Create a derivation that aggregates symlinks of all runtime dependencies
  # from the list.
  super.joinRuntimeDependencies {
    dependencies = dependencies ++ dependenciesEnd;
  }
