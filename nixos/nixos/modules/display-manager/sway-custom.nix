{ pkgs, ... }:
let
  custom-sway = pkgs.writeTextFile {
    name = "sway-custom.desktop";
    destination = "";
    text = ''
      [Desktop Entry]
      Name=Sway (custom)
      Comment=Custom Sway Wayland session
      Exec=sway --unsupported-gpu
      Type=Application
      DesktopNames=sway-custom
    '';
  };
in {
  environment.etc."wayland-sessions/sway-custom.desktop".source = custom-sway;
}
