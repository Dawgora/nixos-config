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

  networking.hostName = "dawgora";

  # ── Boot / GPU ──────────────────────────────────────────────────────────
  boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics.extraPackages = [ pkgs.nvidia-vaapi-driver ];

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
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  hardware.openrazer.enable = true; # razer
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
