{ config, pkgs, lib, ... }:
with lib;

let
  cfg = config.shared.pkgs.cli.calculators;
in {
  options.shared.pkgs.cli.calculators = {
    enable = mkEnableOption "Calculator packages";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Unit Calculators
      rink                  # Unit-aware calculator with currency support

      # Programming Calculators
      programmer-calculator # Terminal calculator for programmers
      bitwise              # Terminal based bitwise calculator in curses

      # Network Calculators
      ipcalc               # Simple IP network calculator

      # General Purpose
      kalker               # Command line calculator with math functions

      # Scientific Computing
      octave               # Scientific Programming Language (MATLAB alternative)
    ];
  };
}
