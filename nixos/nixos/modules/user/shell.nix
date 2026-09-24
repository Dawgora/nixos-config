{ config, ... }:
let
  elixir = ../elixir;
  latex = ../latex;
  ruby = ../ruby;
  php = ../php;
in {
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
  };

  home.shellAliases = {
    "elixir-devel" = "nix-shell ${elixir} --command zsh";
    "latex-devel" = "nix-shell ${latex} --command zsh";
    "ruby-devel" = "nix-shell ${ruby} --command zsh";
    "php-devel" = "nix-shell ${php} --command zsh";
    "rebuild-local-nixos-boot" = "sudo nixos-rebuild boot --flake ~/flakes/nixos/#main";
    "rebuild-local-nixos" = "sudo nixos-rebuild switch --flake ~/flakes/nixos/#main";
    "update-nixos-channel" = "sudo nix-channel --update";
    "delete-nixos-garbage" = "nix-collect-garbage --delete-old";
    "update-home-flake" = "sudo nix flake update --flake ~/flakes/nixos";
    "upload-obsidian" = "systemctl --user start proton-obsidian-sync";
  };
}
