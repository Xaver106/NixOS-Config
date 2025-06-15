{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.common.optional.pkgs.gui.system;
in
{
  options.common.optional.pkgs.gui.system = {
    enable = mkEnableOption "Specialized system packages";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      rpi-imager # Raspberry Pi imaging tool
      ventoy-full # Multiboot USB creator
    ];

    # Seems safe so far. Build process uses official binarys from upstream projects.
    nixpkgs.config.permittedInsecurePackages = [
      "ventoy-1.1.05"
    ];
  };
}
