{ inputs, pkgs, config, lib, ... }:
let
  fonts = config.stylix.fonts;
in
{
  imports = [ inputs.stylix.homeModules.stylix ];

  stylix = {
    enable = true;
    autoEnable = false; # opt in per target; our own modules read the palette
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    # The base16 port maps red/orange/yellow/blue to the wrong colours; use Tokyo Night's own.
    override = {
      base08 = "f7768e"; # red
      base09 = "ff9e64"; # orange
      base0A = "e0af68"; # yellow
      base0D = "7aa2f7"; # blue (accent)
      base0F = "d18616"; # brown (base0F was a second red)
      base0C = "7dcfff";
    };

    fonts = {
      sansSerif = { package = pkgs.inter; name = "Inter"; };
      serif = { package = pkgs.noto-fonts; name = "Noto Serif"; };
      monospace = { package = pkgs.nerd-fonts.jetbrains-mono; name = "JetBrainsMono Nerd Font"; };
      emoji = { package = pkgs.noto-fonts-color-emoji; name = "Noto Color Emoji"; };
      sizes = {
        applications = 11;
        desktop = 11;
        popups = 11;
        terminal = 14;
      };
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 20;
    };

    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };

    targets = {
      gtk.enable = true;           # adw-gtk3 + gtk.css for GTK3 and libadwaita
      qt.enable = true;            # qtct + Base16Kvantum
      fontconfig.enable = true;    # sans/serif/mono/emoji defaults
      font-packages.enable = true; # installs the fonts above for the user
    };
  };

  # HM only writes the fontconfig defaults when this is on
  fonts.fontconfig.enable = true;

  # Electron/Chromium (Bitwarden, Discord, …) and some GTK3 apps fall back to the
  # GTK theme name / prefer-dark flag when they can't read the portal's color-scheme.
  # Stylix sets plain "adw-gtk3"; its colours come from gtk.css either way.
  gtk.theme.name = lib.mkForce "adw-gtk3-dark";
  gtk.gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;

  # Stylix's gtk target doesn't set these. libadwaita reads them via the portal.
  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
    monospace-font-name = "${fonts.monospace.name} ${toString fonts.sizes.applications}";
    document-font-name = "${fonts.sansSerif.name} ${toString fonts.sizes.applications}";
  };
}
