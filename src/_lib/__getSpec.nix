{super}: name: let
  hierarchy = super.hierarchy.recurse name;
in {
  config = super.hierarchy.getConfig hierarchy;
  plugins = super.hierarchy.getPlugins hierarchy;
  runtimeDeps = super.hierarchy.getRuntimeDeps hierarchy;
}
