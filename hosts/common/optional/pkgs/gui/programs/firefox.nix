{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.common.optional.pkgs.gui.programs.firefox;
in
{
  options.common.optional.pkgs.gui.programs.firefox = {
    enable = mkEnableOption "Firefox";
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      firefox
      librewolf
    ];

    # Additional configuration
    programs.firefox = {
      enable = true;
      preferences = {
        "widget.use-xdg-desktop-portal.file-picker" = 1; # force KDE Filepicker
      };
      wrapperConfig = {
        pipewireSupport = true;
      };
    };

  };
}
