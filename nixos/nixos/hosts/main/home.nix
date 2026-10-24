{ ... }:
{
  imports = [
    ../../modules/user/common.nix
    ../../modules/sway
    ./backgrounds.nix
  ];

  dawgora.swaylock.images = [
    "DP-1:/home/dawgora/.local/share/backgrounds/side-screens.png"
    "HDMI-A-1:/home/dawgora/.local/share/backgrounds/middle-screen-2.jpg"
    "HDMI-A-2:/home/dawgora/.local/share/backgrounds/side-screens.png"
  ];

  # First Home Manager version used here. Never change it.
  home.stateVersion = "23.11";
}
