{pkgs}: {dependencies}:
pkgs.symlinkJoin {
  name = "neovimRuntimeDependencies";
  paths = dependencies;
  # see: https://ertt.ca/blog/2022/01-12-nix-symlinkJoin-nodePackages/
  postBuild = ''
    for f in $out/lib/node_modules/.bin/*; do
       path="$(readlink --canonicalize-missing "$f")"
       ln -s "$path" "$out/bin/$(basename $f)"
    done
  '';
}
