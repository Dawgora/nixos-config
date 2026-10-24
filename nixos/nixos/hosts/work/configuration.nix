{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/common.nix
    ../../modules/steam
    ../../modules/nginx
    ../../modules/display-manager
  ];

  home-manager.users.dawgora = import ./home.nix;

  networking.hostName = "work";

  # ── Session ─────────────────────────────────────────────────────────────

  services.displayManager = {
    defaultSession = "sway";
    ly.settings.waylandsessions = "/etc/wayland-sessions";
  };

  services.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = [ pkgs.nautilus ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  hardware.bluetooth.settings.General.Experimental = true;

  # ── Work services ───────────────────────────────────────────────────────
  services.teamviewer.enable = true;
  services.netbird.enable = true;

  dawgora.unfreePackages = [ "teamviewer" "google-chrome" ];

  programs.winbox = {
    enable = true;
    openFirewall = true;
  };

  programs.nix-ld.libraries = [ pkgs.dart-sass ];

  environment.sessionVariables = {
    EDITOR = "nvim";
    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
  };
  environment.variables.EDITOR = "nvim";

  environment.systemPackages = with pkgs; [
    netbird-ui
    rofi
  ];

  # First NixOS version installed on this machine. Never change it.
  system.stateVersion = "23.11"; # Did you read the comment?
}
