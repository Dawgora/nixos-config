# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];
  boot.supportedFilesystems = [ "ntfs" ];
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/ad5a1717-ba3b-464e-8957-2d950cca711b";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/262D-3038";
      fsType = "vfat";
    };

  fileSystems."/mnt/hdd" = 
  {
    device = "/dev/disk/by-uuid/38c9954d-2bff-4d67-903b-68c6f71f1e60";
    fsType = "ext4";
  };

  fileSystems."/mnt/windows_game_dir" = {
    device = "/dev/disk/by-uuid/3406543B06540072";
    fsType = "ntfs";
  };

  fileSystems."/mnt/old_ssd" = 
  {
    device = "/dev/disk/by-uuid/3599a014-15f9-4d3c-aa8e-71dbf4724a1a";
    fsType = "ext4";
  };



  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp7s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp8s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp6s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
