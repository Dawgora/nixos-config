{ config, ... }:
let
in {
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
  };

  home.shellAliases = {
    "elixir-devel" = "nix develop ~/flakes/nixos#elixir --command zsh";
    "latex-devel" = "nix develop ~/flakes/nixos#latex --command zsh";
    "ruby-devel" = "nix develop ~/flakes/nixos#ruby --command zsh";
    "php-devel" = "nix develop ~/flakes/nixos#php --command zsh";
    "update-home-flake" = "nix flake update --flake ~/flakes/nixos";
    "upload-obsidian" = "systemctl --user start proton-obsidian-sync";
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
