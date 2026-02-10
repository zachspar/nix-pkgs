{
  pkgs ? import <nixpkgs> { }
}:

{
  code-cursor = pkgs.callPackage ./pkgs/code-cursor/package.nix { };
}

