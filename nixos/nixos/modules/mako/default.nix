{ config, pkgs, lib, ... }:
{
  imports = [ ./style.nix ];

  home.packages = with pkgs; [
    mako
    libnotify
  ];

  systemd.user.services.mako = {
    Unit = {
      Description = "Mako notification daemon";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" "niri.service" ];
    };
    Service = {
      ExecStart = "${pkgs.mako}/bin/mako";
      Restart = "on-failure";
      RestartSec = 2;
      TimeoutSec = "30";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
