{ ... }:
{
  programs.waybar.settings.mainBar = {
    layer = "top";
    position = "top";
    height = 40;
    output = "eDP-1";

    modules-left = [ "niri/workspaces" "niri/window" "clock" ];
    modules-center = [];
    modules-right = [
      "network#wifi" "network#eth"
      "group/media" "group/hardware" "group/audio"
      "battery" "backlight" "bluetooth" "tray" "custom/power"
    ];

    # === LAPTOP-SPECIFIC MODULES ===
    "battery" = {
      states = {
        good = 80;
        warning = 30;
        critical = 15;
      };
      format = "{icon} {capacity:2}%";
      format-charging = " {capacity:2}%";
      format-plugged = " {capacity:2}%";
      format-icons = [ "" "" "" "" "" ];
      interval = 30;
      tooltip = false;
    };

    "backlight" = {
      device = "intel_backlight";
      format = "{icon} {percent:2}%";
      format-icons = [ "" "" "" "" "" "" "" "" ];
      on-scroll-up = "brightnessctl set +5%";
      on-scroll-down = "brightnessctl set 5%-";
    };

    "bluetooth" = {
      format = " {status}";
      format-connected = " {num_connections}";
      tooltip-format = "{deviceAlias}";
      on-click = "overskride";
    };

    "network#wifi" = {
      interface = "wlp3s0";   # change me
      format-wifi = " {essid}";
      format-disconnected = "";  # invisible when no wifi
      tooltip-format = "{ifname} {essid} ({signalStrength}%) {ipaddr}";
    };

    "network#eth" = {
      interface = "enp0s31f6";  # change me
      format-ethernet = " Wired";
      format-disconnected = "";
      tooltip-format = "{ifname} {ipaddr}";
    };
  };
}
