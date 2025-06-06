{ config, pkgs, lib, ... }:

let
   customNeovim = import ./modules/nvim/nvim.nix;
   elixir = import ./modules/elixir/flake.nix;
in
{

  imports = [
    ./modules/waybar
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dawgora";
  home.homeDirectory = "/home/dawgora";

  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.pointerCursor = {
    name = "capitaine-cursors";
    package = pkgs.capitaine-cursors;
    size = 24;
  };

  gtk = {
    enable = true;
    iconTheme = {
    name = "WhiteSur-dark";
    package = pkgs.whitesur-icon-theme;
  };

  theme = {
    name = "WhiteSur-Dark-solid";
    package = pkgs.whitesur-gtk-theme;
  };

  cursorTheme = {
    name = "capitaine-cursors";
    package = pkgs.capitaine-cursors;
    size = 24;
  };
};

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
      pkgs.firefox
      pkgs.librewolf
      pkgs.ungoogled-chromium
      pkgs.vscode
      pkgs.p7zip
      pkgs.udisks
      pkgs.libreoffice-qt
      pkgs.libpqxx
      pkgs.tree
      pkgs.vim
      pkgs.arandr
      pkgs.alacritty
      pkgs.discord
      pkgs.vesktop
      pkgs.razergenie
      pkgs.spotify
      pkgs.telegram-desktop
      pkgs.tailscale
      pkgs.alarm-clock-applet
      pkgs.tmux
      pkgs.flameshot
      pkgs.jq
      pkgs.gettext
      pkgs.htop
      pkgs.btop
      pkgs.dconf
      pkgs.mpv
      pkgs.xss-lock
      pkgs.prismlauncher
      pkgs.xfce.thunar
      pkgs.ranger
      pkgs.feh
      pkgs.bitwarden
      pkgs.keepass
      pkgs.xfce.mousepad
      pkgs.yubikey-personalization
      pkgs.yubioath-flutter
      pkgs.obsidian
      pkgs.tigervnc
      pkgs.neofetch
      pkgs.signal-desktop
      pkgs.davinci-resolve
      pkgs.obs-studio
      pkgs.qbittorrent
      pkgs.vlc
      pkgs.dbeaver-bin
      pkgs.git
      pkgs.unzip
      pkgs.pamixer
      pkgs.ncurses
      pkgs.libssh
      pkgs.openssl
      pkgs.libssh
      pkgs.icu
      pkgs.tig
      pkgs.postgresql
      pkgs.docker
      pkgs.inotify-tools
      pkgs.nodejs_22
      pkgs.networkmanagerapplet
      pkgs.wireguard-tools
      pkgs.jellyfin-ffmpeg
      pkgs.yt-dlp
      pkgs.bashInteractiveFHS
      pkgs.plex
      pkgs.plexRaw
      pkgs.darktable
      pkgs.python3
      pkgs.bazecor
      pkgs.hyprshot
      pkgs.pavucontrol
      pkgs.playerctl
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  programs.zsh = {
  enable = true;
  initExtra = ''
        . "${pkgs.asdf-vm}/share/asdf-vm/asdf.sh"
        . "${pkgs.asdf-vm}/share/asdf-vm/completions/asdf.bash"
  '';
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "nvidia-x11"
	"nvidia-settings"
	"nvidia-persistenced"
	"discord"
	"spotify"
	"obsidian"
	"davinci-resolve"
	"obs-studio"
	"steam"
    "steam-unwrapped"
	"plexmediaserver"
	"vscode"
      ];

  programs.neovim = customNeovim pkgs;
  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/dawgora/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "alacritty";
    GTK_THEME = "WhiteSur-Dark-solid";
    NIXOS_HOME_CONFIG = "/home/dawgora/.config";
  };

  home.shellAliases = {
    "elixir-devel"="nix develop ~/flakes/nixos/nixos/modules/elixir";
    "rebuild-local-nixos" = "sudo nixos-rebuild switch --flake ~/flakes/nixos/#myNixos";
    "update-nixos-channel" = "sudo nix-channel --update";
    "delete-nixos-garbage" = "nix-collect-garbage --delete-old";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
