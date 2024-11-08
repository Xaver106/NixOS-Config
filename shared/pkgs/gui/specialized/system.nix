{ config, pkgs, lib, ... }:
with lib;

let
  cfg = config.shared.pkgs.gui.specialized.system;
in {
  options.shared.pkgs.gui.specialized.system = {
    enable = mkEnableOption "Specialized system packages";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      rpi-imager     # Raspberry Pi imaging tool
      ventoy-full    # Multiboot USB creator
    ];
  };
}
