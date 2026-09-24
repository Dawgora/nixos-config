{ pkgs, ... }:
{
  systemd.user.services.proton-obsidian-sync = {
    Unit.Description = "Backup Obsidian vault to Proton Drive";
    Service = {
      Type = "oneshot";
      ExecStart = "/home/dawgora/.local/bin/proton-obsidian-sync.sh";
      Environment = [
        "NIX_LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [ pkgs.libsecret pkgs.stdenv.cc.cc.lib pkgs.glib pkgs.dbus ]}"
        "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus"
        "HOME=/home/dawgora"
      ];
    };
  };

  systemd.user.timers.proton-obsidian-sync = {
    Unit.Description = "Timer for Obsidian vault backup";
    Timer = {
      OnCalendar = [ "*-*-* 02:00:00" "*-*-* 14:00:00" ];
      Persistent = true;
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
