{ pkgs, ... }:
let
  niri = pkgs.writeTextFile {
    name = "niri.desktop";
    destination = "";
    text = ''
      [Desktop Entry]
      Name=Niri
      Comment=Niri wayland session
      Exec=niri
      Type=Application
      DesktopNames=niri
    '';
  };
in {
  environment.etc."wayland-sessions/niri.desktop".source = niri;
}
