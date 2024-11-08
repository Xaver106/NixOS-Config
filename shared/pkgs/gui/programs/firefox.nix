{ config, pkgs, lib, ... }:
with lib;

let
  cfg = config.shared.pkgs.gui.programs.firefox;
in {
  options.shared.pkgs.gui.programs.firefox = {
    enable = mkEnableOption "Firefox";
  };

  config = mkIf cfg.enable {
    # Package installation
    environment.systemPackages = with pkgs; [
      firefox
    ];

    # Additional configuration
    programs.firefox = {
      enable = true;
      preferences = {
        "widget.use-xdg-desktop-portal.file-picker" = 1;
      };
      wrapperConfig = {
        pipewireSupport = true;
      };
    };

    # Make Firefox use the KDE file picker.
    # Preferences source: https://wiki.archlinux.org/title/firefox#KDE_integration
    environment.sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
    };
  };
}
