{ pkgs, ... }:
let
  sway-session = pkgs.writeTextFile {
    name = "sway.desktop";
    destination = "";
    text = ''
      [Desktop Entry]
      Name=Sway
      Comment=Sway session
      Exec=sway
      Type=Application
      DesktopNames=sway
    '';
  };
in {
  environment.etc."wayland-sessions/sway.desktop".source = sway-session;
}
