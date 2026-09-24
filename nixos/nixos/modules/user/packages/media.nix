{ pkgs, ... }:
{
  home.packages = with pkgs; [
    tidal-hifi
    mpv
    vlc
    audacity
    obs-studio
    qbittorrent
    jellyfin-ffmpeg
    yt-dlp
    flameshot
    hyprshot
  ];
}
