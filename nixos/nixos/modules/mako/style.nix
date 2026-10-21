{ config, ... }:
let
  c = config.lib.stylix.colors.withHashtag;
  f = config.stylix.fonts;
in
{
  xdg.configFile."mako/config".text = ''
    sort=-time
    font=${f.monospace.name} ${toString f.sizes.popups}
    background-color=${c.base00}
    text-color=${c.base05}
    width=420
    margin=12
    padding=14
    border-size=2
    border-color=${c.base0D}
    border-radius=12
    icon-location=left
    max-icon-size=48
    markup=1
    group-by=app-name

    # ignore expiry hints from apps, enforce our own timeout
    ignore-timeout=1
    default-timeout=10000

    [urgency=low]
    border-color=${c.base03}
    default-timeout=5000

    [urgency=normal]
    border-color=${c.base0D}
    default-timeout=10000

    [urgency=critical]
    background-color=${c.base08}
    border-color=${c.base08}
    text-color=${c.base00}
    default-timeout=30000
  '';
}
