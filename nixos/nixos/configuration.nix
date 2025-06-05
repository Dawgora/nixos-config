# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ inputs, config, lib, pkgs, callPackage, ... }:

let
  #screen-script = import ./screen-script.nix { inherit pkgs; };
  #unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
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

  programs.steam.enable = true;

  services.blueman.enable = true;
  hardware.bluetooth.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };


# virt manager
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  programs.virt-manager.enable = true;

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
    
    desktopManager = {
      xterm.enable = true;
      wallpaper.mode = "fill";
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
        i3blocks
        networkmanagerapplet
      ];
    };
  };
  
    services.displayManager = {
      defaultSession = "none+i3";
      sddm.enable = true;
      sddm.theme = "${import ./sddm-theme.nix { inherit pkgs; }}";
      sddm.autoNumlock = true;
    };

   #services.xserver.displayManager.setupCommands = ''${screen-script}/bin/screen-script'';


  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

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
  ];

  fonts.packages = with pkgs; [
   font-awesome
   inter
   #nerd-fonts
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

  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      zsh-autoenv.enable = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
           "git"
           "npm"
           "history"
           "node"
           "rust"
           "deno"
    	   "tig"
           "tmux"
           "mix"
           "nmap"
         ];
      };
    };
  };

  # List services that you want to enable:

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
  };

  systemd.services.plex.serviceConfig.ProtectHome = lib.mkForce false; 

  # Nginx Reverse SSL Proxy
  services.nginx = {
    enable = true;
  # give a name to the virtual host. It also becomes the server name.
    virtualHosts."local.plex.tld" = {
    # Since we want a secure connection, we force SSL
    forceSSL = true;

    # http2 can more performant for streaming: https://blog.cloudflare.com/introducing-http2/
    http2 = true;

    # Provide the ssl cert and key for the vhost
    sslCertificate = "/etc/nixos/ssl/cert.pem";
    sslCertificateKey = "/etc/nixos/ssl/key.pem";
    extraConfig = ''

      #Some players don't reopen a socket and playback stops totally instead of resuming after an extended pause
      send_timeout 100m;

      # Why this is important: https://blog.cloudflare.com/ocsp-stapling-how-cloudflare-just-made-ssl-30/
      ssl_stapling on;
      ssl_stapling_verify on;

      ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
      ssl_prefer_server_ciphers on;
      #Intentionally not hardened for security for player support and encryption video streams has a lot of overhead with something like AES-256-GCM-SHA384.
      ssl_ciphers 'ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-AES256-SHA:ECDHE-RSA-DES-CBC3-SHA:ECDHE-ECDSA-DES-CBC3-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:AES:CAMELLIA:DES-CBC3-SHA:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!MD5:!PSK:!aECDH:!EDH-DSS-DES-CBC3-SHA:!EDH-RSA-DES-CBC3-SHA:!KRB5-DES-CBC3-SHA';

      # Forward real ip and host to Plex
      proxy_set_header X-Real-IP $remote_addr;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header X-Forwarded-Proto $scheme;
      proxy_set_header Host $server_addr;
      proxy_set_header Referer $server_addr;
      proxy_set_header Origin $server_addr; 

      # Plex has A LOT of javascript, xml and html. This helps a lot, but if it causes playback issues with devices turn it off.
      gzip on;
      gzip_vary on;
      gzip_min_length 1000;
      gzip_proxied any;
      gzip_types text/plain text/css text/xml application/xml text/javascript application/x-javascript image/svg+xml;
      gzip_disable "MSIE [1-6]\.";

      # Nginx default client_max_body_size is 1MB, which breaks Camera Upload feature from the phones.
      # Increasing the limit fixes the issue. Anyhow, if 4K videos are expected to be uploaded, the size might need to be increased even more
      client_max_body_size 100M;

      # Plex headers
      proxy_set_header X-Plex-Client-Identifier $http_x_plex_client_identifier;
      proxy_set_header X-Plex-Device $http_x_plex_device;
      proxy_set_header X-Plex-Device-Name $http_x_plex_device_name;
      proxy_set_header X-Plex-Platform $http_x_plex_platform;
      proxy_set_header X-Plex-Platform-Version $http_x_plex_platform_version;
      proxy_set_header X-Plex-Product $http_x_plex_product;
      proxy_set_header X-Plex-Token $http_x_plex_token;
      proxy_set_header X-Plex-Version $http_x_plex_version;
      proxy_set_header X-Plex-Nocache $http_x_plex_nocache;
      proxy_set_header X-Plex-Provides $http_x_plex_provides;
      proxy_set_header X-Plex-Device-Vendor $http_x_plex_device_vendor;
      proxy_set_header X-Plex-Model $http_x_plex_model;

      # Websockets
      proxy_http_version 1.1;
      proxy_set_header Upgrade $http_upgrade;
      proxy_set_header Connection "upgrade";

      # Buffering off send to the client as soon as the data is received from Plex.
      proxy_redirect off;
      proxy_buffering off;
    '';
    locations."/" = {
      proxyPass = "http://plex.domain.tld:32400/";
    };
  };
  };

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

