{ ... }:
{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "niri.service";   # only under niri; sway/hyprland keep using start.sh
    };
  };
}
