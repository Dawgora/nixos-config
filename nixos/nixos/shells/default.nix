{ pkgs }:

{
  # Working on this flake: Nix language server + formatter
  default = pkgs.mkShell {
    packages = [
      pkgs.nil
      pkgs.nixfmt
    ];
  };

  elixir = import ./elixir.nix { inherit pkgs; };
  ruby = import ./ruby.nix { inherit pkgs; };
  php = import ./php.nix { inherit pkgs; };
  latex = import ./latex.nix { inherit pkgs; };
}
