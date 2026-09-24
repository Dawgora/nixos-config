{ pkgs, ... }:
let
  hyprland = pkgs.writeTextFile {
    name = "hyprland.desktop";
    destination = "";
    text = ''
      [Desktop Entry]
      Name=Hyprland
      Comment=An intelligent dynamic tiling Wayland compositor
      Exec=Hyprland
      Type=Application
      DesktopNames=Hyprland
      Keywords=tiling;wayland;compositor;
    '';
  };
in {
  environment.etc."wayland-sessions/hyprland.desktop".source = hyprland;
}
