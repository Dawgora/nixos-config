{ lib, ... }:
let
  apps = {
    browser     = "firefox.desktop";
    pdf         = "firefox.desktop";
    text        = "org.xfce.mousepad.desktop"; # "nvim.desktop" later?
    image       = "swayimg.desktop";
    video       = "mpv.desktop";
    audio       = "mpv.desktop";
    fileManager = "nemo.desktop";
    archive     = "org.gnome.FileRoller.desktop";
  };

  mimeTypes = {
    browser = [
      "text/html" "application/xhtml+xml"
      "x-scheme-handler/http" "x-scheme-handler/https"
      "x-scheme-handler/about" "x-scheme-handler/unknown"
    ];
    pdf = [ "application/pdf" ];
    text = [
      "text/plain" "text/markdown" "text/x-log" "text/x-elixir"
      "text/x-shellscript" "application/x-shellscript"
      "application/json" "application/x-yaml"
      "application/x-openvpn-profile"
    ];
    image = [
      "image/png" "image/jpeg" "image/gif" "image/webp" "image/bmp"
      "image/svg+xml" "image/tiff" "image/avif" "image/heif" "image/jxl"
    ];
    video = [
      "video/mp4" "video/x-matroska" "video/webm" "video/quicktime"
      "video/x-msvideo" "video/mpeg" "video/ogg"
    ];
    audio = [
      "audio/mpeg" "audio/flac" "audio/ogg" "audio/opus"
      "audio/wav" "audio/x-wav" "audio/mp4" "audio/aac"
    ];
    fileManager = [ "inode/directory" ];
    archive = [
      "application/zip" "application/x-7z-compressed"
      "application/vnd.rar" "application/x-rar"
      "application/x-tar" "application/gzip"
      "application/x-compressed-tar"        # .tar.gz
      "application/x-bzip2-compressed-tar"  # .tar.bz2
      "application/x-xz-compressed-tar"     # .tar.xz
      "application/x-zstd-compressed-tar"   # .tar.zst
    ];
  };

  schemeHandlers = {
    "x-scheme-handler/tg"            = [ "org.telegram.desktop.desktop" ];
    "x-scheme-handler/tonsite"       = [ "org.telegram.desktop.desktop" ];
    "x-scheme-handler/sgnl"          = [ "signal.desktop" ];
    "x-scheme-handler/signalcaptcha" = [ "signal.desktop" ];
    "x-scheme-handler/bitwarden"     = [ "bitwarden.desktop" ];
    "x-scheme-handler/tidal"         = [ "tidal-hifi.desktop" ];
    "x-scheme-handler/discord"       = [ "discord.desktop" ];
  };

  # { role = [ mime ... ]; }  →  { mime = [ app ]; }
  defaultsFor = role: lib.genAttrs mimeTypes.${role} (_: [ apps.${role} ]);
in
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications =
      lib.mergeAttrsList (map defaultsFor (lib.attrNames mimeTypes))
      // schemeHandlers;
    associations.removed = {
      "application/zip" = [ "org.prismlauncher.PrismLauncher.desktop" ];
      "application/pdf" = [ "draw.desktop" ];
    };
  };
}
