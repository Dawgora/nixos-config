# Path of Exile 1 + Awakened PoE Trade (APT) on niri. Home Manager module, main only.
#
# APT only works on X11 (global hotkeys, fake Ctrl+C, a transparent window placed
# over the game), and under xwayland-satellite its overlay becomes a separate tiled
# niri window. So the game and APT get their own small X server:
#
#   rootful Xwayland on :2  (one niri window, see the rule in niri/fragments/30-rules.kdl)
#     ├─ openbox  EWMH window manager: sets _NET_ACTIVE_WINDOW, which APT needs to attach
#     ├─ picom    compositor, so APT's overlay is transparent (only xrender works on
#     │           NVIDIA under Xwayland: no texture_from_pixmap / EGL image_pixmap)
#     ├─ Path of Exile  (Steam launch options: poe-run gamemoderun mangohud %command%)
#     └─ APT
#
# Start: rofi "PoE overlay session" (or `poe-session`), then PoE from Steam.
# Stop: close the Xwayland window (or `systemctl --user stop poe-session`).
# Logs: journalctl --user -u poe-session
#
# Not declarative (PoE's Proton prefix, Steam compatdata/238960):
#   HKCU\Software\Wine\X11 Driver  GrabPointer=N  (else Wine's pointer grab becomes
#   a niri pointer confinement and the mouse can't leave the window)
#   GrabFullscreen=N is also set there (didn't help on its own; harmless).
{ pkgs, ... }:
let
  displayNum = "2";
  # Rootful Xwayland doesn't resize with its window, so this is the middle Dell's mode
  geometry = "2560x1440";

  poe-session = pkgs.writeShellApplication {
    name = "poe-session";
    runtimeInputs = with pkgs; [
      xwayland
      picom
      openbox
      awakened-poe-trade
      xdotool
      coreutils
      procps
    ];
    text = ''
      marker="$XDG_RUNTIME_DIR/poe-session"
      socket="/tmp/.X11-unix/X${displayNum}"

      Xwayland ":${displayNum}" -geometry ${geometry} &
      xwayland=$!

      # shellcheck disable=SC2317  # only called through the trap
      cleanup() {
        rm -f "$marker"
        # picom, openbox and APT are children of this script
        pkill -P $$ || true
      }
      trap cleanup EXIT

      for _ in $(seq 100); do
        [ -S "$socket" ] && break
        kill -0 "$xwayland" 2>/dev/null || { echo "Xwayland exited" >&2; exit 1; }
        sleep 0.1
      done
      [ -S "$socket" ] || { echo "Xwayland socket $socket never appeared" >&2; exit 1; }

      export DISPLAY=":${displayNum}"
      unset WAYLAND_DISPLAY
      echo "$DISPLAY" > "$marker"

      picom --backend xrender &
      openbox &

      # APT attaches to the game window, so start it once PoE is up
      until xdotool search --class '^steam_app_238960$' >/dev/null 2>&1; do
        kill -0 "$xwayland" 2>/dev/null || exit 0
        sleep 2
      done
      awakened-poe-trade --ozone-platform=x11 &

      # Closing the Xwayland window ends the session
      wait "$xwayland" || true
    '';
  };

  # Steam launch options: /home/dawgora/.local/bin/poe-run gamemoderun mangohud %command%
  # Runs inside Steam's FHS env. Uses the PoE session's X server when it's running,
  # otherwise PoE starts normally on niri (xwayland-satellite).
  poe-run = pkgs.writeShellScript "poe-run" ''
    marker="$XDG_RUNTIME_DIR/poe-session"
    if [ -r "$marker" ]; then
      display=$(cat "$marker")
      if [ -S "/tmp/.X11-unix/X''${display#:}" ]; then
        export DISPLAY="$display"
        unset WAYLAND_DISPLAY
      fi
    fi
    exec "$@"
  '';
in
{
  home.packages = [ poe-session ];

  # Absolute path for Steam's launch options (Steam's FHS env sees $HOME and the store)
  home.file.".local/bin/poe-run".source = poe-run;

  # rofi entry; systemd-run gives it a journal and a clean stop
  xdg.desktopEntries.poe-session = {
    name = "PoE overlay session";
    genericName = "Path of Exile + Awakened PoE Trade";
    exec = "systemd-run --user --collect --unit=poe-session ${poe-session}/bin/poe-session";
    icon = "applications-games";
    terminal = false;
    categories = [ "Game" ];
  };
}
