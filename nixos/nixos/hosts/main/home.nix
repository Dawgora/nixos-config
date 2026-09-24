{ pkgs, lib, ... }:
{
  imports = [
    # desktop environment modules
    ../../modules/waybar
    ../../modules/rofi
    ../../modules/mako
    ../../modules/niri
    ../../modules/alacritty
    ../../modules/hyprland
    ../../modules/sway

    # user-level modules
    ../../modules/user/packages
    ../../modules/user/theme
    ../../modules/user/shell
    ../../modules/user/portals
    ../../modules/user/obsidian-sync
    ../../modules/user/neovim
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
    ];

    # SESSION VARIABLES — global environment, stays with identity
    home.sessionVariables = {
      TERMINAL = "alacritty";
      GTK_THEME = "WhiteSur-Dark-solid";
      NIXOS_HOME_CONFIG = "/home/dawgora/.config";
    };

    programs.home-manager.enable = true;
}
