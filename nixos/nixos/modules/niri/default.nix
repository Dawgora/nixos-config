{ ... }:
{
  # niri reads exactly one file; we assemble it from fragments so each
  # concern (input, outputs, layout, binds...) lives in its own module
  xdg.configFile."niri/config.kdl".text = builtins.concatStringsSep "\n" [
    (builtins.readFile ./fragments/00-input.kdl)
    (builtins.readFile ./fragments/10-outputs.kdl)
    (builtins.readFile ./fragments/20-layout.kdl)
    (builtins.readFile ./fragments/30-rules.kdl)
    (builtins.readFile ./fragments/40-binds.kdl)
    (builtins.readFile ./fragments/50-startup.kdl)
  ];
}
