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
  };
}
