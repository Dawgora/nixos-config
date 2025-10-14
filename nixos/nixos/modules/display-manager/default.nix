{pkgs, ...}:
let
  sway-session = pkgs.writeTextFile {
    name = "sway.desktop";
    destination = "";
    text =''
    [Desktop Entry]
    Name=Sway
    Comment=Sway session
    Exec=sway
    Type=Application
    DesktopNames=sway
    '';
  };

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

  environment.etc."wayland-sessions/sway.desktop".source = sway-session;
  environment.etc."wayland-sessions/sway-custom.desktop".source = custom-sway;
  environment.etc."wayland-sessions/hyprland.desktop".source = hyprland;
  environment.etc."wayland-sessions/niri.desktop".source = niri;
}
