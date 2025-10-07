# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ inputs, config, lib, pkgs, callPackage, ... }:

let
in
  {
    imports =
      [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/nginx
      ../../modules/zsh
      ../../modules/steam
      inputs.home-manager.nixosModules.home-manager
    ];

    home-manager = {
      extraSpecialArgs = {inherit inputs; };
      users = {
        dawgora = import ./home.nix;
      };
    };

    nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"
      "discord"
      "spotify"
      "obsidian"
      "davinci-resolve"
      "obs-studio"
      "steam"
      "plexmediaserver"
      "vscode"
    ];

# bootloader settings
boot.loader = {
  efi.canTouchEfiVariables = true;
  grub = {
    enable = true;
    devices = [ "nodev" ];
    efiSupport = true;
    useOSProber = true;
  };
};

# Experimental

nix.settings.experimental-features = ["nix-command" "flakes"];

services.resolved.enable = true;

# video settings
hardware.graphics = {
  enable = true;
    #driSupport = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vdpauinfo # sudo vainfo
      libva-utils # sudo vainfo
      nvidia-vaapi-driver
    ];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

# razer
hardware.openrazer.enable = true;

# wayland and hyperland
programs.hyprland = {
  enable = true;
  xwayland.enable = true;
};

#services.desktopManager.gnome.enable = true;
#programs.seahorse.enable = true;


services.blueman.enable = true;
hardware.bluetooth = {
  enable = true;
  settings = {
    General = {
      Experimental = true;
      FastConnectable = true;
    };
    Policy = {
      AutoEnable = true;
    };
  };
};

xdg.portal.enable = true;
xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

security = {
  pam = {
    services = {
      dawgora = {
        kwallet = {
          enable = true;
          package = pkgs.kdePackages.kwallet-pam;
        };
      };
    };
  };
};

security.rtkit.enable = true;
services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  jack.enable = true;
};


# virt manager
virtualisation = {
  libvirtd = {
    enable = true;
    qemu = {
      swtpm.enable = true;
      ovmf.enable = true;
      ovmf.packages = [pkgs.OVMFFull.fd];
    };
  };
  spiceUSBRedirection.enable = true;
};

#programs.virt-manager.enable = true;

services.qemuGuest.enable = true;
services.spice-vdagentd.enable = true;

# docker
virtualisation.docker.enable = true;
# shell settings

users.defaultUserShell = pkgs.zsh;

networking.hostName = "dawgora"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  networking.firewall.trustedInterfaces = [ "virbr0" ];

  # Set your time zone.
  time.timeZone = "Europe/Riga";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  environment.pathsToLink = [ "/libexec" ];

  services.xserver = {
    enable = true;

    videoDrivers = ["nvidia"];
    xkb.layout = "lv";
  };

  services.displayManager = {
    defaultSession = "hyprland";
    sddm.enable = true;
    sddm.theme = "${import ../../modules/sddm/sddm-theme.nix { inherit pkgs; }}";
    sddm.autoNumlock = true;
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  #sound.enable = true;
  #hardware.pulseaudio.enable = true;

  nix.settings.allowed-users = [ "@wheel" ];

  # Enable touchpad support (enabled default in most delibvirtdsktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dawgora = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" "vboxsf" "libvirtd"];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    vdpauinfo # sudo vainfo
    libva-utils # sudo vainfo
    home-manager
    tmux
    htop
    nix-prefetch-git
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
    gparted
    wlogout
    netbird-ui
    netbird
    git
    postgresql_jdbc
    openssl
    waybar
    mako
    libnotify
    rofi-wayland
    swww
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    font-awesome
    proggyfonts
    swaylock
    swayidle
    sway-audio-idle-inhibit
    grim
    slurp
    wl-clipboard
    alsa-utils
    rose-pine-hyprcursor
    virt-manager
    virt-viewer
    spice
    spice-protocol
    spice-gtk
    adwaita-icon-theme
  ];

  fonts.packages = with pkgs; [
    font-awesome
    inter
  ];

 #environment.extraInit = ''
 #  xset dpms 300 300 300
 #'';

 environment.localBinInPath = true;

 environment.sessionVariables = {
   WLR_NO_HARDWARE_CURSORS = "1";
   NIXOS_OZONE_WL = "1";
   MOZ_DISABLE_RDD_SANDBOX = "1";
   LIBVA_DRIVER_NAME = "nvidia";
   GBM_BACKEND = "nvidia-drm";
   __GLX_VENDOR_LIBRARY_NAME = "nvidia";
   NVD_BACKEND = "direct";
   EGL_PLATFORM = "wayland";
 };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # all services
  services.envfs.enable = true;

  # TIME
  time.hardwareClockInLocalTime = true;

  # NETBIRD
  services.netbird.enable = true;

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;
    enableTCPIP = true;
    settings.port = 5432;
    authentication = lib.mkForce ''
    local all all              trust
    host  all all 127.0.0.1/32 trust
    host  all all ::1/128      trust
    '';
  };


  services.plex = {
    enable = true;
    openFirewall = true;
    user="dawgora";
    package = (pkgs.plex.override {
      plexRaw = pkgs.plexRaw.overrideAttrs (old: rec {
        pname = "plexmediaserver";
        version = "1.42.1.10060-4e8b05daf"; 
        src = pkgs.fetchurl {
          url = "https://downloads.plex.tv/plex-media-server-new/1.42.1.10060-4e8b05daf/debian/plexmediaserver_1.42.1.10060-4e8b05daf_amd64.deb";
          hash = "sha256:1x4ph6m519y0xj2x153b4svqqsnrvhq9n2cxjl50b9h8dny2v0is";  
        };
        passthru = old.passthru // { inherit version; };
      });
    });

  };

  systemd.services.plex.serviceConfig.ProtectHome = lib.mkForce false; 

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

  nixpkgs.overlays = [
    (self: super: { 
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
      flameshot = super.flameshot.overrideAttrs (oldAttrs: {
        enableWlrSupport = true;
      });
    })	
  ];

  nixpkgs.config.allowUnfree = true;

}

