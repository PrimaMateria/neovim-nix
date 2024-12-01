# PrimaMateria neovim

This is a Nix flake which provides customized neovim.
Neovim configuration is mainly focused on web development (typescript & react).

This repository was forked from https://github.com/DieracDelta/vimconf_talk.

Later I have pruned dependencies to Justin's library. His library provided
modified version of neovim wrapper which allowed to define extra runtime
dependencies.

Because this library was copied from nixpkgs once and left unmantained, I
wanted to avoid using it. Instead I create another wrapper on top of the
nixpkgs' wrapper which simply adds the runtime dependencies to the PATH env
variable.
