{ ... }:
{
  programs.waybar.settings.mainBar = {
    layer = "top";
    position = "top";
    height = 40;
    output = "eDP-1";

    modules-left = [ "niri/workspaces" "niri/window" "clock" ];
    modules-center = [];
    modules-right = [ "network" "group/media" "group/hardware" "group/audio" "battery" "backlight" "bluetooth" "tray" "custom/power" ];

    # === ENHANCED FEATURES FROM HOME.NIX ===
    "clock" = {
      format = " {:%H:%M:%S}";
      tooltip-format = "<tt><big>{calendar}</big></tt>";
      interval = 1;
      locale = "en_GB.UTF-8";
      calendar = {
        mode = "month";
        mode-mon-col = true;
        weeks-pos = "right";
        on-scroll = 1;
        format = {
          today = "<span weight='bold' foreground='#268bd2'>{}</span>";
        };
      };
    };

    "group/media" = {
      orientation = "inherit";
      modules = [ "custom/media-prev" "custom/media-play" "custom/media-next" ];
    };

    "custom/media-prev" = {
      format = "󰒮";
      tooltip = false;
      on-click = "playerctl previous -p chromium";
    };

    "custom/media-play" = {
      format = " {} ";
      exec = "/home/dawgora/flakes/nixos/nixos/scripts/media-status.sh";
      return-type = "json";
      interval = 2;
      on-click = "playerctl play-pause -p chromium 2>/dev/null || tidal-hifi";
      on-click-right = "tidal-hifi";
    };

    "custom/media-next" = {
      format = "󰒭";
      tooltip = false;
      on-click = "playerctl next -p chromium";
    };

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

    "network" = {
      format-wifi = " {essid}";
      format-ethernet = " Wired";
      format-disconnected = "⚠ Offline";
      tooltip = false;
    };
  };
}
