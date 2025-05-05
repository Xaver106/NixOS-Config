{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.common.optional.pkgs.gui.productivity;
in
{
  options.common.optional.pkgs.gui.productivity = {
    enable = mkEnableOption "Productivity packages";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Office Suite + Spell Checking
      libreoffice-qt # Office suite
      hunspell # Spell checking
      hunspellDicts.de_DE # German dictionary
      hunspellDicts.en_US # English dictionary

      kdePackages.merkuro # Merkuro is a application suite designed to make handling your emails, calendars, contacts, and tasks simple.

      # Calculators
      geogebra6 # Math calculator
      speedcrunch # A fast power user calculator
      kdePackages.kalgebra # 2D and 3D Graph Calculator
      kdePackages.kcalc # Calculator offering everything a scientific calculator does, and more
      qalculate-qt # Ultimate desktop calculator

      # Task Management
      lunatask # Task management

      # finance Tracking
      mmex # Easy-to-use personal finance software

      # PDF Readers
      sioyek

      # OCR
      ocrmypdf # Adds an OCR text layer to scanned PDF files, allowing them to be searched
      tesseract # OCR engine

      # Markdown Editor
      typora
    ];
  };
}
