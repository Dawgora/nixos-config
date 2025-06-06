{
  pkgs ? import <nixpkgs> { },
}:

with pkgs;
let
  elixir = beam.packages.erlang_27.elixir_1_18;
in
  mkShell {
    buildInputs = [ elixir ];
  }
