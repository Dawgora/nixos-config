{ pkgs }:

# ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-0 --mode 1920x1080 --pos 3640x0 --rotate left --output DP-2 --primary --mode 2560x1440 --rate 120 --pos 1080x480 --output HDMI-1 --mode 1920x1080 --pos 0x0 --rotate left

pkgs.writeShellScriptBin "screen-script" ''
  ${pkgs.xorg.xrandr}/bin/xrandr --output DP-2 --mode 2560x1440 --rate 120 --pos 1080x480 --primary
  ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-0 --mode 1920x1080 --pos 3640x0 --rotate left --noprimary
  ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-1 --mode 1920x1080 --pos 0x0 --rotate left --noprimary
''
