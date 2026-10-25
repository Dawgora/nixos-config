{ pkgs }:

with pkgs;
let
  latex = texliveFull;
in
  mkShell {
    buildInputs = [ latex ];
  }
