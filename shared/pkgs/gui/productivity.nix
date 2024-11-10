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
      # Office Suite + Spell Checking
      libreoffice-qt           # Office suite
      hunspell                 # Spell checking
      hunspellDicts.de_DE     # German dictionary
      hunspellDicts.en_US     # English dictionary

      # Calculators
      geogebra6                # Math calculator

      # Task Management
      ticktick                # Todo/Task management
      lunatask                # Task management

      # Reference Management
      jabref                        # Reference manager for LaTeX TODO: good fit here?
    ];
  };
}
