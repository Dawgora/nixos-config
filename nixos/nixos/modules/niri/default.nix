{ config, ... }:
let
  c = config.lib.stylix.colors.withHashtag;
  cursor = config.stylix.cursor;

  # Fill @placeholders@ in a KDL fragment from the Stylix palette
  themed = file:
    builtins.replaceStrings
      [ "@accent@" "@inactive@" "@urgent@" ]
      [ c.base0D   c.base03     c.base08   ]
      (builtins.readFile file);
in
{
  # niri reads exactly one file; we assemble it from fragments so each
  # concern (input, outputs, layout, binds...) lives in its own module
  xdg.configFile."niri/config.kdl".text = builtins.concatStringsSep "\n" [
    (builtins.readFile ./fragments/00-input.kdl)
    (builtins.readFile ./fragments/10-outputs.kdl)
    (themed ./fragments/20-layout.kdl)
    (builtins.readFile ./fragments/30-rules.kdl)
    (builtins.readFile ./fragments/40-binds.kdl)
    (builtins.readFile ./fragments/50-startup.kdl)
    # niri passes these to every app it starts as XCURSOR_THEME / XCURSOR_SIZE
    ''
      cursor {
          xcursor-theme "${cursor.name}"
          xcursor-size ${toString cursor.size}
      }
    ''
  ];
}
