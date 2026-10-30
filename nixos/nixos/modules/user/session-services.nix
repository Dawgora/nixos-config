{ config, pkgs, ... }:
let
  bin = "${config.home.homeDirectory}/.local/bin";
  niriUnit = desc: {
    Description = desc;
    PartOf = [ "niri.service" ];
    After = [ "niri.service" ];
  };
in
{
  xdg.configFile."autostart/remmina-applet.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Remmina Applet
    Hidden=true
  '';

  systemd.user.services = {
    waybar = {
      Unit = niriUnit "Waybar";
      Service = {
        ExecStart = "${config.programs.waybar.package}/bin/waybar";
        Restart = "on-failure";
        RestartSec = 2;
      };
      Install.WantedBy = [ "niri.service" ];
    };

    awww = {
      Unit = niriUnit "awww wallpaper daemon";
      Service = {
        ExecStart = "${pkgs.awww}/bin/awww-daemon";
        # wait until the daemon answers, then set per-screen images
        ExecStartPost = "${pkgs.bash}/bin/sh -c 'until ${pkgs.awww}/bin/awww query >/dev/null 2>&1; do sleep 0.2; done; set-backgrounds'";
        Restart = "on-failure";
        RestartSec = 2;
      };
      Install.WantedBy = [ "niri.service" ];
    };

    protonvpn-app = {
      Unit = (niriUnit "Proton VPN tray app") // { After = [ "niri.service" "waybar.service" ]; };
      Service = {
        ExecStart = "${pkgs.proton-vpn}/bin/protonvpn-app";
        Restart = "on-failure";
        RestartSec = 2;
      };
      Install.WantedBy = [ "niri.service" ];
    };

    # before-sleep: lock before suspend (lid close), so the session never wakes unlocked.
    # -w makes swayidle wait for it; swaylock -f returns once the lock is up.
    swayidle = {
      Unit = niriUnit "Idle lock / monitor power-off";
      Service = {
        ExecStart = "${pkgs.swayidle}/bin/swayidle -w timeout 300 '${bin}/lock-if-idle lock' timeout 600 '${bin}/lock-if-idle poweroff' resume 'niri msg action power-on-monitors' before-sleep 'lock-screen'";
        Restart = "on-failure";
        RestartSec = 2;
      };
      Install.WantedBy = [ "niri.service" ];
    };
  };
}
