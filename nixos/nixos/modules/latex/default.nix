{
  pkgs ? import <nixpkgs> { },
}:

with pkgs;
let
  latex = nixos.texliveTeTeX;
in
  mkShell {
    buildInputs = [ latex ];
  }
