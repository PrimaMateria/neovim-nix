{
  super,
  debug,
}: name: let
  hierarchy = super.recurseHierarchy name;
in {
  customRC = super.collectHierarchyConfig hierarchy;
  allPlugins = super.collectHierarchyPlugins hierarchy;
  joinedRuntimeDependencies = super.collectHierarchyRuntimeDependencies hierarchy;
}
