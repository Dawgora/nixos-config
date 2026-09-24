{ config, pkgs, lib, ... }:

let
  customNeovim = import ../../modules/nvim;
  elixir = ../../modules/elixir;
  latex = ../../modules/latex;
  ruby = ../../modules/ruby;
  php = ../../modules/php;
in
  {

    imports = [
      ../../modules/waybar
      ../../modules/hyprland
      ../../modules/sway
      ../../modules/mako
      ../../modules/niri
      ../../modules/alacritty
    ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dawgora";
  home.homeDirectory = "/home/dawgora";

  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.pointerCursor = {
    enable = true;
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

    gtk4.theme = null;
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    pamixer
    pavucontrol
    winbox
    parallel
    discord
    tidal-hifi
    bitwarden-menu
    bitwarden-desktop
    audacity
    tcpdump
    remmina
    firefox
    httpie
    p7zip
    udisks
    libreoffice-qt-stable
    libpqxx
    tree
    vim
    arandr
    razergenie
    telegram-desktop
    alarm-clock-applet
    tmux
    flameshot
    jq
    gettext
    htop
    btop
    dconf
    mpv
    swaylock
    prismlauncher
    thunar
    ranger
    feh
    mousepad
    yubikey-personalization
    yubioath-flutter
    obsidian
    fastfetch
    signal-desktop
    obs-studio
    qbittorrent
    vlc
    dbeaver-bin
    git
    unzip
    ncurses
    libssh
    openssl
    libssh
    icu
    tig
    postgresql
    docker
    inotify-tools
    nodejs_22
    networkmanagerapplet
    wireguard-tools
    jellyfin-ffmpeg
    yt-dlp
    bashInteractiveFHS
    python3
    bazecor
    hyprshot
    playerctl
    steam
    gamescope
    heroic
    bluez
    overskride
    gnome-tweaks
    p7zip
    shikane
    wlr-randr
    zed-editor
    proton-vpn
    wlogout
  ];

  xdg.enable = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
#  # plain files is through 'home.file'.
home.file = {
  ".local/bin" = {
    source = ../../scripts;
    recursive = true;
  };
};

xdg.portal = {
  enable = true;
  extraPortals = with pkgs; [
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
      #xdg-desktop-portal-gtk
    #  xdg-desktop-portal-wlr
  ];
  config = {
    hyprland = {
      default = [ "hyprland" "gtk" ];
      "org.freedesktop.impl.portal.ScreenCast" = [
        "gnome"
      ];
      "org.freedesktop.impl.portal.FileChooser" = "kde";
    };
  };
};

#xdg.configFile."sway/config" = {
#  source = ../../modules/sway/config;
#  enable = true;
#  onChange = "systemctl --user restart kanshi.service";
#};

programs.zsh = {
  enable = true;
  dotDir = "${config.xdg.configHome}/zsh";
  initExtra = ''
  '';
};


nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
  "nvidia-x11"
  "nvidia-settings"
  "nvidia-persistenced"
  "obsidian"
  "obs-studio"
  "steam"
  "steam-unwrapped"
  "zed-editor"
  "discord"
  "discord-unwrapped"
  "winbox"
  "castlabs-electron"
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
    "elixir-devel"="nix-shell ${elixir} --command zsh";
    "latex-devel"="nix-shell ${latex} --command zsh";
    "ruby-devel"="nix-shell ${ruby} --command zsh";
    "php-devel"="nix-shell ${php} --command zsh";
    "rebuild-local-nixos-boot" = "sudo nixos-rebuild boot --flake ~/flakes/nixos/#main";
    "rebuild-local-nixos" = "sudo nixos-rebuild switch --flake ~/flakes/nixos/#main";
    "update-nixos-channel" = "sudo nix-channel --update";
    "delete-nixos-garbage" = "nix-collect-garbage --delete-old";
    "update-home-flake" = "sudo nix flake update --flake ~/flakes/nixos";
    "upload-obsidian" = "systemctl --user start proton-obsidian-sync";
  };

 #=================================
  systemd.user.services.proton-obsidian-sync = {
    Unit.Description = "Backup Obsidian vault to Proton Drive";
    Service = {
      Type = "oneshot";
      ExecStart = "/home/dawgora/.local/bin/proton-obsidian-sync.sh";
      Environment = [
        "NIX_LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [ pkgs.libsecret pkgs.stdenv.cc.cc.lib pkgs.glib pkgs.dbus ]}"
        "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus"
        "HOME=/home/dawgora"
      ];
    };
  };

  systemd.user.timers.proton-obsidian-sync = {
    Unit.Description = "Timer for Obsidian vault backup";
    Timer = {
      OnCalendar = [ "*-*-* 02:00:00" "*-*-* 14:00:00" ];
      Persistent = true;
    };
    Install.WantedBy = [ "timers.target" ];
  };

   #=================================

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
