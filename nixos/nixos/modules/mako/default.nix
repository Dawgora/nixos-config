{ config, pkgs, lib, ... }:
{
  imports = [ ./style.nix ];

  home.packages = with pkgs; [
    mako
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
      Environment = "WAYLAND_DISPLAY=${config.wayland.display}" # or just rely on env
      TimeoutSec = 30;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
