{ config, pkgs, lib, ... }:
{
  imports = [ ./style.nix ];

  home.packages = with pkgs; [
    libnotify  # for notify-send testing + makoctl comes bundled with mako
  ];

  # Mako itself as a service so `mako &` in start.sh is optional —
  # systemd brings it up with the session
  systemd.user.services.mako = {
    Unit = {
      Description = "Mako notification daemon";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.mako}/bin/mako";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
