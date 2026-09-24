{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    rofi-wayland
  ];

  # Import the theme
  imports = [ ./style.nix ];

  # Keybind (optional — can also go in niri config directly)
  xdg.configFile."niri/config.kdl".onChange = ''
    # rofi is bound in niri's config.kdl:
    # binds { Mod+D hotkey-overlay-title="" { spawn "rofi" "-show" "drun"; } }
  '';
}
