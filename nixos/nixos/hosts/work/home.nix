# work: Home Manager for dawgora. Shared modules are in modules/user/common.nix.
{ pkgs, ... }:
{
  imports = [
    ../../modules/user/common.nix
    ./packages.nix
    ./backgrounds.nix
  ];

  dawgora.swaylock.images = [
    "eDP-1:/home/dawgora/.local/share/backgrounds/middle-screen.png"
  ];

  # GNOME's terminal setting (GNOME session only)
  dconf = {
    enable = true;
    settings."org/gnome/desktop/default-applications/terminal" = {
      exec = "${pkgs.alacritty}/bin/alacritty";
    };
  };

  # First Home Manager version used here. Never change it.
  home.stateVersion = "23.11";
}
