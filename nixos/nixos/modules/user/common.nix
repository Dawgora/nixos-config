# Home Manager settings shared by both hosts. Host files (hosts/<host>/home.nix)
# import this and add host-only modules, wallpapers and home.stateVersion.
{ systemType, ... }:
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
    ../nvim
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
