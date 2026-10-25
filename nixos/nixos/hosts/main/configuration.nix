# main: stationary PC (AMD CPU, NVIDIA GPU, 3 screens).
# Shared settings live in modules/nixos/common.nix.
{ config, lib, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/common.nix
    ../../modules/steam
  ];

  home-manager.users.dawgora = import ./home.nix;

  networking.hostName = "main";

  # ── Boot / GPU ──────────────────────────────────────────────────────────

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    NVD_BACKEND = "direct";
    MOZ_DISABLE_RDD_SANDBOX = "1";
  };

  # niri wiki (Nvidia): without this the driver keeps freed buffers in niri's
  # heap and niri ends up using ~1 GiB of VRAM instead of ~100 MiB.
  environment.etc."nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer-pool-in-wayland-compositors.json".text =
    builtins.toJSON {
      rules = [
        {
          pattern = {
            feature = "procname";
            matches = "niri";
          };
          profile = "Limit Free Buffer Pool On Wayland Compositors";
        }
      ];
      profiles = [
        {
          name = "Limit Free Buffer Pool On Wayland Compositors";
          settings = [
            {
              key = "GLVidHeapReuseRatio";
              value = 0;
            }
          ];
        }
      ];
    };

  # The daemon only starts for members of the openrazer group
  hardware.openrazer = {
    enable = true; # razer
    users = [ "dawgora" ];
  };

  dawgora.unfreePackages = [ "nvidia-x11" "nvidia-settings" ];

  # ── Session ─────────────────────────────────────────────────────────────
  services.displayManager.defaultSession = "niri";

  services.gnome.gnome-keyring.enable = true;
  security.polkit.enable = true;

  # ── Networking ──────────────────────────────────────────────────────────
  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;

  # ── nix-ld ──────────────────────────────────────────────────────────────
  programs.nix-ld.libraries = [ pkgs.tailwindcss ];

  environment.variables.NIX_LD_LIBRARY_PATH = lib.mkForce (lib.makeLibraryPath [
    pkgs.libsecret
    pkgs.stdenv.cc.cc.lib
    pkgs.glib
    pkgs.dbus
  ]);

  environment.systemPackages = with pkgs; [
    libsecret
    gnome-keyring
    phodav
    wlroots
    libyaml
  ];

  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

  # First NixOS version installed on this machine. Never change it.
  system.stateVersion = "23.11"; # Did you read the comment?
}
