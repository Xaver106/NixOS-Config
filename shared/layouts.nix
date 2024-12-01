{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.shared.layouts;
in
{

  options.shared.layouts = {
    enable = mkEnableOption "install custom keyboard layouts";
  };

  config = mkIf cfg.enable {

    services.xserver.xkb.extraLayouts = {
      noted = {
        description = "noted"; # KDE uses this as the name for some reason
        languages = [
          "de"
          "eng"
        ];
        symbolsFile = ./layouts/noted;
      };
    };

  };
}
