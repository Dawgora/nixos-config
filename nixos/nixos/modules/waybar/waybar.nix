{ ... }:
{
  programs.waybar = {
    systemd = {
      enable = true;
      target = "niri.service";
    };
  };
}
