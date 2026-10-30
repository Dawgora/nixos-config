{ ... }:
let
  icon = import ../icon.nix;
in
{
  programs.waybar.settings.leftSidebar = {
    layer = "top";
    position = "top";
    output = "DP-1";
    modules-left = [ "niri/workspaces" "clock#2" "clock#3" ];
    modules-right = [ "wlr/taskbar" ];

    "niri/workspaces" = {
      disable-scroll = true;
      all-outputs = false;
      format = "{name}";
      on-click = "activate";
    };

    "clock#2" = { format = "${icon "f017"} {:%H:%M}"; tooltip = false; };
    "clock#3" = { format = "${icon "f073"} {:%m-%d}"; tooltip = false; };
  };
}
