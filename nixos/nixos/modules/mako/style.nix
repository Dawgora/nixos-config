{ ... }:
{
  xdg.configFile."mako/config".text = ''
    sort=-time
    font=JetBrainsMono Nerd Font 11
    background-color=#1a1a1a
    text-color=#fdf6e3
    width=420
    margin=12
    padding=14
    border-size=2
    border-color=#268bd2
    border-radius=12
    icon-location=left
    max-icon-size=48
    markup=1
    group-by=app-name

    # The fix for your eternal notifications:
    # ignore expiry hints from apps, enforce our own timeout
    ignore-timeout=1
    default-timeout=10000

    [urgency=low]
    border-color=#586e75
    default-timeout=5000

    [urgency=normal]
    border-color=#268bd2
    default-timeout=10000

    [urgency=critical]
    background-color=#dc322f
    border-color=#dc322f
    text-color=#ffffff
    default-timeout=30000
  '';
}
