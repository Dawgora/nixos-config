{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vim
    tmux
    httpie
    tcpdump
    gettext
    ncurses
    libssh
    openssl
    icu
    libpqxx
    postgresql
    docker
    inotify-tools
    nodejs_22
    python3
    parallel
    wireguard-tools
    bashInteractiveFHS
    playerctl
    pamixer
    pavucontrol
  ];
}
