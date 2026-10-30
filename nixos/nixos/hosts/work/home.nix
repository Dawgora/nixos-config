# work: Home Manager for dawgora. Shared modules are in modules/user/common.nix.
{ pkgs, ... }:
{
  imports = [
    ../../modules/user/common.nix
    ./packages.nix
    ./backgrounds.nix
  ];

  dawgora.swaylock.images = [
    # no output prefix: the same image on every screen
    "/home/dawgora/.local/share/backgrounds/middle-screen.png"
  ];

  # GNOME's terminal setting (GNOME session only)
  dconf = {
    enable = true;
    # schema org.gnome.desktop.default-applications.terminal lives at this path
    settings."org/gnome/desktop/applications/terminal" = {
      exec = "${pkgs.alacritty}/bin/alacritty";
    };
  };

  # First Home Manager version used here. Never change it.
  home.stateVersion = "23.11";
}
