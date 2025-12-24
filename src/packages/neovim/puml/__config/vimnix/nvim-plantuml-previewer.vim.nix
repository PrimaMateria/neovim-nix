# vim: ft=vim
{extraPackages, pkgs}: ''
  let g:plantuml_previewer#viewer_path = "/mnt/c/Users/matus.benko/Downloads/plantumlPreviewer"
  let g:plantuml_previewer#plantuml_jar_path = "${extraPackages.plantuml-jar}/share/java/plantuml.jar"
''
