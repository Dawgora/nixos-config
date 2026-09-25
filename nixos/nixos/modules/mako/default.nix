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
      After = [ "graphical-session-pre.target" ];
    };
    Service = {
      ExecStart = "${pkgs.mako}/bin/mako";
      Restart = "on-failure";
      TimeoutSec = "30";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
