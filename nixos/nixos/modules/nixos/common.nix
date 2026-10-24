# NixOS settings shared by both hosts. Host files (hosts/<host>/configuration.nix)
# only hold what differs: hardware, GPU, host services, session defaults.
{ inputs, lib, pkgs, systemType, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./unfree.nix
    ../zsh
  ];

  # ── Home Manager ────────────────────────────────────────────────────────
  # The host file sets home-manager.users.dawgora = import ./home.nix
  home-manager = {
    extraSpecialArgs = { inherit inputs systemType; };
    backupFileExtension = "hm-backup";
  };

  # ── Nix / nixpkgs ───────────────────────────────────────────────────────
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    allowed-users = [ "@wheel" ];
  };

  nixpkgs.config.allowUnfree = true;

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

  # ── Boot ────────────────────────────────────────────────────────────────
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
    };
  };

  # ── Locale / time ───────────────────────────────────────────────────────
  time.timeZone = "Europe/Riga";
  time.hardwareClockInLocalTime = true;

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "en_GB.UTF-8/UTF-8"
  ];

  # ── Networking ──────────────────────────────────────────────────────────
  networking.networkmanager.enable = true;
  networking.firewall.trustedInterfaces = [ "virbr0" ];
  services.resolved.enable = true;
  services.openssh.enable = true;

  # ── User ────────────────────────────────────────────────────────────────
  users.defaultUserShell = pkgs.zsh;
  users.users.dawgora = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" "vboxsf" "libvirtd" ];
  };

  # ── Graphics / desktop ──────────────────────────────────────────────────
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vdpauinfo # sudo vainfo
      libva-utils # sudo vainfo
    ];
  };

  services.xserver = {
    enable = true;
    xkb.layout = "lv";
  };
  services.xserver.excludePackages = [ pkgs.xterm ];

  # ly; the default session is set per host
  services.displayManager.ly = {
    enable = true;
    x11Support = false;
    settings = {
      animate = true;
      animation = 0;
    };
  };

  programs.niri = {
    enable = true;
    useNautilus = false;
  };

  programs.sway = {
    enable = true;
    xwayland.enable = true;
    extraOptions = [ "--unsupported-gpu" ];
  };

  xdg.terminal-exec = {
    enable = true;
    settings.default = [ "Alacritty.desktop" ];
  };

  services.gvfs.enable = true;

  # ── Audio / bluetooth ───────────────────────────────────────────────────
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    settings = {
      General.FastConnectable = true;
      Policy.AutoEnable = true;
    };
  };

  # ── Virtualisation / dev services ───────────────────────────────────────
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.swtpm.enable = true;
    };
    spiceUSBRedirection.enable = true;
    docker.enable = true;
  };
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

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

  programs.nix-ld.enable = true; # libraries are added per host
  services.envfs.enable = true;

  # ── Environment ─────────────────────────────────────────────────────────
  environment.pathsToLink = [ "/libexec" ];
  environment.localBinInPath = true;

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    MOZ_DISABLE_RDD_SANDBOX = "1";
    NVD_BACKEND = "direct";
    EGL_PLATFORM = "wayland";
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    vdpauinfo # sudo vainfo
    libva-utils # sudo vainfo
    home-manager
    tmux
    htop
    nix-prefetch-git
    qt5.qtquickcontrols2
    qt5.qtgraphicaleffects
    gparted
    wlogout
    git
    postgresql_jdbc
    openssl
    waybar
    libnotify
    awww
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    font-awesome
    proggyfonts
    swayidle
    sway-audio-idle-inhibit
    grim
    slurp
    wl-clipboard
    alsa-utils
    virt-manager
    virt-viewer
    spice
    spice-protocol
    spice-gtk
    adwaita-icon-theme
    xwayland-satellite
  ];

  fonts.packages = with pkgs; [
    font-awesome
    inter
  ];
}
