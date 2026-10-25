{ pkgs, ... }:
{
  home.packages = with pkgs; [
    httpie
    tcpdump
    gettext
    ncurses
    libssh
    icu
    libpqxx
    postgresql
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
