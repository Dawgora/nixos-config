# Home Manager settings shared by both hosts. Host files (hosts/<host>/home.nix)
# import this and add host-only modules, wallpapers and home.stateVersion.
{ lib, systemType, ... }:
{
  imports = [
    ../waybar
    ../mako
    ../niri
    ../alacritty

    ./packages
    ./theme.nix
    ./shell.nix
    ./obsidian-sync.nix
    ./neovim.nix
    ./swaylock.nix
    ./session-services.nix
    ./default-apps.nix
    ./file-manager.nix
  ];

  home.username = "dawgora";
  home.homeDirectory = "/home/dawgora";

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

  home.sessionVariables = {
    TERMINAL = "alacritty";
    NIXOS_HOME_CONFIG = "/home/dawgora/.config";
  };

  home.shellAliases = {
    "rebuild-local-nixos" = "sudo nixos-rebuild switch --flake ~/flakes/nixos/#${systemType}";
    "rebuild-local-nixos-boot" = "sudo nixos-rebuild boot --flake ~/flakes/nixos/#${systemType}";
  };

  programs.home-manager.enable = true;
}
