{ config, pkgs, lib, ... }:
with lib;

let 
  cfg = config.shared.pkgs.cli;
in {
  imports = [
    ./base.nix
    ./dev.nix
    ./calculators.nix
    ./latex.nix
  ];

  options.shared.pkgs.cli = {
    enable = mkEnableOption "CLI packages";
  };

  config = {
    shared.pkgs.cli = {
      base.enable = mkDefault cfg.enable;
      dev.enable = mkDefault cfg.enable;
      calculators.enable = mkDefault cfg.enable;
      latex.enable = mkDefault cfg.enable;
    };
  };
}