{ pkgs, lib, ... }:
{
  imports = [
    # shared desktop stack
    ../../modules/waybar
    ../../modules/mako
    ../../modules/niri
    ../../modules/alacritty

    # shared user modules
    ../../modules/user/packages      # directory — no .nix
    ../../modules/user/theme.nix     # ← explicit extension
    ../../modules/user/shell.nix     # ← explicit extension
    ../../modules/user/portals.nix   # ← explicit extension
    ../../modules/user/obsidian-sync.nix  # ← explicit extension
    ../../modules/user/neovim.nix    # ← explicit extension

    # work-machine extras
    ./packages.nix
  ];

  home.username = "dawgora";
  home.homeDirectory = "/home/dawgora";
  home.stateVersion = "23.11";

  xdg.enable = true;

  home.file.".local/bin" = {
    source = ../../scripts;
    recursive = true;
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "nvidia-x11" "nvidia-settings" "nvidia-persistenced"
    "obsidian" "obs-studio" "steam" "steam-unwrapped"
    "zed-editor" "discord" "discord-unwrapped" "winbox" "castlabs-electron"
    "teamviewer" "slack" "google-chrome"
  ];

  # machine-specific aliases — note the flake target
  home.shellAliases = {
    "rebuild-local-nixos" = "sudo nixos-rebuild switch --flake ~/flakes/nixos/#work";
    "rebuild-local-nixos-boot" = "sudo nixos-rebuild boot --flake ~/flakes/nixos/#work";
  };

  dconf = {
    enable = true;
    settings."org/gnome/desktop/default-applications/terminal" = {
      exec = "${pkgs.alacritty}/bin/alacritty";
    };
  };

  home.sessionVariables = {
    TERMINAL = "alacritty";
    GTK_THEME = "WhiteSur-Dark-solid";
    NIXOS_HOME_CONFIG = "/home/dawgora/.config";
  };

  programs.home-manager.enable = true;
}
