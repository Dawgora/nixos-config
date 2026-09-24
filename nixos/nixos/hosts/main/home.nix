{ pkgs, lib, ... }:
{
    imports = [
      ../../modules/waybar
      ../../modules/hyprland
      ../../modules/sway
      ../../modules/mako
      ../../modules/niri
      ../../modules/alacritty

      ../../modules/user/packages      # directory — no .nix
      ../../modules/user/theme.nix     # ← explicit extension
      ../../modules/user/shell.nix     # ← explicit extension
      ../../modules/user/portals.nix   # ← explicit extension
      ../../modules/user/obsidian-sync.nix  # ← explicit extension
      ../../modules/user/neovim.nix    # ← explicit extension

      ./backgrounds.nix
  ];

  home.username = "dawgora";
    home.homeDirectory = "/home/dawgora";
    home.stateVersion = "23.11";

    xdg.enable = true;

    home.file.".local/bin" = {
      source = ../../scripts;
      recursive = true;
    };

    home.file.".local/share/backgrounds" = {
      source = ./backgrounds;
      recursive = true;
    };

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "nvidia-x11" "nvidia-settings" "nvidia-persistenced"
      "obsidian" "obs-studio" "steam" "steam-unwrapped"
      "zed-editor" "discord" "discord-unwrapped" "winbox" "castlabs-electron"
    ];

    # SESSION VARIABLES — global environment, stays with identity
    home.sessionVariables = {
      TERMINAL = "alacritty";
      GTK_THEME = "WhiteSur-Dark-solid";
      NIXOS_HOME_CONFIG = "/home/dawgora/.config";
    };

    home.shellAliases = {
      "rebuild-local-nixos-boot" = "sudo nixos-rebuild boot --flake ~/flakes/nixos/#main";
      "rebuild-local-nixos" = "sudo nixos-rebuild switch --flake ~/flakes/nixos/#main";
    };

    programs.home-manager.enable = true;
}
