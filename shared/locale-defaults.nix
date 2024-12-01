{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.shared.locale-defaults;
in
{

  options.shared.locale-defaults = {
    enable = mkEnableOption "localisation";
  };

  config = mkIf cfg.enable {

    time.timeZone = "Europe/Berlin";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "de";
      variant = "";
    };
    console.keyMap = "de"; # Configure console keymap
  };
}
