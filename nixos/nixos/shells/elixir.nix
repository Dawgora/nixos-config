{ pkgs }:

let
  inherit (import ../lib/elixir.nix pkgs) elixir;
in
pkgs.mkShell {
  buildInputs = [ elixir ];
}
