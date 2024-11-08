{ config, pkgs, lib, ... }:
with lib;

let
  cfg = config.shared.pkgs.gui.productivity;
in {
  options.shared.pkgs.gui.productivity = {
    enable = mkEnableOption "Productivity packages";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Office Suite
      libreoffice-qt           # Office suite

      # Spell Checking
      hunspell                 # Spell checking
      hunspellDicts.de_DE     # German dictionary
      hunspellDicts.en_US     # English dictionary

      # Task Management
      ticktick                # Todo/Task management
      lunatask                # Task management
    ];
  };
}
