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
